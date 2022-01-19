'

  Ref:  https://www.youtube.com/watch?v=BjEhaBPela4
  alpha:  shape parameter
  beta:   inverse scale parameter
  mu:     alpha*beta
  x:      cut off. 
  range:  range of values
  dgamma: will give the pdf or density for the range. 
'


# Parameters
alpha = 4
beta =  20
avrg = alpha*beta
std.dv = sqrt(alpha*beta^2)
x = 250

# Draw a Gamma Distr
range = seq(0, avrg + 5*std.dv, 0.01)
y = dgamma(x=range, shape=alpha, rate=1/beta)
plot(range, y, type='l')




# Calculate Area under the curve (Cumulative Prob)
'x = the value under the curve for which we want to 
     calculate the probability.  i.e. probability that
     x is less than 50'
# probability less than x
pgamma(x, alpha, rate=1/beta)
# probability greater than x
1-pgamma(x, alpha, rate=1/beta)


# Get percentile (get center of dist)
qgamma(0.5, alpha, rate=1/beta)

