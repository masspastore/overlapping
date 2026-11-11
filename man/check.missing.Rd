\name{check.missing}
\alias{check.missing}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Check for missing data
}
\description{
Remove \code{NAs} from the \code{x} list. 
}
\usage{
check.missing( x )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{a list of numerical vectors to be compared (each vector is an element of the list).}
}
\details{
If list \code{x} contains \code{NAs}, it returns a warning and
removes missing cases using \code{na.omit()}.
}
\value{
It returns the list \code{x} without \code{NAs}.
}
%\references{
%}
\author{
Massimiliano Pastore
}
\note{
Internal function.
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
check.missing( x )

x$X1[1:5] <- NA
check.missing( x )

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{utility}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
