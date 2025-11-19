#' ==============================================
#' @title overlap
#' @description It gives the overlapped estimated area of two or more kernel density estimations from empirical data.
#' @param x = list of numerical vectors to be compared; each vector is an element of the list
#' @param nbins = number of equally spaced points at which the overlapping \ref{\code{density}} is evaluated; see density for details
#' @param type = type of index (1 = integrale semplice, 2 = proportion)
#' @param plot = logical, if TRUE, final plot of estimated densities and overlapped areas is produced
#' @param boundaries = an optional vector indicating the minimum and the maximum 
#' @param pairsOverlap = logical, 
#' @param ... = optional arguments to be passed to function \ref{\code{density}}
#' @author Massimiliano Pastore, Pierfrancesco Alaimo Di Loro and Marco Mingione
overlap <- function(x, nbins = 1024, type = c( "1", "2" ), 
      pairsOverlap = TRUE, plot = FALSE, boundaries = NULL, get_xpoints = FALSE, ... ) {
  
  # --------------------------------
  # controls
  type <- match.arg(type)
  typePairs <- typeMult <- type
  if(length(x)<2) stop("To compute the overlapping, you need at least 2 densities!")
  if (length(x)==2) pairsOverlap <- FALSE 
  if (type == "2" & pairsOverlap) {
    typeMult <- "1"
    warning("type 2 index for multiple overlapping not yet implemented.")
  }
  if (pairsOverlap & get_xpoints) {
    warning("xpoints not implemented when pairsOverlap = TRUE")
    get_xpoints <- FALSE # solo per overlapping singoli
  }
  # --------------------------------
  
  # Aggiunge nomi alla lista contenente i vettori di probabilità, se non presenti
  if (is.null(names(x))) names(x) <- paste("Y", 1:length(x), sep = "")
  
  BOUND <- boundaries
  if (is.null(boundaries)) {
    boundaries <- range(unlist(x))
  } 
  outList <- ovmult(x, nbins = nbins, 
                    type = typeMult, boundaries = boundaries, 
                    get_xpoints = get_xpoints, ... )
  
  if (pairsOverlap) {
    allcomb <- combn(length(x), 2)
    ovPairs <- pairsNames <- NULL
    
    for (j in 1:ncol(allcomb)) {
      PN <- paste0(names(x)[allcomb[1,j]], "-", names(x)[allcomb[2,j]])
      pairsNames <- c(pairsNames, PN)
      ovPairs <- c(ovPairs, ovmult( x[ c(allcomb[1,j],allcomb[2,j]) ], nbins = nbins, 
                      type = typePairs, boundaries = boundaries, get_xpoints = FALSE, ... )$OV)
    }
    names(ovPairs) <- pairsNames
    outList <- list(OV = outList$OV, OVPairs = ovPairs )
  }
  
  if (plot) {
    print( final.plot( x, pairsOverlap, BOUND ) )  
  }
  
  return( outList )
}
