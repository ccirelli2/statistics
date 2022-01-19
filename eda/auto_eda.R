'Automated EDA packages

 Ref: https://towardsdatascience.com/four-r-packages-for-automated-exploratory-data-analysis-you-might-have-missed-c38b03d4ee16
'
################################################################################
# Setup
################################################################################

# Clear Namespace
rm(list=ls())

# Clean Plots
dev.off(dev.list()["RStudioGD"]) 

# Set Present-Working-Directory
dir.root = '/home/oem/repositories/statistics'
setwd(dir.root)


# Libraries
library(dplyr)
library(readr)
install.packages("DataExplorer")

# Load Data
df <- 
  read_delim(
    file = paste(dir.root, "/data/cardio_train.csv", sep=""),
    col_types = "iifidiiffffff",
    delim=";")

# Pre-Processing
'Convert age from days to years
 remove id column (-id means drop)'
df <- 
  # remove the id
  select(df, -id) %>%
  # age: days -> years
  mutate(age = round(age / 365))

# observe first rows
head(df)


################################################################################
# Data Explorer
################################################################################
'Can generate a complete html report on data.
 Additional helpful functions to create plots.
'













