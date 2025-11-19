\name{final.plot}
\alias{final.plot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Final plot
}
\description{
Graphical representation of the estimated densities along with the overlapping area.
}
\usage{
final.plot( x, pairs = FALSE, boundaries = NULL )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{x}{a list of numerical vectors to be compared; each vector is an element of the list, see \code{\link{overlap}}.}
  \item{pairs}{logical, if \code{TRUE} (and \code{x} contains more than two elements) produces pairwise plots.}
  \item{boundaries}{an optional vector indicating the minimum and the maximum over a predefined subset of the support of the empirical densities.}
  
}
\details{
It requires the package \code{ggplot2}.
}
\note{
The output plot can be customized using the \code{ggplot2} rules, see example below.
}
%\references{
%% ~put references to the literature/web site here ~
%}
\author{
Massimiliano Pastore
}
\examples{
set.seed(20150605)
x <- list(X1=rnorm(100),X2=rt(50,8),X3=rchisq(80,2))
final.plot(x)
final.plot(x, pairs = TRUE)

# customizing plot
final.plot(x) + scale_fill_brewer() + scale_color_brewer()
final.plot(x) + theme(text=element_text(size=15)) 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{utility}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
