# DOCUMENTATION ------------------------------------
' Discrete Densities & Distributions
  Book:  Statistics & Data W/ R
'

# Clear Namespace -----------------------------------
rm(list=ls())
dev.off()


# Load Libraries ------------------------------------
library(dplyr)

# Create Geometric Distribution --------------------
' PI =  Probability of the event occuring
  x, q	vector of quantiles representing the number 
        of failures in a sequence of Bernoulli trials before 
        success occurs.
  
'

PI <- c(0.3, 0.7, 0.9)
x <- 0:10
par(mfrow=c(1,3))
xlab = expression(italic(x))
for (i in 1:3){
  density <- dgeom(x, PI[i])
  ylab <- bquote(italic(P(X==x) ~~~~~pi) == .(PI[i]))
  plot(x, density, type='h', lwd=3, 
       xlab=xlab, ylab=ylab)
  abline(h=0, lwd=2)
}

# Produce Another Geometric Distribution ---------
' Use pgeom to get the probability for any x and pi
  x  = number of trials
  pi = P(X < x)
       Also, note that pi is the probability that the
       event does occur.  So note the difference in the 
       density plots between 0.3, 0.7 and 0.9 and the
       rate at which the values for P(X = x) drop off.
       0.9 has the fastest drop off rate because we are 
       saying that in trial 1 no event occured and it had
       a 0.9 prob of occuring.  trial 2 no event occured 
       and it also had a 0.9 prob of occuring.  So the dist
       is showing that as x increases it is less and less likley 
       that a success has not occured. '

# 50% Probability of a success
pi <- 0.5

# Number of trials 0-10
n.trials <- 0:10

# Plot Probability Dist
pX.x <- dgeom(n.trials, pi)
plot(pX.x)

pgeom(0, pi)  # why is the prob increasing as the num of trials increases?




# Number of Israelis dead in 
hist(x = cars$speed, xlab='Car Speeds', breaks=10)
cars.nd <- dnorm(0 : length(cars$speed), mean= mean(cars$speed), sd(cars$speed))
plot(cars.nd)
lines(cars.nd)






