\name{boot.overlap}
\alias{boot.overlap}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Nonparametric Bootstrap for estimated overlapping area
}
\description{
Bootstrap the estimated overlapping area of two or more kernel density estimations from empirical data.
}
\usage{
boot.overlap( x, B = 1000, ... )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{list of numerical vectors to be compared; each vector is an element of the list}
  \item{B}{integer, number of bootstrap draws}
  \item{...}{options, see function \code{\link{overlap}} for details}
}
\details{
If the list \code{x} contains more than two elements (i.e. more than two distributions) it computes bootstrap overlapping between all \eqn{q} number of paired distributions. For example, if \code{x} contains three elements, then \eqn{q = 3}; if \code{x} contains four elements, then \eqn{q = 6}, and so on.
}
\value{
It returns a list containing the following components:
  \item{OVboot_stats }{Data frame \eqn{q \times 3}; each row  containing the following statistics:
  \code{estOV}, estimated overlapping area, \eqn{\hat{\eta}};
  \code{bias},  difference between the bootstrap's expected value and the observed value of the overlapping area: \eqn{E(\hat{\eta}^*)-\hat{\eta}};
  \code{se}, bootstrap standard error \eqn{\sigma_{\hat{\eta}}}.}
  \item{OVboot_dist }{Matrix \eqn{B \times q}, \code{B} rows (bootstrap replicates) and \eqn{q} columns (depending on the number of elements of \code{x}); each column is a boostrap distribution of an overlapping index. }
}
\references{
Pastore, M. (2018). Overlapping: a R package for Estimating Overlapping in Empirical Distributions. The Journal of Open Source Software, 3 (32), 1023.
        URL: \url{https://doi.org/10.21105/joss.01023}

Pastore, M., Calcagnì, A. (2019). Measuring Distribution Similarities Between Samples: A Distribution-Free Overlapping Index. Frontiers in Psychology, 10:1089. URL: \url{https://doi.org/10.3389/fpsyg.2019.01089}
}
\author{
Massimiliano Pastore
}
\note{
Call function \code{\link{overlap}}.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
set.seed(20150605)
x <- list(X1=rnorm(100), X2=rt(50,8), X3=rchisq(80,2))

## bootstrapping
out <- boot.overlap( x, B = 10 )
out$OVboot_stats

# bootstrap quantile intervals
apply( out$OVboot_dist, 2, quantile, probs = c(.05, .9) )

# plot of bootstrap distributions
Y <- stack( data.frame( out$OVboot_dist ))
ggplot( Y, aes( values )) + facet_wrap( ~ind ) + geom_density()
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{utility}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
