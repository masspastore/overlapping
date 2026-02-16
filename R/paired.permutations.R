
#rm(list=ls())
#n <- 5
#x <- list( x1 = rnorm(n), x2 = rnorm(n) )

paired.permutations <- function( x ) {
  
  if (length(x[[1]]) != length(x[[2]])) {
    stop("Paired data must have the same length.")
  }
  S <- matrix( cbind( x[[1]], x[[2]]), ncol = 2 )
  n <- nrow(S)
  scambia <- sample(0:1,n,replace = TRUE )

  for (i in 1:nrow(S)) {
    if (scambia[i] == 1 ){
      tram <- S[i,1]
      S[i,1] <- S[i,2]
      S[i,2] <- tram
    }   
  }

  xList <- list( S[,1], S[,2] )
  return( xList )
  
}

#z <- paired.permutations( x )
#cbind( x[[1]], x[[2]] )
#cbind( z[[1]], z[[2]] )

