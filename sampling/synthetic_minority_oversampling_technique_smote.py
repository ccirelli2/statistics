# -*- coding: utf-8 -*-
"""
Ref : https://machinelearningmastery.com/smote-oversampling-for-imbalanced-classification/
    https://machinelearningmastery.com/multi-class-imbalanced-classification/
    https://scikit-learn.org/stable/modules/generated/sklearn.datasets.make_classification.html
    https://imbalanced-learn.readthedocs.io/en/stable/user_guide.html
Created on Fri Oct  9 10:22:36 2020
@author: chris.cirelli
"""

###############################################################################
# Import Packages
###############################################################################
import imblearn

from collections import Counter
from sklearn.datasets import make_classification
from sklearn import datasets
from sklearn.preprocessing import LabelEncoder
from matplotlib import pyplot as plt
import numpy as np
import pandas as pd
from imblearn.over_sampling import SMOTE
from matplotlib import pyplot
from numpy import where

###############################################################################
# Load Data
###############################################################################




###############################################################################
# Create Synthetic Datasets
###############################################################################

def get_dataset(type_):
    if type_ == 'binary':
        # Binary
        X, y = make_classification(
            n_samples=10000, n_features=2, n_redundant=0,
            clusters_per_class=1, weights=[0.99], flip_y=0, random_state=1)
        return X, y
    elif type_ == 'multi':
        # Multiclass
        url = 'https://raw.githubusercontent.com/jbrownlee/Datasets/master/glass.csv'
        df_multi = pd.read_csv(url, header=None)
        data_multi = df_multi.values
        X, y = data_multi[:, :-1], data_multi[:, -1]
        y = LabelEncoder().fit_transform(y)
        return X, y

X, y = get_dataset(type_='multi')
    
# Counter
classes = Counter(y)

# Plot Distribution
def plot_dist(y):
    class_dist = Counter(y)
    plt.bar(x=class_dist.keys(), height=class_dist.values())
    plt.show()

plot_dist(y)

# Create a Scatter Plot of Classes
def gen_scatter_lot(X, y):
    df = pd.DataFrame({})
    df['x0'] = [x[0] for x in X]
    df['x1'] = [x[1] for x in X]
    df['y'] = y
    df_grouped = df.groupby('y')
    
    for name, group in df_grouped:
        plt.scatter(group['x0'], group['x1'], label=name)
        
###########################################################################
# Oversampling Using SMOTE
###########################################################################
def test():
# transform the dataset
    oversample = SMOTE()
    X, y = oversample.fit_resample(X, y)
    # summarize the new class distribution
    counter = Counter(y)
    print(counter)
    # scatter plot of examples by class label
    for label, _ in counter.items():
    	row_ix = where(y == label)[0]
    	pyplot.scatter(X[row_ix, 0], X[row_ix, 1], label=str(label))
    pyplot.legend()
    pyplot.show()

