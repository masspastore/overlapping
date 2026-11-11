context("overlap")

test_that("overlap works", {
  set.seed(20150605)
  N <- 1e5
  x <- list(X1=runif(N),X2=runif(N,.5,1.5))
  
  OV <- overlap(x)$OV
  expect_equal( object = as.numeric(OV), expected = 0.5, tolerance = .05, scale = 1 )
})
