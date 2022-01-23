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
library(DataExplorer)

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
'Can generate a complete html report on data by calling create_report function.
 Additional helpful functions to create plots.
'

### Create Complete HTML Report
df %>%
  create_report(
    output_file = paste("Report_cardiovascular_disease", format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z"), sep=" - "),
    output_dir=paste(dir.root, "/data", sep=""),
    report_title = "EDA Report - Cardiovascular Disease Dataset",
    y = "cardio"
  )

### Useful Plots

# Data-Structure
plot_str(df)

# Bar-Graph-By-Group
'In this case by cardio vascular disease'
plot_bar(df, by='cardio')

# QQ Plots
'First plot the distribution'
hist(df$age)
plot_qq(df)

# Plot Densities
plot_density(df)

# Plot Heatmap
plot_correlation(df)


################################################################################
# GGally
################################################################################
install.packages("GGally")
library(GGally)

# change plot size (optional)
options(repr.plot.width = 20, repr.plot.height = 10)

df %>% 
  select("age", "cholesterol", "height", "weight") %>%
  ggpairs(mapping = aes(color = df$cardio, alpha = 0.5))


################################################################################
# SmartEDA
################################################################################
library(SmartEDA)

# similarly, with dplyr syntax: df %>% ExpReport(...)
ExpReport(
  df,
  Target="cardio",
  label=NULL,
  op_file="Report.html",
  op_dir=getwd())

