#' Overlap: Estimate Overlap Between Two Distribution
#' 
#' @param x numeric vector
#' @param nbins number of bins. default = 1000
#' @param plot  boolean. default is false. 
#' @param partial.plot boolean. default is false
#' @param boundaries an optional list 
#' @param ... options see function density
#' 
overlap <- function(x, nbins = 1000, plot = FALSE, 
                    partial.plot = FALSE, boundaries = NULL, ... ) {

  if (is.null(names(x))) names(x) <- paste("Y", 1:length(x), sep = "")
  dd <- OV <- FUNC <- DD <- xpoints <- COMPTITLE <- NULL
  
  ## density estimation
  for (j in 1:length(x)) {
    
    ## boundaries check
    if (!is.null(boundaries)) {
      
      Lbound <- lapply(boundaries,FUN=length)
      if ((Lbound$from==1)&(Lbound$to==1)) {
        warning("Boundaries were set all equals")
        boundaries$from <- rep(boundaries$from,length(x))
        boundaries$to <- rep(boundaries$to,length(x))
      } else {
        if ((Lbound$from!=length(x))|(Lbound$to!=length(x))) {
          stop("Boundaries not correctly defined")
        }
      }
      
      from = boundaries$from[j]
      to = boundaries$to[j]
      dj <- density(x[[j]], n = nbins, from = from, to = to, ... )
    } else {
      dj <- density(x[[j]], n = nbins, ... )  
    }
    
    ddd <- data.frame(x = dj$x, y = dj$y, j = names(x)[j]) 
    FUNC <- c(FUNC, list(with(ddd,approxfun(x,y))))
    dd <- rbind(dd, ddd)
  }
  
  for (i1 in 1:(length(x)-1)) {
    for (i2 in (i1+1):(length(x))) {
      comptitle <- paste0(names(x)[i1],"-",names(x)[i2])
      
      dd2 <- data.frame(x=dd$x,y1=FUNC[[i1]](dd$x),y2=FUNC[[i2]](dd$x))    
      dd2[is.na(dd2)] <- 0
      dd2$ovy <- apply(dd2[,c("y1","y2")],1,min)
      dd2$ally <- apply(dd2[,c("y1","y2")],1,max,na.rm=TRUE)
      dd2$dominance <- ifelse(dd2$y1>dd2$y2,1,2)
      dd2$k <- comptitle
      
      OV <- c(OV,sum(dd2$ovy,na.rm = TRUE) / sum(dd2$ally,na.rm = TRUE))
      
      dd2 <- dd2[order(dd2$x),]
      CHANGE <- dd2$x[which(dd2$dominance[2:nrow(dd2)]!=dd2$dominance[1:(nrow(dd2)-1)])]
      xpoints <- c(xpoints,list(CHANGE))
      
      if (partial.plot) {
        gg <- ggplot(dd2,aes(x,dd2$y1))+theme_bw()+
          geom_vline(xintercept = CHANGE,lty=2,color="#cccccc")+
          geom_line()+geom_line(aes(x,dd2$y2))+
          geom_line(aes(x,dd2$ovy),color="red")+geom_line(aes(x,dd2$ally),color="blue")+
          ggtitle(comptitle)+xlab("")+ylab("")+
          theme(plot.title = element_text(hjust=.5))
        print(gg)
      }
      DD <- rbind(DD,dd2)
      COMPTITLE <- c(COMPTITLE,comptitle)
    }
  }
  
  names(xpoints) <- names(OV) <- COMPTITLE
  if (plot) print( final.plot(x,OV) )
  return(list(DD=DD,OV= OV,xpoints= xpoints))
}
