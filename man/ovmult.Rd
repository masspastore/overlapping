\name{ovmult}
\alias{ovmult}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Multiple overlapping estimation
}
\description{
It gives the overlap area between two or more kernel density estimations from empirical data.
}
\usage{
ovmult( x, nbins = 1024, type = c( "1", "2" ), 
    boundaries = NULL, get_xpoints = FALSE, ... )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{a list of numerical vectors to be compared (each vector is an element of the list).}
  \item{nbins}{number of equally spaced points through which the density estimates are compared; see \code{\link{density}} for details.}
  \item{type}{character, type of index. If \code{type = "2"} returns the proportion of the overlapped area between two or more densities, see \code{\link{overlap}}.}
  \item{boundaries}{an optional vector indicating the minimum and the maximum over a predefined subset of the support of the empirical densities.}
  \item{get_xpoints}{logical, if \code{TRUE} returns a vector where the abscissas represent the points of intersection among the densities. Note: it works only if \code{pairsOverlap = FALSE}. }
  \item{...}{optional arguments to be passed to the function \code{\link{density}}.}
}
\details{
If the list \code{x} contains more than two elements (i.e. more than two distributions) it computes multiple overlap measures. 

The optional vector \code{boundaries} has to contain two numbers for the empirical minimum and maximum of the overlapped area. See examples below.

}
\value{
It returns the value of overlapped area. 
}
\author{
Pierfrancesco Alaimo Di Loro, Marco Mingione, Massimiliano Pastore
}
\note{
Called from the function \code{\link{overlap}}. 
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
set.seed(20150605)
x <- list(X1=rnorm(100), X2=rt(50,8), X3=rchisq(80,2))
ovmult(x)
ovmult(x, type = "2" )

# including boundaries
x <- list(X1=runif(100), X2=runif(100,.5,1))
ovmult(x, boundaries=c( 0, .8 ))

x <- list(X1=runif(100), X2=runif(50), X3=runif(30))
ovmult(x, boundaries=c( .2, .8 ))

# changing kernel
ovmult(x, kernel="rectangular")

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{utility}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
