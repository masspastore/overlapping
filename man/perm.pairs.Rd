\name{perm.pairs}
\alias{perm.pairs}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Paired permutation 
}
\description{
Perform a random permutation of the data list. 
}
\usage{
perm.pairs( x )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{a list of numerical vectors to be compared (each vector is an element of the list).}
}
%\details{
% zero. 
%}
\value{
It returns a list with paired elements of \code{x} randomly permuted.
}
%\references{
%}
\author{
Massimiliano Pastore
}
\note{
Internal function called by \code{\link{perm.test}}.
}

%% ~Make other sections like Warning with 
%\section{Warning }{
%Currently, it only runs the permutation test on two groups at a time. If \code{x} contains more than 2 elements, it performs all paired permutation tests.
%} %%~

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
set.seed(20150605)
x <- list(X1=rnorm(10), X2=rt(15,8))
perm.pairs( x )

x <- list(X1=rnorm(10), X2=rt(15,8), X3=rchisq(12,3))
perm.pairs( x )

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{utility}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
