' Coefficient of variance
  standard deviation / mean
'

library(raster)
library(dplyr)

rm(list=ls())
ran.data <- rnorm(1000000)
cv(ran.data)
?group_by
?subset
?order
