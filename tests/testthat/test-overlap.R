context("overlap")

test_that("overlap works", {
  set.seed(20150605)
  x <- list(X1=rnorm(100),X2=rt(50,8))
  nbins <- 1000
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
  ### cutnumeric
  xclass <- cut(dd$x, seq( min(dd$x), max(dd$x), length = 1000 ), include.lowest = TRUE )
  dd$xnum <- unlist( lapply( xclass, function(b) {
    h <- strsplit( as.character(b), "," )[[1]]
    h <- as.numeric(gsub( "\\[", "", 
                          gsub("\\]", "", gsub("\\(", "", h ) ) ))
    mean( h )
  } ) )
  
  ## overlap estimation
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
      
      OV <- c(OV, ov)
      d1$k <- d2$k <- names(ov) 
      DD <- rbind(DD, d1, d2)
      DD <- DD[, c("x", "y", "j", "xclass", "xnum", "dominance", "w", "k")]
      xpoints <- c(xpoints, XNUM[change])
    }
  }
  
  expect_equal( overlap(x)$OV, OV)
})