#' here
#'
#' This function sets setwd on current file location
#'
#' 
#' @export
# 
here  <- function(){
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  }

