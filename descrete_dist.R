# DOCUMENTATION ------------------------------------
' Discrete Densities & Distributions
  Book:  Statistics & Data W/ R
'

# Create Geometric Distribution --------------------
' PI = Probability of the event occuring
  x, q	vector of quantiles representing the number 
        of failures in a sequence of Bernoulli trials before 
        success occurs.
  
'

PI <- c(0.3, 0.7)
x <- 0:10
par(mfrow=c(1,2))
xlab = expression(italic(x))
for (i in 1:2){
  density <- dgeom(x, PI[i])
  ylab <- bquote(italic(P(X==x) ~~~~~pi) == .(PI[i]))
  plot(x, density, type='h', lwd=2, 
       xlab=xlab, ylab=ylab)
  abline(h=0, lwd=2)
  
}

dgeom(x, 0.3)



