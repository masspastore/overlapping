
#rm(list = ls())
#source("/home/kolmogorov/MEGAsync/lavori/Rdevel/overlapping2.2/R/overlap.R")
#source("/home/kolmogorov/MEGAsync/lavori/Rdevel/overlapping2.2/R/ovmult.R")
#source("/home/kolmogorov/MEGAsync/lavori/Rdevel/overlapping2.2/R/final.plot.R")
#xList <- list(rnorm(10),rnorm(12),rchisq(20,3))
#B <- 10

# ++++++++++++++++++++++++++++
#' @name perm.test
#' @description Esegue test di permutazione su overlapping, 
#'differenza tra medie e rapporto tra varianze
#' @param x = lista di due elementi (\code{x1} e \code{x2} ) 
#' @param B = numero di permutazioni da effettuare
#' @return Restituisce una lista con tre elementi:
#' obs = valore osservato di non-sovrapposizione 
#'       \coed{1-eta}
#' perm = valori della stessa statistica ottenute
#'        via permutazione
#' pval = p-value   
perm.test <- function (x, B = 1000, 
               return.distribution = FALSE, ...)
{
  
  # control 
  args <- c(as.list(environment()), list(...))
  pairsOverlap <- ifelse(length(x)==2, FALSE, TRUE)
  
  N <- unlist( lapply(x,length) )
  out <- overlap(x, ...)
  
  if (pairsOverlap) {
    zobs <- 1-out$OVPairs
    Zperm <- t(sapply(1:B, function(b) {
      xListperm <- perm.pairs( x )
      ovperm <- unlist( lapply(xListperm, overlap, ...) )
      zperm <- 1 - ovperm
    }))
  } else {
    zobs <- 1-out$OV
    Zperm <- t(sapply(1:B, function(b) {
      xperm <- sample( unlist( x ) )
      xListperm <- list( x1 = xperm[1:N[1]], x2 = xperm[(N[1]+1):(sum(N))] )      
      zperm <- 1 - overlap( xListperm, ... )$OV
    }))
  }
  
  
  ## (sum( zperm >= obsz ) +1) / (length( zperm )+1) LIVIO
  
  colnames(Zperm) <- gsub("\\.OV","",colnames(Zperm))
  if (nrow(Zperm) > 1) {
    
    ZOBS <- matrix( zobs, nrow(Zperm), ncol(Zperm), byrow = TRUE )
    pval <- apply( Zperm > ZOBS, 2, sum )/nrow(Zperm)
    
  } else {
    pval <- sum(Zperm > zobs) / length(Zperm)
  }
  
  if (return.distribution) {
    return(list(Zobs = zobs, pval = pval, Zperm = Zperm))
  } else {
    return(list(Zobs = zobs, pval = pval))  
  }
  
  
}

#perm.test(xList,B=10)
