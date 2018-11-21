\name{final.plot}
\alias{final.plot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Final plot
}
\description{
Graphical representation of estimated densities and overlapping area.
}
\usage{
final.plot(x, OV = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{x}{list of numerical vectors to be compared; each vector is an element of the list, see \code{\link{overlap}}}
  \item{OV}{Optional vector of overlapping areas obtained by \code{\link{overlap}}}
}
\details{
It requires the package \code{ggplot2}.
}
%\value{
%Graph.
%}
%\references{
%% ~put references to the literature/web site here ~
%}
\author{
Massimiliano Pastore
}
\examples{
set.seed(20150605)
x <- list(X1=rnorm(100),X2=rt(50,8),X3=rchisq(80,2))
out <- overlap(x)
final.plot(x,out$OV)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{utility}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
