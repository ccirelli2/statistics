# DOCUMENTATION ------------------
'

'
# Load Libraries
library(readxl)

# Set working directory
setwd("C:\\Users\\chris.cirelli\\Desktop\\repositories\\fire_resp_time\\data")
list.files()

# Load Data
claims.data <- read_xlsx("fire_claims_v3.xlsx")
loss.data <- claims.data$TOTAL_INCURRED


# Inspect Data
plot(loss.data)
barplot(loss.data)
hist(loss.data, breaks = 20)

# Drop Outliers
loss.data.lim <- loss.data[loss.data > 5000]

# Inspect Limited Data
hist(loss.data.lim, breaks = 20)

# Convert to log
log.loss <- log(loss.data.lim)


# Plot 
hist(log.loss, breaks =20)

# Test Normalicy
'Looking for a pvalue > 0.05'
qqnorm(log.loss, qqline(log.loss))
shapiro.test(log.loss)
shapiro.test((rnorm(5000)))
