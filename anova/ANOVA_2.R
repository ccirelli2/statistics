# DOCUMENTATION -----------------------------------
' Desc:  Anova analysis tutorial / practice. 

  Brown-Forsyteh test: https://www.statisticshowto.com/brown-forsythe-test/
'

# Clear Namespace
rm(list=ls())
dev.off()

# Load Libraries
library(car)
library(ggpubr)
library(HH)
library(dplyr)

# Load Data
n.data <- InsectSprays


# Inspect Dataset -----------------------------------
summary(n.data)
str(n.data)
levels(n.data$spray)

# Drop Rows Zero Value
n.data <- n.data[n.data$count>0,]

#  Is the data normally distributed?
hist(n.data$count)

# Convert Data to Lognormal
n.data$count <- log(n.data$count)
hist(n.data$count)

# Check Normallacy of Lognormal Data ------------------
' Shapiro Test:
  - Null hypothesis:  Data is normally distributed
  - Pvalue:  If > 0.05, fail to reject null hypothesis.  
  - Data is not normally distributed. 
'
qqnorm(n.data$count)
qqline(n.data$count)
shapiro.test(n.data$count)

# Compare with Normally Distributed Data
gaus.data <- rnorm(5000)
qqnorm(gaus.data)
qqline(gaus.data)
shapiro.test(gaus.data)


# Check for Homogenius Variance -----------------------
' Brown-Forsyteh Test:
  - Pvalue less than 0.05 indicates that the variances
    are not equal. 
'
boxplot(n.data$count ~ n.data$spray)
ggline(n.data, x='spray', y="count", 
       add=c("mean_se", "jitter"), main='Mean & Standard Error Plot')
leveneTest(count ~ spray, data=n.data, center=mean)
hov(n.data$count ~ n.data$spray)
hovPlot(n.data$count ~ n.data$spray)


# Random and Equal Sample Sizes -----------------------
n.samples <- n.data %>% group_by(spray) %>% sample_n(size=20, replace=TRUE)
group_by(n.samples, spray) %>% summarise(n(), mean(count))



# Manually Calculate Within and Between Variance ------

n <- tapply(n.samples$count, n.samples$spray, length)
total.mean <- mean(n.samples$count)
group.mu <- tapply(n.samples$count, n.samples$spray, mean)



