#' NOT in operator
#'
#' This function negates the impact of %in%
#'
#' 
#' @export

'%notin%' <- function(x,y)!('%in%'(x,y))
