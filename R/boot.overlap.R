
#rm( list = ls() )
#source( "/home/cox/MEGA/lavori/Rdevel/overlapping_2.3/R/overlap.R" )
#source( "/home/cox/MEGA/lavori/Rdevel/overlapping_2.3/R/ovmult.R" )

#x <- list(X1=rnorm(100), X2=rt(50,8) ) #, X3=rchisq(80,2))
#B <- 10; pairsOverlap = FALSE

boot.overlap <- function (x, B = 1000, pairsOverlap = FALSE, ...)
{
  dots <- list(...)
  density_params <- formals(density)
  density_args <- modifyList(density_params, dots)
  density_args <- density_args[names(density_args)!="..."]
  
  # control 
  if (length(x) == 2 & pairsOverlap == TRUE) pairsOverlap <- FALSE
  
  out <- do.call(overlap, c(list(x), density_args))
  
  if (pairsOverlap) {
    out <- out$OVPairs
    outb <- t(sapply(1:B, function(b) {
      xb <- lapply(x, FUN = sample, replace = TRUE)
      out2 <- do.call(overlap, c(list(xb), density_args))$OVPairs
    }))
  } else {
    out <- out$OV
    outb <- t(sapply(1:B, function(b) {
      xb <- lapply(x, FUN = sample, replace = TRUE)
      out2 <- do.call(overlap, c(list(xb), density_args))$OV
    }))
  }  
  
  if (nrow(outb) > 1) {
    bias <- apply(outb, 2, mean) - out
    se <- apply(outb, 2, sd)
  } else {
    bias <- mean(outb) - out
    se <- sd(outb)
  }
  OVboot <- data.frame(estOV = out, bias = bias, se = se)
  return(list(OVboot_stats = OVboot, OVboot_dist = outb )) 
}
 
#BB <- boot.overlap( x, B = 1000, bw = 1, kernel = "epanechnikov" )
#plot( density( BB$OVboot_dist ) )
#abline( v = BB$OVboot_stats$estOV )

