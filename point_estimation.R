# Point Estimation ---------------------------------------------------
'Source:  Statistics & Data With R
'

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


# Load Crime Data ----------------------------------------------------

data("ChickWeight")

summary(ChickWeight)
colnames(ChickWeight)



