# DOCUMENTATION
'
  Desc:  Fit a theoretical distribution to the historical
         fire loss data. 
  Ref:
        https://www.pluralsight.com/guides/beta-and-gamma-function-implementation-in-r
        https://rdrr.io/cran/fitdistrplus/f/inst/doc/paper2JSS.pdf

'
# Clear namespace
rm(list=ls())
dev.off(dev.list()["RStudioGD"])

# Load Libraries
library("readxl")
library(ggplot2)
library(dplyr)
library("fitdistrplus")


# Load Data
setwd("C:\\Users\\chris.cirelli\\Dropbox (Swyfft)\\cc2_dropbox\\DS_topics\\FireRespTime_study\\data")
c.data <- read_excel("fire_claims_v3.xlsx")


# Inspect Data ------------------------------------
summary(c.data)
head(c.data)
colnames(c.data)

# Isolate Total Incurred Col
total.incurred <- as.numeric(c.data$TOTAL_INCURRED)

# Descriptive statistics
summary(total.incurred)
mu.1 <- mean(total.incurred)
md.1 <- median(total.incurred)

# Visualizations ----------------------------------

# BoxPlot
boxplot(total.incurred, main='BoxPlot - Total Incurred')

# Histogram Plot
hist(total.incurred, col='blue', breaks=20, main='Histogram - Total Incurred (bins=20)')
abline(v=mu.1, col='red')
abline(v=md.1, col='green')
text(mu.1, 0, "Mean", col='red')
text(md.1, 20, "Median", col='green')


# Scatter Plot Color By Group
d1 <- c.data[, c('TOTAL_INCURRED', 'ACC_CODE')]
d1.factors <- unique(d1$ACC_CODE)
d1.group.cnt <- d1 %>% group_by(ACC_CODE) %>% tally()


# Find Optimal Distribution to Fit Dataset ----------------------------


# Replace 0 with some small value (fitdistr throws error for 0's)
d1[d1 == 0] <- 0.00001

# Plot PDF and CDF
plotdist(d1$TOTAL_INCURRED, histo=TRUE, demp=TRUE)

# Plot Skewness & Kurtosis Plot Vs Known Dist
' Observations:  Looks like a gamma dist'
descdist(d1$TOTAL_INCURRED, boot=1000)

# Fit Gamma Distribution to Total Incurred 
' Scale data by 10000, else function throws error'
f1 <- fitdist(d1$TOTAL_INCURRED, discrete=FALSE, 'norm', method='mle')
f2 <- fitdist(d1$TOTAL_INCURRED/100000, discrete=FALSE, "gamma", method='mle')


# Fit Various Continuous Distributions and Compare Logliklihood Value
dist <- c("norm", "lnorm", "gamma", "logis")

f_fitdistr <- function (d_data, n_dist){
  # Iterate Over Each Distribution Type  
  for (i in seq(length(n_dist))){
    # Instantiate fitdistr function
    fd <- fitdist(d_data, n_dist[i])
    # Print Dist Name + LogLik of Fit
    print(paste(n_dist[i], fd$loglik))
  }
}

# Run Function
f_fitdistr(d1$TOTAL_INCURRED/10000, dist)


# Parameter Estimates - bootstrap method
'    shape      rate
1 0.3372634 0.1263888
2 0.3842877 0.1495907
3 0.3847614 0.1669686
4 0.3496388 0.1480369
5 0.3405625 0.1659326
6 0.3635766 0.1482782
'
bootdist(f2, niter=1001)


# Create Gamme Distr 2 Fit Dataset ------------------------------
' Gamma Distr Properties
  - The distribution is bounded at the lower end by zero, while it is 
    not bounded at the upper end.
  - The mean is equal to alpha * beta .
  - The variance is equal to alpha*beta^2 .
  - When alpha is greater than 1, the gamma distribution is unimodal 
    with the mode at (alpha - 1) * beta .
  - As alpha tends to infinity, the gamma distribution tends to 
    approximate towards normal distribution. When alpha is one, it 
    tends to take the shape of exponential distribution.

  Gamma Dist 4 Total Incurred:
  - Shape/apha = 0.35,  alpha < 1, shape is exponential. 
  - rate/beta  = 0.14, stretch or compress range of Gamma Dist. 
'

# Parameters
#alpha = 0.3635
alpha = 0.385    # utilizing 0.385 as the median is closer to the real dataset. 
beta  = 1/0.1482 
mu = alpha * beta
std.dv = sqrt(alpha*beta^2)
range = seq(0, mu + 10*std.dv, 0.2)


# Draw Gamma Distribution 
' Using same scale as fitdist, total_incurred / 100,000'
y = dgamma(x=range, shape=alpha, rate=1/beta)

plot(range, y, type='l', main='Gamma DIstribution Plot', 
     xlab='incurred (per 1000000', ylab='percentage')


# Get Probability of Less than X value
pgamma(50, alpha, rate=1/beta)

# Get Median
qgamma(0.5, alpha, rate=1/beta) * 100000


# Get 99% of CDF
qgamma(0.99, alpha, rate=1/beta) * 100000


# Generate N Random Variables from Distribution
ran.n <- rgamma(1000000, alpha, rate=1/beta)*100000
summary(ran.n)
hist(ran.n, xlab='Incurred Loss', ylab='Count', main='1m Ran. Generated Losses - Fit Gamma Dist')

# Probability of Loss Greater than 3.5m from Randomly Generated Values - Gamme Dist
cnt.greater.3m <- length(ran.n[ran.n > 3500000])
prob1 <- cnt.greater.3m / length(ran.n)
prob1 * 100

