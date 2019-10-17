# overlapping
### Estimation of Overlapping in Empirical Distributions

Overlapping can be defined as the area intersected by two or more probability density functions. The main idea of this package is to offer an easy way to quantify the similarity (or the difference) between two or more empirical distributions by using the overlap between their kernel density estimates.

# Set up

To install this github version type in R:

```{r}
# if devtools is not installed yet: 
# install.packages( "devtools" )  
library( devtools )
install_github( "masspastore/overlapping" )
```

# Main function

The main function, **overlap**, provides an approximation of the overlapping area of two or more kernel density estimations from empirical data.

* **overlap**
    + Input: a list of numerical vectors to be compared; each vector is an element of the list.
    + Output: a data frame with information used for computing overlapping (only for graphical purposes) and estimated overlapped areas relative to each couple of distributions.
     
### Note

The function `overlap()` calls the `density()` function for computing kernel density estimates. Consequently, the estimation of overlapping area depends on method used in this latter function. The algorithm used in `density.default` disperses the mass of the empirical distribution function over a regular grid of at least 512 points and then uses the fast Fourier transform to convolve this approximation with a discretized version of the kernel and then uses linear approximation to evaluate the density at the specified points (see `help(density)` for details).

# Examples

```{r,results="markup"}
set.seed( 20150605 )

### EXAMPLE 1
# creating a list with three different empirical distributions
x <- list( X1 = rnorm(100), X2 = rt(50,8), X3 = rchisq(80,2) )

out <- overlap( x, plot = TRUE )
out$OV # estimated overlapped areas 

### EXAMPLE 2
# simulate eight random samples
dataList <- list()
for (j in 1:8) dataList <- c(dataList, list(rnorm(30)))

OV <- overlap(dataList) # compute overlapping for all pairs
head(OV$DD) # see the first rows of this data set
table(OV$DD$k)        # k indicates the pairs

# plot all pairs
ggplot( OV$DD, aes( x, y1))+facet_wrap(~k)+geom_ribbon(aes(ymin=0,ymax=y1),alpha=.3,fill="red")+
  geom_ribbon(aes(ymin=0,ymax=y2),alpha=.3,fill="blue")+xlab("")+ylab("")

# choose a single pair to be represented
K <- "Y1-Y2" 
data <- subset(OV$DD, k==K) # create a subset 

# plot it
ggplot( data, aes( x, y1 ))+geom_ribbon(aes(ymin=0,ymax=y1),alpha=.3,fill="red")+
  geom_ribbon(aes(ymin=0,ymax=y2),alpha=.3,fill="blue")+
  ggtitle(paste0("Overlap Y1-Y2 = ",round(OV$OV[K]*100,2),"%"))+xlab("")+ylab("")
```

### Support/Bug Reports

Users may contact the author at `massimiliano.pastore[at]unipd.it` for support or to report issues.

# References

Pastore, M. (2018). Overlapping: a R package for Estimating Overlapping in Empirical Distributions. The Journal of Open Source Software, 3 (32), 1023. URL: https://doi.org/10.21105/joss.01023

Pastore, M., Calcagnì, A. (2019). Measuring Distribution Similarities Between Samples: A Distribution-Free Overlapping Index. Frontiers in Psychology, 10:1089. URL: https://doi.org/10.3389/fpsyg.2019.01089
