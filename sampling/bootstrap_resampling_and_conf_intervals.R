'Source: https://www.youtube.com/watch?v=Om5TMGj9td4
        https://cran.r-project.org/web/packages/skimr/vignettes/skimr.html
        https://stats.idre.ucla.edu/r/faq/how-can-i-generate-bootstrap-statistics-in-r/
'

# Clear Namespace ----------------------------------
rm(list=ls())

# Load Libraries -----------------------------------
library(skimr)
library(dplyr)
library(boot)


# Load Data 
data("ChickWeight")
d <- ChickWeight

# Add Data to View
View(d)

# Investigate Dataset 
summary(d)
skim(d)

# Box Plot 
boxplot(d$weight~d$Diet, las=1, ylab='weight (g)', 
        xlab='feed', main='Weight By Feed')


# Calculate Difference in Sample Means -------------
with(d, tapply(d$weight, d$Diet, mean))


#######################################################
### BOOTSTRAP CONFIDENCE INTERVALS
#######################################################

# Get Count By Group
count_by_diet <- d %>% group_by(d$Diet) %>% tally()

# Create a Function to Pass to Boot
' X = column of data
  d = row indexer to be passed by boot to create 
      samples'

mu <- function(data.x, vector.indices){
  return(mean(data.x[vector.indices]))
  }

b <- boot(d$weight, test, R=500)


# Plot Bootstrap sampling
plot(b)


# Get Confidence Intervals ---------------------------
ci <- boot.ci(boot.out = b, conf=0.95, type=c('norm'))
help(boot.ci)

ci.lower <- ci$normal[2]
ci.upper <- ci$normal[3]

ci.lower
ci.upper



###############################################################
### CALCULATING CONFIDENCE INTERVALS FROM NORMAL DISTRIBUTION 
###############################################################
'sample mean = 5
 standard dev = 2
 samples = 20'
mu.hat <- 5
sd <- 2
ss <- 20    

'Calculation:
  Z value - number of the standard deviations a particular value is away
            from the mean. 
            Z = (x - mu) / stdv
  
  X.hat +- Z * s / sqrt(n)
'
# Get Z value @ 0.975 (note the reason for 0.975 is that we have 0.25 on each side)
z <- qnorm(0.975)                # z value
ci <- z * (sd / sqrt(ss))        # calculate confidence interval
ci.left <- mu.hat - ci           # get left tail ci
ci.right <- mu.hat + ci          # get right tail ci




##################################
# Next 
'https://data-flair.training/blogs/bootstrapping-in-r/'













        