\name{paired.permutations}
\alias{paired.permutations}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Permutation for non-independent data
}
\description{
Randomly permute the paired data. 
}
\usage{
paired.permutations( x )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{a list of two numerical vectors to be compared (each vector is an element of the list).}
}
\details{
When the data are paired (i.e. non-independent 
observations), the exchange takes place within each pair. 
Note: if the data are paired, the elements in the list must be of the same 
length and in the same order. 
}
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
x <- list(X1=rnorm(10), X2=rt(10,8))
paired.permutations( x )

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{utility}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
