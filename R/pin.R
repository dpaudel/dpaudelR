#' Approximate standard errors for linear functions of variance components
#' 
#' \code{pin} Modified from library nadiv.
#'
#' \description
#' This function is similar to the pin calculations performed by the standalone ASReml. 
#' This function, written by Ian White, applies the delta method for the estimation of 
#' approximate standard errors on linear functions of variance components from a REML 
#' mixed model.
#'
#' \usage
#' pin(object, transform)
#' 
#' @param object A list with at least the following elelemtns,: gammas, gammas.type, and ai from a REML mixed model
#' @param transform A formula specifying the linear transformation of variance components to conduct
#'
#' @examples
#' data(oats)
#' oats.asr <- asreml(yield ~ Variety*Nitrogen, 
#'                    random = ~ Blocks/Wplots, data=oats)
#' summary(oats.asr)$varcomp
#' pin(oats.asr,r2~V1/(V1+V2+V3))
#' pin(oats.asr,r2~sqrt(V1/V3))

pin <- function(object, transform) {
  #pframe <- as.list(object$gammas)
  pframe <- as.list(object$vparameters)
  names(pframe) <- paste("V", seq(1, length(pframe)), sep = "")
  tvalue <- eval(deriv(transform[[length(transform)]], names(pframe)), 
                 pframe)
  X <- as.vector(attr(tvalue, "gradient"))
  #X[object$gammas.type == 1] <- 0
  X[object$vparameters.type == 1] <- 0
  tname <- if (length(transform) == 3) 
    transform[[2]]
  else ""
  n <- length(pframe)
  i <- rep(1:n, 1:n)
  j <- sequence(1:n)
  k <- 1 + (i > j)
  Vmat <- object$ai
  Vmat <- Vmat[upper.tri(Vmat,diag=TRUE)]
  se <- sqrt(sum(Vmat * X[i] * X[j] * k))
  return(data.frame(row.names = tname, Estimate = tvalue, SE = se))
}