# Point Estimation ---------------------------------------------------
'Source:  Statistics & Data With R
'

# Clear namespace and plots
rm(list=ls())
dev.off()

# Produce Biased - Unbiased Plots ------------------------------------
par(mfrow = c(1,3), mar=c(2,1,2,1))
x <- seq(-4, 4, length=1000)
plot(x, dnorm(x), axes = FALSE, 
     xlab=expression(plain('(a)')), 
     ylab='', type='l')
abline(h=0)
abline(v=0)
axis(1, at=-1, 
     labels=expression(italic('parameter')), 
     lwd=3)
axis(2, at=0, labels=expression(italic('estimator')))

# Create Step Plot --------------------------------------------------
data(AirPassengers)
y.vals <- AirPassengers
x.vals <- seq(length(AirPassengers))
plot(x.vals, y.vals)
plot(x.vals, y.vals, type='s')
hist(y.vals, breaks=10)

# Finding MLE Numberically ------------------------------------------


# Step 1 - create a sample from a normal distributoin with known mu and sigma2
mu <- 20; sigma.2 <- 4; set.seed(33)
X <- rnorm(100, mu, sqrt(sigma.2))
hist(X)    # hist plot
qqnorm(X)  # qq plot

# Step 2 - Define L According to equation 9.2, which is for the normal distribution
log.L <- function(mu.hat = 15, sigma.2.hat = 6){
  n <- length(X)
  n/2 * log(2 * pi * sigma.2.hat) + 1/2 * sum((X - mu.hat)^2 / sigma.2.hat)
}

# Step3 - Use MLE Function from the Stats Packages
library(stats4)
fit <- mle(log.L)
summary(fit)






















