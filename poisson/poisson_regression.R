## DOCUMENTATION _______________________________________________
'	Desc:	Poisson regression tutorial. 
	Ref:	https://www.dataquest.io/blog/tutorial-poisson-regression-in-r/
  Ref:  https://en.wikipedia.org/wiki/Poisson_distribution
  
  PDF:  probability density function is a function that describes the relative 
  likelihood that a continuous random variable (a variable whose possible 
  values are continuous outcomes of a random event) will have a given value.   
'

# What are Poisson Regression Models? ------------------------------
' Use: Best used for modeling events where the outcomes are counts, ie "count data"
  Count data: discrete data with non-negative integer values that count something. 
  Ex:  The number of times an event occurs during a given timeframe, 
  Ex: The number of people in line at the grocery store for a given time period. 
  
  Count data:  Can also be expressed as rate data, i.e. number of times in a day
  week, month, etc. 

  Why use Poisson Regression?
  - It helps us to analyze which explanatory variables (X values) have an effect
    on a given response value (Y value, the count or rate). 
  - For instance, a grocery store could use pr to understand and predict the
    number of people in line. 

  Assumptions
  - An event can occur any number of times during a time period.
  - Events occur independently. In other words, if an event occurs, it does not affect the 
    probability of another event occurring in the same time period.
  - The rate of occurrence is constant; that is, the rate does not change based on time.
  - The probability of an event occurring is proportional to the length of the time period. 
    For example, it should be twice as likely for an event to occur in a 2 hour time period than 
    it is for an event to occur in a 1 hour period.

'


# What is a Poisson Distribution? -----------------------------------
' Distribution to model the probability of event or events occuring within
  a specific timeframe.  
  It assumes that y occurences are not affected by the timing of previous
  occurences of y. 
  
  Another Definition: The Poisson distribution is the discrete probability distribution of the number of \
  events occurring in a given time period, given the average number of times the 
  event occurs over that time period.
  

  From stats book: "A widely used distribution emerges from the concept that 
    events occur randomly in an interval (or region).  The random variable
    of interest is the count of the events that occur within the interval. 
  
  Ex from stats book:  
    Calculate the number of flaws per milimeter in a copper wire with 
    a mean of 2.3 flaws per millimeter. Determine the probability of 
    exactly two flaws in 1 millimerter of wire.  Let X denote the number
    of flaws in 1 millimeter of wire. Then Lambda*T = 2.3 flaws and
    
    P(X=2) = e^-2.3 * 2.3^2 / 2!
    '

px_2 <- (exp(1)^-2.3 * 2.3^2) / factorial(2)

for (i in 1:6){
  shit <- (exp(1)^-i * i^2) / factorial(2)
  print(shit)
  }


# Visualize Poisson Distribution Plot -----------------------------

# vector of colors
colors <- c('Red', 'Blue', 'Gold', 'Black', 'Pink', 'Green')

# list to hold distribution values
poisson.dist <- list()

# vector of values for mu
mu <- c(1,2,3,4,5,6)

# iterate list of mu values.
' dpois(x, lambda, log=False)'
for (i in 1:6){
  poisson.dist[[i]] <- c(dpois(0:20, i))
}

# Plot values 
plot(unlist(poisson.dist[1]), type='o', xlab='y', ylab="P(y)", 
            col= colors[i])
for (i in 1:6){
  lines(unlist(poisson.dist[i]), type='o', col=colors[i])
}
legend("topright", legend = mu, inset = 0.08, cex = 1.0, fill = colors, title = "Values of u")


# How does poisson distribution differ from a normal dist? --------
' Use of count data vs continuous variables. 
  Skewed depending on value of lambda
  Variance = Mean vs variance and mean being different parameters. 

'


# Example of Calculating a Probability Using Poisson Dist ---------
' If there are 12 cars crossing a bridge on average per minute, what
  is the probability of having seventeen or more cars cross the bridge 
  in any given minute?

  ppois:  density function.  ppois(q, lambda, lower.tail=True)
    q,      vector of quantiles
    lambda  vector of non-negative means. 
    lower.tail=False: means P[X > x]
'
ppois(16, 12, lower.tail=FALSE)   # note we use 16 because we are looking for
                                  # 17 or more. 


# Poisson Regression Models and GLMs ------------------------------
' GLM:  Are linear models in which response variables follow a 
        distribution other than a normal distribution. This is because
        glm models have response variables that are categorical. 
  Link: To transform a non-linear relationship to a linear form, a 
        link function is used, which is the log for the Poisson 
        regression.  
        
        Log(y) = alpha + b1x1 + b2x2  bpxp
        alpha is the intercept. 
        coefficients are calculated using MLE
  Ex:   log(y) = alpha + b(x)
        y = e^(alpha) + e^bx
        
        
  Assumptions:
      - One of the most import assumptions abou the poisson distribution 
      and by extension poisson regress is the euidispersion characteristic, 
      which means that the mean and variance of the distribution are equal. 
      Therefore, sigma^2 must be equal to 1. 
      - When variance is > mean, this is called over-dispersion. 
'


# Fitting a model ----------------------------------------------
' glm(formula, family=gaussian/poisson, data, weights, subset)

'
# Data
' Looks at how many warp breaks occured for different types of looms
  per loom, per fixed length of yarn. 
  y= breaks
  x = wool and tension

'
data <- warpbreaks
col_names <- names(data)
ls.str(warpbreaks)

# Plot histogram of dependent variable (breaks)
hist(data$breaks)
mean(data$breaks)
var(data$breaks)   # var is > mean.  Indication of over dispersion. 


# Fit Model 
poisson.model <- glm(breaks ~ wool + tension, data, family=poisson(link='log'))
summary(poisson.model)


# Interpreting the Poisson Model
' exp(α)= effect on the mean μ, when X = 0
  exp(β) = with every unit increase in X, the predictor variable has multiplicative effect of exp(β) on the mean of Y, that is μ
  If β = 0, then exp(β) = 1, and the expected count is exp(α) and, Y and X are not related.
  If β > 0, then exp(β) > 1, and the expected count is exp(β) times larger than when X = 0
  If β < 0, then exp(β) < 1, and the expected count is exp(β) times smaller than when X = 0

  Pvalue: to see which variables have an effect on the response variable we look
          at the p-values.  if p < 0.05 then the variable has an effect. 
  
  *Over dispersion:  if the residual deviance > degrees of freedom then we 
   have an over dispersion. 

  Note: R automatically converts categorical variables to dummy ones?
  The Null deviance shows how well the response variable is predicted by a 
  model that includes only the intercept (grand mean) whereas residual with 
  the inclusion of independent variables. Above, we can see that the addition 
  of 3 (53-50 =3) independent variables decreased the deviance to 210.39 from 
  297.37. Greater difference in values means a bad fit.

'

# Make a prediction
newdata <- data.frame(wool='B', tension='A')
predict(poisson.model, newdata=newdata, type='response')
