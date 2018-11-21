\name{overlap}
\alias{overlap}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Overlapping estimation
}
\description{
It gives the overlapped estimated area of two or more kernel density estimations from empirical data.
}
\usage{
overlap(x, nbins = 1024, plot = FALSE, 
    partial.plot = FALSE, boundaries = NULL, ... )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{list of numerical vectors to be compared; each vector is an element of the list}
  \item{nbins}{number of equally spaced points at which the overlapping density is evaluated; see \code{\link{density}} for details}
  \item{plot}{logical, if \code{TRUE}, final plot of estimated densities and overlapped areas is produced}
  \item{partial.plot}{logical, if \code{TRUE}, partial paired distributions are plotted}
  \item{boundaries}{an optional list for bounded distributions, see Details}
  \item{...}{optional arguments to be passed to function \code{\link{density}}}
}
\details{
If the list \code{x} contains more than two elements (i.e. more than two distributions) it computes all overlapping between paired distributions. Partial plots refer to these paired distributions. 

If \code{plot=TRUE}, all overlapped areas are plotted.  It requires \code{ggplot2}.

The optional list \code{boundaries} must contain two elements: \code{from} and \code{to}, indicating the empirical limits of input variables. Each element must be of length equal to the input data list \code{x} or, at least, length one when all boundaries are equal for all distributions. See examples below. 

}
\value{
It returns a list containing the following components:
  \item{DD }{Data frame with information used for computing overlapping, containing the following variables: 
  \code{x}, coordinates of the points where the density is estimated;
  \code{y1} and \code{y2}, densities;
  \code{ovy}, density for estimating overlapping area (i.e. \code{min(y1,y2)});
  \code{ally}, density for estimating whole area (i.e. \code{max(y1,y2)});
  \code{dominance}, indicates which distribution has the highest density;
  \code{k}, label indicating which distributions are compared.   }
  \item{OV }{Estimates of overlapped areas relative to each pair of distributions.}
  \item{xpoints }{List of abscissas of intersection points among the density curves.}
%% ...
}
%\references{
%% ~put references to the literature/web site here ~
%}
\author{
Massimiliano Pastore
}
\note{
Call function \code{\link{final.plot}}. 
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
set.seed(20150605)
x <- list(X1=rnorm(100), X2=rt(50,8), X3=rchisq(80,2))
out <- overlap(x, plot=TRUE)
out$OV

# including boundaries
x <- list(X1=runif(100), X2=runif(100,.5,1))
boundaries <- list( from = c(0,.5), to = c(1,1) )
out <- overlap(x, plot=TRUE, boundaries=boundaries)
out$OV

# equal boundaries
x <- list(X1=runif(100), X2=runif(50), X3=runif(30))
boundaries <- list( from = 0, to = 1 )
out <- overlap(x, plot=TRUE, boundaries=boundaries)
out$OV

# changing kernel
out <- overlap(x, plot=TRUE, kernel="rectangular")
out$OV
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{utility}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
