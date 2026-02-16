
#rm(list = ls())
#source("~/MEGA/lavori/Rdevel/overlapping_2.4/R/overlap.R")
#source("~/MEGA/lavori/Rdevel/overlapping_2.4/R/ovmult.R")
#source("~/MEGA/lavori/Rdevel/overlapping_2.4/R/perm.pairs.R")
#source("~/MEGA/lavori/Rdevel/overlapping_2.4/R/paired.permutations.R")

#set.seed(1)
#xList <- list(rnorm(4),rnorm(4),rchisq(4,3))
#B <- 3
#x <- xList
#paired <- TRUE

# ++++++++++++++++++++++++++++
#' @name perm.test
#' @description Esegue test di permutazione su overlapping
#' @param x = lista di due elementi (\code{x1} e \code{x2} ) 
#' @param B = numero di permutazioni da effettuare
#' @return Restituisce una lista con tre elementi:
#' obs = valore osservato di non-sovrapposizione 
#'       \coed{1-eta}
#' perm = valori della stessa statistica ottenute
#'        via permutazione
#' pval = p-value   
perm.test <- function (x, paired = FALSE, B = 1000, 
               return.distribution = FALSE, ...)
{
  
  # control 
  args <- c(as.list(environment()), list(...))
  pairsOverlap <- ifelse(length(x)==2, FALSE, TRUE)
  
  N <- unlist( lapply(x,length) )
  out <- overlap(x, ...)
  #out <- overlap(x) # TEST
  
  if (pairsOverlap) {
    zobs <- 1-out$OVPairs
    Zperm <- t(sapply(1:B, function(b) {
      xListperm <- perm.pairs( x, paired = paired )
      ovperm <- unlist( lapply(xListperm, overlap, ...) )
      zperm <- 1 - ovperm
    }))
  } else {
    zobs <- 1-out$OV
    
    if (paired) {
      Zperm <- t(sapply( 1:B, function(b) {
        xListperm <- paired.permutations( x )
        zperm <- 1 - overlap( xListperm, ... )$OV
        #zperm <- 1 - overlap( xListperm )$OV # TEST
      }))
    } else {
      Zperm <- t(sapply(1:B, function(b) {
        xperm <- sample( unlist( x ) )
        xListperm <- list( x1 = xperm[1:N[1]], x2 = xperm[(N[1]+1):(sum(N))] )      
        zperm <- 1 - overlap( xListperm, ... )$OV
      }))
    }
  }

  colnames(Zperm) <- gsub("\\.OV","",colnames(Zperm))
  if (nrow(Zperm) > 1) {
    
    ZOBS <- matrix( zobs, nrow(Zperm), ncol(Zperm), byrow = TRUE )
    pval <- (apply( Zperm > ZOBS, 2, sum ) + 1) / (nrow(Zperm)+1)
    
  } else {
    pval <- (sum(Zperm > zobs)+1) / (length(Zperm)+1)
  }
  
  if (return.distribution) {
    return(list(Zobs = zobs, pval = pval, Zperm = Zperm))
  } else {
    return(list(Zobs = zobs, pval = pval))  
  }
  
  
}

# perm.test(xList,B=10,paired = TRUE)
