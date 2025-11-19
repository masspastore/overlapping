\name{perm.test}
\alias{perm.test}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Permutation test on the (non-)overlapping area
}
\description{
Perform a permutation test on the overlapping index.
}
\usage{
perm.test( x, B = 1000, 
          return.distribution = FALSE, ... )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{a list of numerical vectors to be compared (each vector is an element of the list).}
  \item{B}{integer, number of permutation replicates.}
  \item{return.distribution}{logical, if \code{TRUE} it returns the distribution of permuted Z statistics.}
  \item{...}{options, see function \code{\link{overlap}} for details.}
}
\details{
It performs a permutation test of the null hypothesis that there is no difference between the two distributions, i.e. the overlapping index (\eqn{\eta}) is one, or the non-overlapping index (\eqn{1-\eta = \zeta}) is zero. 
}
\value{
It returns a list containing the following components:
  \item{Zobs }{ the observed values of non-overlapping index, i.e. 1-\eqn{\eta}. }
  \item{pval }{ p-values. }
  \item{Zperm }{ the permutation distributions.}

}
\references{
Perugini, A., Calignano, G., Nucci, M., Finos, L., & Pastore, M. (2024, December 30). How do my distributions differ? Significance testing for the Overlapping Index using Permutation Test. \doi{https://doi.org/10.31219/osf.io/8h4fe}
}
\author{
Massimiliano Pastore
}
\note{
Call function \code{\link{overlap}}.
}

%% ~Make other sections like Warning with 
\section{Warning }{
Currently, it only runs the permutation test on two groups at a time. If \code{x} contains more than 2 elements, it performs all paired permutation tests.
} %%~

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
set.seed(20150605)
x <- list(X1=rnorm(100), X2=rt(50,8))

## not run: this example take several minutes
## permutation test
# out <- perm.test( x, return.distribution = TRUE )
# out$pval
# plot( density( out$Zperm ) )
# abline( v = out$Zobs ) 

x <- list(X1=rnorm(100), X2=rt(50,8), X3=rchisq(75,3))
# out <- perm.test( x )
# out$pval

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{utility}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
