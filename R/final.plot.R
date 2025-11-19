#' =========================================
#' @title final.plot
#' @description Graphical representation of estimated densities and overlapping area.
#' @param x = list of numerical vectors to be compared; each vector is an element of the list, see \ref{\code{ovelap}}
#' @param pairs = logical 
#' @details It requires the ggplot2 package
#' @author Massimiliano Pastore
#' @examples 
final.plot <- function (x, pairs = FALSE, boundaries = NULL ) 
{
  
  group <- NULL
  
  if (pairs) {
    AREA <- NULL
    for (i1 in 1:(length(x) - 1)) {
      for (i2 in (i1 + 1):(length(x))) {
        A <- data.frame(x = x[[i1]], group = names(x)[i1], 
                        k = paste(names(x)[i1], names(x)[i2], sep = "-", 
                                  collapse = ""))
        B <- data.frame(x = x[[i2]], group = names(x)[i2], 
                        k = paste(names(x)[i1], names(x)[i2], sep = "-", 
                                  collapse = ""))
        AREA <- rbind(AREA, rbind(A, B))
      }
    }
  } else {
    AREA <- data.frame(x=unlist(x),
          group=rep(names(x), unlist(lapply(x, length))),
          k = paste(names(x), collapse = "-"))
  }
  
  OVplot <- ggplot(AREA, aes(x = x, fill = group, color=group)) +
    theme_bw() + facet_wrap(~k) + 
    geom_density(alpha = 0.35) + 
    xlab("") + theme(legend.title = element_blank())
  
  if (!is.null(boundaries)) {
    OVplot <- OVplot + geom_vline(xintercept = boundaries,lty=2)
  }
  
  return(OVplot)
}
