' Null Hypothesis:  Equal medians
  Conditions:       i. Equal variance, 
                   ii. Independent samples
                   * Does not require normal dist of data. 
  Ref: https://data.library.virginia.edu/the-wilcoxon-rank-sum-test/#:~:text=Whereas%20the%20null%20hypothesis%20of,distribution%20with%20the%20same%20median.

'

# Clear Namespace
rm(list=ls())

# Create Dataset
A <- c(117.1, 121.3, 127.8, 121.9, 117.4, 124.5, 119.5, 115.1)
B <- c(123.5, 125.3, 126.5, 127.9, 122.1, 125.6, 129.8, 117.2)
dat <- data.frame(weight = c(A,B), 
                  company = rep(c("A","B"), each=8))

head(dat)

# Generate Box Plot
'Data appears to have the same spread but is likely not normal'
boxplot(weight ~ company, data = dat)


# Run Wilcoxon Rank Sum Test 
' P-value less than 0.05 indicates that the medians are likely diff. 
  W = wilcox statistic and equals the number of times the weight in 
      company B is less than company A. 

'
wilcox.test(weight ~ company, data = dat)
