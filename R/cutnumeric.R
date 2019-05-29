#' Overlap: Estimate Overlap Between Two Distribution
#' 
#' It divides a numerical variable x in classes, and returns for each class the central value.
#' This is an internal function, generally not to be called by the user.
#' @param x numeric vector
#' @param n number of classes default = 1000

cutnumeric <-
function(x, n = 1000 ) {
  ## x = a numeric vector
  if(!is.numeric(x)) stop("x must be numeric")
  
  xclass <- cut(x, seq( min(x), max(x), length = n ), include.lowest = TRUE )

  unlist( lapply( xclass, function(b) {
    h <- strsplit( as.character(b), "," )[[1]]
    h <- as.numeric(gsub( "\\[", "", 
                          gsub("\\]", "", gsub("\\(", "", h ) ) ))
    mean( h )
  } ) )
}




