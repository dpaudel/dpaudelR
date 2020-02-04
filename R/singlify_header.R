
# input: rows to skip, number of header rows
nheaders=2
nskip =2
filename = 'Griffin_20200204/SCRI II Bermudagrass SSPN Griffin Final.xlsx'
singlify_header <- function (filename, nheaders, nskip){
headers <- read_excel(filename, col_names = FALSE, na="..", n_max = nheaders, skip=nskip)

# fill only works down or up, so have to transpose headers
long_headers = data.frame(t(headers))
# Add column names down the columns
#long_headers <- fill(long_headers,1:nheaders) # all four columns
headers <- data.frame(t(long_headers)) # back to vertical.

# summarize using str_c from stringr which collapses strings.
# summarize_all makes it work on all columns.
column_labels <- headers %>% summarize_all(str_c, collapse = "_")

# pull them into one character vector
headers = c(unname(unlist(column_labels[1,])))
return(headers)
}
