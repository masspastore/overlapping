#rm(list=ls())
#x <- list( x1=rnorm(19), x2=rnorm(25,.5,2), x3=rchisq(21,4) )

perm.pairs <- function(x) {
  
  ## gestione nomi 
  if (is.null(names(x))) names(x) <- paste("Y", 1:length(x), sep = "")
  
  N <- unlist( lapply(x,length) )
  XListPerm <- list()
  NAMES <- NULL
  LABELS <- names(x)
  
  for (i in 1:(length(x)-1)) {
    for (j in (i+1):length(x)) {
      #cat(paste( i, j ),"\n")
      
      xperm <- sample( unlist(x[c(i,j)]) )
      xListperm <- list( xperm[1:N[i]], xperm[(N[i]+1):(length(xperm))] )
      names(xListperm) <- LABELS[c(i,j)]
      NAMES <- c(NAMES, paste0(LABELS[c(i,j)], collapse = ".")) ## nomi
      
      XListPerm <- c( XListPerm, list(xListperm) )
      
    }
  }
  
  names(XListPerm) <- NAMES
  return(XListPerm)
}


#perm.pairs(x)
