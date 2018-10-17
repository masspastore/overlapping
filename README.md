# overlapping
Estimation of Overlapping in Empirical Distributions.

# Set up

To install this github version type in R:

```{r}
# if devtools is not installed yet: 
# install.packages( "devtools" )  
library( devtools )
install_github( "masspastore/overlapping" )
```

# Examples

```{r}
set.seed( 20150605 )
x <- list( X1 = rnorm(100), X2 = rt(50,8), X3 = rchisq(80,2) )
out <- overlap( x, plot = TRUE )
```


