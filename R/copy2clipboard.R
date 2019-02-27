#` Copy to excel 
#'
#' This function copies a data frame to excel
#' 
#' @export
copy2clipboard <- function(df, sep="\t", dec=".", max.size=(200*1000)){
  # Copy a data.frame to clipboard
  write.table(df, paste0("clipboard-", formatC(max.size, format="f", digits=0)), sep=sep, row.names=TRUE, col.names=NA, dec=dec)
}
#usage: copy2clipboard(df) and then Ctrl+V to paste
