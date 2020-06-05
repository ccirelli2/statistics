# DOCUMENTATION -----------------------------------
' Desc:  Tutorial on how to implement ANOVA in R
  Ref:   https://data-flair.training/blogs/anova-in-r/
  Ref:   http://www.sthda.com/english/wiki/one-way-anova-test-in-r


  Description of ANOVA:
  The one-way analysis of variance (ANOVA), also known as one-factor ANOVA, 
  is an extension of independent two-samples t-test for comparing means in a 
  situation where there are more than two groups. In one-way ANOVA, 
  the data is organized into several groups base on one single grouping 
  variable (also called factor variable)

  ANOVA Hypothesis 
  - Null hypothesis: the means of the different groups are the same
  - Alternative hypothesis: At least one sample mean is not equal to the others.

  ANOVA Data Requirements
  - Observations are obtained independently and randomly from the 
    defined population. 
  - The data of each factor level are normally distributed
  - THe normal populations have common variance (Levenes Test)


  How one-way ANOVA test works?
  Assume that we have 3 groups (A, B, C) to compare:

  1. Compute the common variance, which is called variance 
     within samples (S2within) or residual variance.
  2. Compute the variance between sample means as follow:
     Compute the mean of each group
     Compute the variance between sample means (S2between)
  3.) Produce F-statistic as the ratio of S2between/S2within.
      Note that, a lower ratio (ratio < 1) indicates that 
      there are no significant difference between the means of the samples 
      being compared. However, a higher ratio implies that the variation among 
      group means are significant.

'


# Load Packages
library(dplyr)
library("ggpubr")
library(nortest)
library(moments)

# Load Data
'Results from an experiment to compare yields (as measured 
 by dried weight of plants) obtained under a control and two 
 different treatment conditions.
'
?PlantGrowth
my_data <- PlantGrowth
str(my_data)


# Get Random Sample
set.seed(1234)
sample_n(my_data, 10)
levels(my_data$group)
group_by(my_data, group) %>% 
  summarise(
    count = n(), 
    mean = mean(weight, na.rm=TRUE), 
    sd = sd(weight, na.rm = TRUE))

# Plot Data
hist(my_data$weight)
qqnorm(my_data$weight)
qqline(my_data$weight)

probplot(x, qdist=qnorm)

# Plot weight by group and color by group
ggboxplot(my_data, x = "group", y = "weight", 
          color = "group", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          order = c("ctrl", "trt1", "trt2"),
          ylab = "Weight", xlab = "Treatment")

# Means Plots
ggline(my_data, x = "group", y = "weight", 
       add = c("mean_se", "jitter"), 
       order = c("ctrl", "trt1", "trt2"),
       ylab = "Weight", xlab = "Treatment")


# Compute One-way ANOVA Test
' Interpreting Results:
  - You want to see a p-value below the significance level. 
    If we have this, then we can conclude that the there are
    significant differences between the groups with an *. 

'
res.aov <- aov(weight ~ group, data= my_data)
summary(res.aov)


# Tukey Multiple Pairwise-Comparison
'As the ANOVA test is significant, we can compute Tukey HSD 
 (Tukey Honest Significant Differences, R function: TukeyHSD()) for performing multiple pairwise-comparison between the means of groups.
 The function TukeyHD() takes the fitted ANOVA as an argument.

 diff: difference between means of the two groups
 lwr, upr: the lower and the upper end point of the confidence 
 interval at 95% (default)
 p adj: p-value after adjustment for the multiple comparisons.

  For this dataset, only the differences between trt2 and trt1 are significant.
'

TukeyHSD(res.aov)



# How to Check Homogeneity of Variance Assumptions
' Note the outliers = 17, 15, 4. You may want to remove
  these before running Anova'
plot(res.aov)


# Also can use LeveneTest
' If the pvalue is less than significance lvl, i.e. 5%, 
  then there is not enough evidence to suggest that the 
  variance across groups is statistically significantly 
  different'
library(car)
leveneTest(weight ~ group, data=my_data)

# See oneway.test & pairwise.t.test for non-normal dist data. 






















