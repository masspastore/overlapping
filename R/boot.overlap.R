#' Nonparametric Bootstrap for overlapping index
#' 
#' @param x list of numeric vectors
#' @param B integer, number of bootstrap draws
#' @param ... options see function overlap 
#' 
#' @return \item{OVboot_stats} = data frame 
#' @return \item{OVboot_dist} = matrix 
#' @example 
#' B = 20
#' x <- list( x1 = 1:10, x2 = 5:8, x3 = 2:9 )
#' x <- list( x1 = 1:10, x2 = 5:8 )
boot.overlap <- function( x, B = 1000, ... ) {
  out <- overlap( x, ... )$OV 
  
  outb <- t(sapply(1:B, function(b){
    xb <- lapply( x, FUN = sample, replace = TRUE )
    out2 <- overlap( xb )$OV
  }))
  
  if (nrow(outb)>1) {
    bias <- apply(outb,2,mean) - out
    se <- apply(outb,2,sd) 
  } else {
    bias <- mean(outb) - out
    se <- sd(outb)
  }
  
  OVboot <- data.frame(estOV=out,bias=bias,se=se)
  return(list(OVboot_stats=OVboot,OVboot_dist=outb))
}

#' @examples 
#' set.seed(20150605)
#' x <- list(X1=rnorm(100), X2=rt(50,8), X3=rchisq(80,2))
#' out <- overlap(x, plot=TRUE)
#' out$OV
#' out <- boot.overlap( x, B = 10 )
#' out$OVboot_stats
#' 
#' x <- list(X1=rnorm(100), X2=rt(50,8))
#' out <- boot.overlap( x, B = 10 )
#' out$OVboot_stats
#' apply( out$OVboot_dist, 2, quantile, probs = c(.05, .9) )
#' Y <- stack( data.frame( out$OVboot_dist ))
#' ggplot( Y, aes( values )) + facet_wrap( ~ind ) + geom_density()
#' 