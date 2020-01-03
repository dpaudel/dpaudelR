#' NOT in operator
#'
#' This function negates the impact of %in%
#'
#' 
#' @return Not in
#' @export

'%!in%' <- function(x,y)!('%in%'(x,y))
