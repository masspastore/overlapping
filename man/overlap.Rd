\name{overlap}
\alias{overlap}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Overlapping estimation
}
\description{
It gives the overlapped estimated area of two or more empirical distributions. %Stima l'area di sovrapposizione tra distribuzioni empiriche. 
}
\usage{
overlap(x, nbins = 1000, plot = FALSE, partial.plot = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{list of distributions to be compared; each distribution is an element of the list}
  \item{nbins}{number of equally spaced points at which the overlapping density is evaluated}
  \item{plot}{logical, if \code{TRUE}, final plot of estimated densities and overlapped areas is produced}
  \item{partial.plot}{logical, if \code{TRUE}, partial paired distributions are plotted}
}
\details{
If the list \code{x} contains more than two elements (i.e. more than two distributions) it computes all overlapping between all paired distributions. Partial plots refer to these coupled distributions. 
%Se la lista \code{x} contiene piu di due elementi, calcola le sovrapposizioni tra tutte le coppie di distribuzioni. I grafici parziali si riferiscono a queste coppie.

If \code{plot=TRUE}, all overlapped areas are plotted.  It requires \code{lattice}.
%Se si pone a \code{plot=TRUE} richiede \code{lattice} e produce un grafico complessivo delle aree di sovrapposizione rispetto ciascuna coppia.
}
\value{
It returns a list containing the following components:
  \item{DD }{Data frame with information used for computing overlapping, containing the following variables: 
  \code{x}, coordinates of the points where the density is estimated;
  \code{y}, density;
  \code{j}, index of the distribution in the list \code{x};
  \code{xclass}, class of \code{x};
  \code{xnum}, numerical class of \code{x} (obtained by \code{\link{cutnumeric}});
  \code{dominance}, indicates which distribution has the highest density;
  \code{w}, flag 0-1 for normalizing area;
  \code{k}, label indicating which distributions are compared %etichetta per il confronto, per \code{default} viene ricavato dai nomi degli oggetti nella lista di input.
  }
  \item{OV }{Estimates of overlapped areas relative to each couple of distributions.}
  \item{xpoints }{Abscissas of intersection points among the density curves.}
%% ...
}
%\references{
%% ~put references to the literature/web site here ~
%}
\author{
Massimiliano Pastore
}
\note{
Call functions \code{\link{cutnumeric}} e \code{\link{final.plot}}. 
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
set.seed(20150605)
x <- list(X1=rnorm(100),X2=rt(50,8),X3=rchisq(80,2))
out <- overlap(x,plot=TRUE)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{utility}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
