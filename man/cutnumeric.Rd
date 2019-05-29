\name{cutnumeric}
\alias{cutnumeric}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Numerical conversion
}
\description{
It divides a numerical variable \code{x} in classes, and returns for each class the central value.

Internal function, generally not to be called by the user.
}
\usage{
cutnumeric( x, n = 1000 )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{numeric vector}
  \item{n}{number of classes}
}
\details{
It calls the \code{cut} function, and then converts factor classes in numeric classes, returning for each class its central value. 
}
\value{
It returns a numerical vector. The values are the central points of classes obtained by the function \code{cut}.
}
%\references{
%% ~put references to the literature/web site here ~
%}
\author{
Massimiliano Pastore
}
%\note{
%This function is called from the function \code{\link{overlap}}.
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{cut}}
}
\examples{
x <- rnorm(50)
cutnumeric(x,5)
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
}
\keyword{utility}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
