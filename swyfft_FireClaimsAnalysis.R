'

Connect to DB
https://support.rstudio.com/hc/en-us/articles/214510788-Setting-up-R-to-connect-to-SQL-Server-
'
# Clear namespace
rm(list=ls())
dev.off(dev.list()["RStudioGD"])

# Load Libraries
library("readxl")
setwd("C:\\Users\\chris.cirelli\\Dropbox (Swyfft)\\cc2_dropbox\\DS_topics\\FireRespTime_study\\data")
c.data <- read_excel("fire_claims.xlsx")


# Inspect Data
summary(c.data)
head(c.data)
colnames(c.data)
total.incurred <- as.numeric(c.data$TOTAL_INCURRED)

# Descriptive statistics
summary(total.incurred)
mu.1 <- mean(total.incurred)
md.1 <- median(total.incurred)

# Plot
x.count <- seq(1, length(total.incurred))
plot(x= total.incurred, y=x.count, main='Total Incurred Claims', xlab='Claim', ylab='Incurred ($)')
abline(v=mu.1, col='red')
abline(v=md.1, col='green')
text(mu.1, 0, "Mean", col='red')
text(md.1, 20, "Median", col='green')







