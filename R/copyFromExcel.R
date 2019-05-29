#` Copy From excel 
#'
#' This function copies a data frame from Excel 
#' 
#' @export

copyFromExcel <- function(header=TRUE,...) {
  read.table("clipboard",sep="\t",header=header,...)
}

#usage: data=copyFromExcel()
