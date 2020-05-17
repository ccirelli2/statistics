' Documentation:

  Purpose:  The purpose of this script is to review how to fit a distribution to a give 
            dataset.  We will utilize the fitdistrplus package from MASS
  Refs:     http://www.di.fc.ul.pt/~jpn/r/distributions/fitting.html
            https://www.youtube.com/watch?v=BjEhaBPela4

'
# Clear Namespace
rm(list=ls())
dev.off(dev.list()["RStudioGD"])

# Load Packages
library("fitdistrplus")

# Load Data
data("groundbeef")

# Inspect Data
?groundbeef
summary(groundbeef)
str(groundbeef)
dput(groundbeef)

# Plot Density & Cumulative (PDF & CDF)
plotdist(groundbeef$serving, histo=TRUE, demp=TRUE)

# Descriptive Statistics
descdist(groundbeef$serving)
?descdist

# Fit Normal of Distributions Using MLE
?fitdist
fw <- fitdist(groundbeef$serving, discrete=FALSE, 'norm')
summary(fw) 
plot(fw)


# Fit Various Continuous Distributions and Compare Logliklihood Value
dist <- c("norm", "lnorm", "gamma", "logis")
          #"nbinom", "geom", "beta", "unif", "logis")

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
f_fitdistr(groundbeef$serving, dist)


# Fit Best Distr - Gamma
' shape = 4.008
  rate  = 0.05441
  Note: these would be your input values to the dgamma funct. 
        dgamma(x, shape=shape, rate=1/rate)
'
d.gamma <- fitdist(groundbeef$serving, discrete=FALSE, "gamma")
summary(d.gamma)
plot(d.gamma)


# Generate Gamma Distribution



