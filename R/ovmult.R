#' =========================================
#' @title ovmult
#' @description It computes the overlapped estimated area of two or more kernel density estimations from empirical data.
#' Internal function, generally not to be called by the user.
#' @param x = list of numerical vectors to be compared; each vector is an element of the list
#' @param nbins = number of equally spaced points at which the overlapping \ref{\code{density}} is evaluated; see density for details
#' @param type = type of index (1 = integrale semplice, 2 = proportion)
#' @param boundaries = an optional vector indicating the minimum and the maximum 
#' @param get_xpoints = logical, 
#' @param ... = optional arguments to be passed to function \ref{\code{density}}
#' @return It returns the overlapped area 
#' se \code{get_xpoints = TRUE} restituisce anche i punti di cambio della dominanza
#' @author Pierfrancesco Alaimo Di Loro, Marco Mingione and Massimiliano Pastore
ovmult <- function(x, nbins = 1024, type = c( "1", "2" ), boundaries = NULL, get_xpoints = FALSE, ... ) {
  
  # --------------------------------
  # controls
  type <- match.arg(type)
  
  if (is.null(boundaries)) {
    boundaries <- range(unlist(x))
  } 
  from <- boundaries[1]
  to <- boundaries[2]
  
  # Stimo le densità direttamente su un dominio comune
  dens_list <- lapply(x, density, from = from, to = to, n = nbins, ... )
  
  # Fisso eventuali underflow numerici
  for(j in 1:length(dens_list)) dens_list[[j]]$y[which(dens_list[[j]]$y < .Machine$double.xmin)] <- .Machine$double.xmin
  
  # Normalizzo le singole densità empiriche
  dens_norm_list <- lapply(dens_list, function(ll) ll$y/sum(ll$y))
  
  # Calcolo multi-OV (intesa come FRA ALMENO due densità)
  dens_norm_mat <- do.call(cbind, dens_norm_list)
  ovs <- as.matrix(t(apply(dens_norm_mat, 1, sort, decreasing=TRUE))[,2:length(x)])
  OVtilde <- sum(2*ovs[, 1]+rowSums(ovs[,-1,drop=FALSE]))
  OVmulti <- OVtilde/length(x)
  
  # Calcolo OV normalizzato
  if (type == "2") {
    totarea <- as.matrix(t(apply(dens_norm_mat, 1, sort))[,2:length(x)])
    MAXtilde <- sum(2*totarea[, 1]+rowSums(totarea[,-1,drop=FALSE]))/length(x)
    OVmulti <- OVmulti/MAXtilde
  }
  
  if (get_xpoints) {
    # Calcolo i punti di cambio dominanza
    dd <- data.frame(x=dens_list[[1]]$x)
    dd <- cbind(dd,dens_norm_mat)
    dd$minimum <- apply(dd[,-1], 1, which.min )
    xpoints <- dd$x[which(dd$minimum[2:nrow(dd)]!=dd$minimum[1:(nrow(dd)-1)])]
    
    return( list(OV=OVmulti,xpoints=xpoints) )   
  } else {
    return( list(OV=OVmulti) ) 
  }
  
}
