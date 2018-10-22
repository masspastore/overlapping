#' Overlap: Estimate Overlap Between Two Distribution
#' 
#' @param x numeric vector
#' @param nbins number of bins. default = 1000
#' @param plot  boolean. default is false. 
#' @param partial.plot boolean. default is false
#'
overlap <- function(x, nbins = 1000, plot = FALSE, partial.plot = FALSE) {
  if (is.null(names(x))) names(x) <- paste("Y", 1:length(x), sep = "")
  dd <- maxX <- maxY <- NULL
  
  ## density estimation
  for (j in 1:length(x)) {
    dj <- density(x[[j]], n = nbins)
    maxXj <- dj$x[which(dj$y == max(dj$y))]
    maxYj <- max(dj$y) 
    ddd <- data.frame(x = dj$x, y = dj$y, j = names(x)[j])
    dd <- rbind(dd, ddd)
    maxX <- c(maxX, maxXj)
    maxY <- c(maxY, maxYj)
  }
  dd$xclass <- cut(dd$x, seq(min(dd$x), max(dd$x), length = nbins),
                   include.lowest = TRUE)
  dd$xnum <- cutnumeric(dd$x, n = nbins)
  
  OV <- DD <- xpoints <- NULL
  for (i1 in 1:(length(x)-1)) {
    for (i2 in (i1+1):(length(x))) {
      (Do <- order(maxX))
      (Dx <- sort(maxX))
      (Dy <- maxY[order(maxX)])
      
      (max1 <- Dx[i1])
      (max2 <- Dx[i2])
      (d1 <- dd[dd$j == names(x)[Do[i1]], ])
      (d2 <- dd[dd$j == names(x)[Do[i2]], ])
      
      if (max1 > max2) {
        tram <- d2; d2 <- d1; d1 <- tram
        tram <- max2; max2 <- max1; max1 <- tram
      }
      YLIM <- range(c(d1$y, d2$y))
      XLIM <- range(c(d1$xnum, d2$xnum))
      
      XNUM <- unique(dd$xnum)
      dominance <- rep(NA, length(XNUM))
      change <- NULL
      
      for (h in 1:length(XNUM)) {
        if (length(d1$y[d1$xnum == XNUM[h]]) > 0) {
          Y1 <- max(d1$y[d1$xnum == XNUM[h]]) # possible warnings here          
        } else {
          Y1 <- -Inf
        }
        if (length(d2$y[d2$xnum == XNUM[h]]) > 0) {
          Y2 <- max(d2$y[d2$xnum == XNUM[h]]) # possible warnings here  
        } else {
          Y2 <- -Inf
        }
        
        dominance[h] <- ifelse(Y1>Y2, 1, 2)
        if (h > 1) {
          if (dominance[h] != dominance[h-1]) change <- c(change, h-1)
        }
      }
  
      DOM <- data.frame(xnum = XNUM, dominance)
      d1 <- merge(d1, DOM, by = "xnum")
      d1$w <- ifelse(d1$dominance == 1, 0, 1)
      
      d2 <- merge(d2, DOM, by = "xnum")
      d2$w <- ifelse(d2$dominance == 2, 0, 1)
      
      ov <- sum(abs(d1$x) * d1$y * d1$w) / sum(abs(d1$x) * d1$y) + 
        sum(abs(d2$x) * d2$y * d2$w) / sum(abs(d2$x) * d2$y)
      
      NOMI <- c(as.character(unique(d1$j)), as.character(unique(d2$j)))
      names(ov) <- paste(sort(NOMI), collapse = "-")
      
      if (partial.plot) {
        plot(d1$xnum, d1$y,
             xlim = XLIM,
             ylim = YLIM,
            lwd = 2, type = "l", main = names(ov))
        lines(d2$xnum, d2$y, col = "red", lwd = 2)
        abline(v = c(max1, max2), col = 1:2, lwd = 2, lty = 2)        
        abline(v = XNUM[change], col = "gray", lwd = 3, lty = 3)
        points(d1$x[d1$w == 1], d1$y[d1$w == 1], col = "green")
        points(d2$x[d2$w == 1], d2$y[d2$w == 1], col = "green")
        text(max(XLIM), max(YLIM) * .95,
             paste("overlap = ", round(ov * 100, 2), "%"), pos = 2)
      }
      
      OV <- c(OV, ov)
      d1$k <- d2$k <- names(ov) 
      DD <- rbind(DD, d1, d2)
      DD <- DD[, c("x", "y", "j", "xclass", "xnum", "dominance", "w", "k")]
      xpoints <- c(xpoints, XNUM[change])
    }
  }

  if (plot) {
    has.ggplot2 <- requireNamespace("ggplot2")
    if (has.ggplot2) {
      if (!isNamespaceLoaded("ggplot2")) attachNamespace("ggplot")
      print(final.plot(x, OV))
    } else {
      warning("package ggplot2 is missing.")
    }
    
  }
  
  return(list(DD= DD,OV= OV,xpoints= xpoints))
}
