#` Singlify header
#'
#' This function merges headers in multiple rows to a single row. 
#' 
#' @export
#' input: "filename", number of rows to skip, number of rows of header
#' example: singlify_header('Griffin_20200204/SCRI II Bermudagrass SSPN Griffin Final.xlsx', nskip=2,nheaders=4)

singlify_header <- function (filename, nheaders, nskip){
headers <- read_excel(filename, col_names = FALSE, na="..", n_max = nheaders, skip=nskip)

# fill only works down or up, so have to transpose headers
long_headers = data.frame(t(headers))

# merge headers 
merged_header <- apply(long_headers, 1, paste, collapse="_")
# merged_header <- apply(long_headers[,c(2,1)], 1, paste, collapse="_") # bring column 2 name in the front
merged_header1 <- make.names(merged_header, unique=TRUE)
# Add column names down the columns
#long_headers <- fill(long_headers,1:nheaders) # all four columns
headers <- data.frame(t(merged_header1)) # back to vertical.

# summarize using str_c from stringr which collapses strings.
# summarize_all makes it work on all columns.
column_labels <- headers %>% summarize_all(str_c, collapse = "_")

# pull them into one character vector
headers = c(unname(unlist(column_labels[1,])))
return(headers)
}
