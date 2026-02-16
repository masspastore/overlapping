
#rm(list=ls())
#source("~/MEGA/lavori/Rdevel/overlapping_2.4/R/paired.permutations.R")

#n <- 3
#x <- list( x1=rnorm(n), x2=rnorm(n,.5,2), x3=rchisq(n,4) )
#i <- 1; j <- 2
#paired <- TRUE


perm.pairs <- function(x, paired = FALSE ) {
  
  ## gestione nomi 
  if (is.null(names(x))) names(x) <- paste("Y", 1:length(x), sep = "")
  
  N <- unlist( lapply(x,length) )
  XListPerm <- list()
  NAMES <- NULL
  LABELS <- names(x)
  
  for (i in 1:(length(x)-1)) {
    for (j in (i+1):length(x)) {
      #cat(paste( i, j ),"\n")
      
      if (paired) {
        xListperm <- paired.permutations( x[c(i,j)] )
      } else {
        xperm <- sample( unlist(x[c(i,j)]) )
        xListperm <- list( xperm[1:N[i]], xperm[(N[i]+1):(length(xperm))] )
      }
      
      names(xListperm) <- LABELS[c(i,j)]
      NAMES <- c(NAMES, paste0(LABELS[c(i,j)], collapse = ".")) ## nomi
      
      XListPerm <- c( XListPerm, list(xListperm) )
      
    }
  }
  
  names(XListPerm) <- NAMES
  return(XListPerm)
}

#z <- perm.pairs(x, paired = TRUE )

#cbind( x[[1]], x[[2]] )
#cbind( z[[1]][[1]], z[[1]][[2]] )

#cbind( x[[1]], x[[3]] )
#cbind( z[[2]][[1]], z[[2]][[2]] )

#cbind( x[[2]], x[[3]] )
#cbind( z[[3]][[1]], z[[3]][[2]] )

