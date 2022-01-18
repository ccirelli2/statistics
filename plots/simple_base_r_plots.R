'Examples of Simple R Plots
 ref: https://intro2r.com/simple-base-r-plots.html
'
################################################################################
# Setup
################################################################################

# Clear Namespace
rm(list=ls())

# Clean Plots
dev.off(dev.list()["RStudioGD"]) 

# Set Present-Working-Directory
setwd('/home/oem/repositories/statistics')

# Libraries
library(vioplot)

# Load Data
flowers.data <- read.table('data/flower.csv', header=TRUE, sep="\t", stringsAsFactors =TRUE)

################################################################################
## Plots
################################################################################

## Scatter
plot(flowers.data$weight, main='Flower Weight')


## Specify Type of plot
x <- seq(1: 100)
y <- rnorm(100)

plot(x, y, type='l')
plot(x, y, type='b') # both line and point

## Histogram (Add Density Line to histogram)
dens <- density(flowers.data$weight)
hist(flowers.data$weight)
hist(flowers.data$weight, freq=FALSE)
lines(dens)

## Box-plots
boxplot(weight ~ nitrogen, data=flowers.data, ylab = 'weight', xlab='height',
        main= 'Weight ~ Height By Nitrogen Lvl')

# Box-plot two factors
boxplot(weight ~ nitrogen * treat, data=flowers.data, ylab = 'weight', xlab='height',
        main= 'Weight ~ Height By Nitrogen Lvl', cex.axis=0.7)

## Violin Plot
vioplot(weight ~ nitrogen, data=flowers.data, ylab = 'weight', xlab='height',
        main= 'Weight ~ Height By Nitrogen Lvl')

vioplot(weight ~ nitrogen * treat, data=flowers.data, ylab = 'weight', xlab='height',
        main= 'Weight ~ Height By Nitrogen Lvl + Treat')

## Pairwise Plots
pairs(flowers.data[, c("height", "weight", "nitrogen")])

# w/ Correlation
panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * r)
}

pairs(flowers.data[, c("height", "weight", "nitrogen")], lower.panel = panel.cor)


## Dot Charts
'Used for identifying outliers in data.
 Plot single continous variable on x axis and in the order it occurs on
 the y-axis.'
dotchart(flowers.data$height, main='Height')

# By group
dotchart(flowers.data$height, main='Height', groups = flowers.data$nitrogen)


## Co-plots
' Used to visualize the relationship between two numeric variables across
  the spectrum of a third.
  The panels are read from bottom left to top right along each row. 
'
# Simple plot
coplot(height ~ weight|nitrogen, data=flowers.data, overlap=0)

# Second Interaction
coplot(height ~ weight|nitrogen * treat, data=flowers.data, overlap = 0,
       main = 'Height ~ Weight | nitrogen * treat')


# Regression Line
coplot(flowers ~ weight|nitrogen * treat,
       data = flowers.data,
       panel = function(x, y, ...) {
         points(x, y, ...)
         abline(lm(y ~ x), col = "blue")})


