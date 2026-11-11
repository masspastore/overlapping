# check missing
check.missing <- function(x) {
  n.missing <- sum(unlist(lapply(x,function(x){sum(is.na(x))})))
  if (n.missing>0) {
    warning("NAs removed from x")
    x <- lapply(x, na.omit)
  }
  return(x)
}
