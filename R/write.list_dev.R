
#### Function to write output of a list ####
# modified from erer package
# usage
# top <- list(top_line1,top_line2, line1, line2, line3, line4, line5)
# write.list_dev(file="test1.loc", top, col.names = F, row.names = T, quote = F)
#####################

write.list_dev <- function (z, file, t.name = NULL, row.names = FALSE, ...) 
{
  if (!inherits(z, "list")) 
    stop("\nNeed an 'list' object.\n")
  if (is.null(t.name)) {
    if (is.null(names(z))) {
      add.name <- paste("result.", 1:length(z), sep = "")
    }
    else {
      add.name <- names(z)
    }
  }
  else {
    if (length(t.name) != length(z)) {
      stop("\n 't.name' and 'z' should have the same length.\n")
    }
    else {
      add.name <- t.name
    }
  }
  options(warn = -1)
  for (k in 1:length(z)) {
    dat <- as.data.frame(z[[k]])
    if (row.names) {
      h2 <- as.data.frame(cbind(Result = dat))
    }
    else {
      h2 <- as.data.frame(cbind(Result = dat))
    }
    h3 <- rbind(apply(h2, 2, as.character), "")
    ap <- ifelse(k == 1, FALSE, TRUE)
    write.table(x = h3, file = file, sep = "\t", append = ap, 
                row.names = FALSE, ...)
  }
  options(warn = 0)
}
