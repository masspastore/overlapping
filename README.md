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
     

# Examples

```{r}
set.seed( 20150605 )

# creating a list with three different empirical distributions
x <- list( X1 = rnorm(100), X2 = rt(50,8), X3 = rchisq(80,2) )

out <- overlap( x, plot = TRUE )
out$OV # estimated overlapped areas
```

### Support/Bug Reports

Users may contact the author at `massimiliano.pastore[at]unipd.it` for support or to report issues.

