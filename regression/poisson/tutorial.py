import pandas as pd
from patsy import dmatrices
import numpy as np
import statsmodels.api as sm
import matplotlib.pyplot as plt



# Documentation ---------------------------------------------
''' Tutorial for fitting poisson regression using Python
Ref: https://towardsdatascience.com/an-illustrated-guide-to-the-poisson-regression-model-50cccba15958
'''


# Define Directories ---------------------------------------
dir_data = r'/home/cc2/Desktop/repositories/statistics/data'

# Load Data ------------------------------------------------
df = pd.read_csv(dir_data + '/' + 'bicyclist_counts.csv', header=0,
                   infer_datetime_format=True, parse_dates=[0], index_col=[0])

# Model ----------------------------------------------------

# Add Additional Features to X Matrix
ds = df.index.to_series()
df['Month'] = ds.dt.month
df['Days_of_Week'] = ds.dt.dayofweek
df['Day'] = ds.dt.day


# Training & Test Set
'''By sampling from a N(1,0) distribution, and < 0.8, you get back boolean
   a boolean value True False, and presumably a certain % of that random list
   will be less than 0.8 based on the normal dist
'''
mask = np.random.rand(len(df)) < 0.8
df_train = df[mask]
df_test  = df[~mask]


# Setup the regression expression in patsy notation
expr = """BB_COUNT ~ Day + Days_of_Week + Month + HIGH_T + LOW_T + PRECIP"""


# Set up X and Y Matrices for the training and test data
y_train, X_train = dmatrices(expr, df_train, return_type='dataframe')
y_test, x_test = dmatrices(expr, df_test, return_type='dataframe')



# Train Poisson Regression Model
poisson_training_results = sm.GLM(y_train, X_train, family=sm.families.Poisson()).fit()

print(poisson_training_results.summary())













