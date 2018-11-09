context("overlap")

test_that("overlap works", {
  set.seed(20150605)
  x <- list(X1=rnorm(100),X2=rt(50,8))
  nbins <- 1000
  dd <- FUNC <- OV <- COMPTITLE <- NULL
  
  for (j in 1:length(x)) {
    dj <- density(x[[j]], n = nbins)
    ddd <- data.frame(x = dj$x, y = dj$y, j = names(x)[j]) 
    FUNC <- c(FUNC, list(with(ddd,approxfun(x,y))))
    dd <- rbind(dd, ddd)
  }
  
  for (i1 in 1:(length(x)-1)) {
    for (i2 in (i1+1):(length(x))) {
      comptitle <- paste0(names(x)[i1],"-",names(x)[i2])
      
      dd2 <- data.frame(x=dd$x,y1=FUNC[[i1]](dd$x),y2=FUNC[[i2]](dd$x))    
      dd2[is.na(dd2)] <- 0
      dd2$ovy <- apply(dd2[,-1],1,min)
      dd2$ally <- apply(dd2[,c("y1","y2")],1,max,na.rm=TRUE)
      dd2$dominance <- with(dd2, ifelse(y1>y2,1,2))
      dd2$k <- comptitle
      
      OV <- c(OV,sum(dd2$ovy,na.rm = TRUE) / sum(dd2$ally,na.rm = TRUE))
    }
    COMPTITLE <- c(COMPTITLE,comptitle)
  }
  names(OV) <- COMPTITLE
  expect_equal( overlap(x)$OV, OV)
})