\name{overlap}
\alias{overlap}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Estimate the overlapping measure. 
}

\description{
It returns the overlapped estimated area between two or more kernel density estimations from empirical data. The overlapping measure can be computed either as the integral of the minimum between two densities (\code{type = "1"}) or as the proportion of overlapping area between two densities (\code{type = "2"}). In the last case, the integral of the minimum between two densities is divided by the integral of the maximum of the two densities.
}

\usage{
overlap( x, nbins = 1024, type = c( "1", "2" ), 
    pairsOverlap = TRUE, plot = FALSE, boundaries = NULL, 
    get_xpoints = FALSE, ... )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{a list of numerical vectors to be compared (each vector is an element of the list).}
  \item{nbins}{number of equally spaced points through which the density estimates are compared; see \code{\link{density}} for details.}
  \item{type}{character, type of index. If \code{type = "2"} returns the proportion of the overlapped area between two or more densities, see Details.}
  \item{pairsOverlap}{logical, if \code{TRUE} (default) returns the overlapped area relative to each pair of distributions.}
  \item{plot}{logical, if \code{TRUE}, the final plot of estimated densities and overlapped areas is produced.}
  \item{boundaries}{an optional vector indicating the minimum and the maximum over a predefined subset of the support of the empirical densities, see Details.}
   \item{get_xpoints}{logical, if \code{TRUE} returns a vector where the abscissas represent the points of intersection among the densities. Note: it works only if \code{pairsOverlap = FALSE}. }
  \item{...}{optional arguments to be passed to the function \code{\link{density}}.}
}
\details{
When dealing with two densities: \code{type = "1"} corresponds to the integral of the minimum between the two densities; \code{type = "2"} corresponds to the proportion of the overlapped area over the total area.

If the list \code{x} contains more than two elements (i.e. more than two distributions) it computes both the multiple and the pairwise overlapping among all distributions. 

If \code{plot = TRUE} all the overlapped areas are plotted.  It requires \code{ggplot2}.

The optional vector \code{boundaries} has to contain two numbers for the empirical minimum and maximum of the overlapped area. See examples below. 

}
\value{
It returns a list containing the following components:
  \item{OV }{estimate of the overlapped area; if \code{x} contains more than two elements then a vector of estimates is returned.}
  \item{xpoints }{a list of intersection points (in abscissa) among the densities (if \code{get_xpoints = TRUE}).}
  \item{OVpairs}{the estimates of overlapped areas for each pair of densities (only if \code{x} contains more than two elements).}
%% ...
}
\references{
Pastore, M. (2018). Overlapping: a R package for Estimating Overlapping in Empirical Distributions. The Journal of Open Source Software, 3 (32), 1023. \doi{https://doi.org/10.21105/joss.01023}
        
Pastore, M., Calcagnì, A. (2019). Measuring Distribution Similarities Between Samples: A Distribution-Free Overlapping Index. Frontiers in Psychology, 10:1089. \doi{https://doi.org/10.3389/fpsyg.2019.01089}
}
\author{
Massimiliano Pastore, Pierfrancesco Alaimo Di Loro, Marco Mingione
}
\note{
Call function \code{\link{ovmult}}. 
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
set.seed(20150605)
x <- list(X1=rnorm(100), X2=rt(50,8), X3=rchisq(80,2))
overlap(x, plot=TRUE)

# including boundaries
x <- list(X1=runif(100), X2=runif(100,.5,1))
overlap(x, plot=TRUE, boundaries=c(.5,1))

x <- list(X1=runif(100), X2=runif(50), X3=runif(30))
overlap(x, plot=TRUE, boundaries=c(.1,.9))

# changing kernel
overlap(x, plot=TRUE, kernel="rectangular")

# normalized overlap
N <- 1e5
x <- list(X1=runif(N),X2=runif(N,.5))
overlap(x)
overlap(x, type = "2")


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{utility}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
