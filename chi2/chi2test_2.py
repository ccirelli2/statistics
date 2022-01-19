import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from scipy.stats import chi2_contingency
from scipy.stats import chi2




# Description -----------------------------------------------------------
'''
Introduction to Pearson Chi-squared goodness of fit test

References:
1.) https://en.wikipedia.org/wiki/Chi-squared_distribution
2.) https://en.wikipedia.org/wiki/Chi-squared_test
3.) https://machinelearningmastery.com/chi-squared-test-for-machine-learning/
4.) https://www.itl.nist.gov/div898/handbook/eda/section3/eda3674.htm
'''

# Definition ------------------------------------------------------------
'''
Chi2-Distr      | is the distribution of the sum of the squares of k independent
                | standard normal random variables.
Degrees of Fre  | equal to the number of standard normal deviates being summed.

Chi2-test       | refers to a certain type of statistical hypothesis test
                | that are valid to perform when the test statistics is
                | chi-squared distributed under the null hypothesis.

Purpose         | Determine whether there is a statistcally significant
                | difference (i.e. magnitude of difference that is unlikely
                | to be due to change alone) between the expected frequencies
                | in one or more categories of a so-called contingency table.

Null Hypothesis | The test statistic coputed from the observations follows a
                | X2 distribution.
                | *Test statistics that follow a X2 distribution occur when
                | the observed frequencies are independent and normally
                | distributed.  So by rejecting the null hypothesis you are
                | saying the opposite is true, i.e. the observations are not
                | independent nor normally distributed.

                | Under the nully hypothesis as the number of observations
                | "n" approaches infinity -> the limiting distribution of the
                | test statistic approaches a X2 distribution.

Test Statistic  | sigma (observed - expected)**2 / total observations
_______________________________________________________________________________

_______________________________________________________________________________
Example

Description     | Person's neighborhood of residence is independent of the person's
                | occupation.
                | Data:  three occupations, 4 neighborhoods

Table           |                   A   B   C   D   Total
                | White collar      90  60  104 95  349
                | Blue collar       30  50  51  20  151
                | No collar         30  40  45  35  150
                | Total             150 150 200 150 650


Calculate
Expected value  | Based on the total living in column A that are white collar,
                | how many would we expect to live there?
                | sum(colA) * sum(white_collar)/ table_sum
                | 150 * (349/650) ~ 80.54.
                | We should "expect" that given the 150 residents of neighborhood A
                | and the 349 total white collar workers that ~ 80.54 would be white
                | collar residents living in neighborhood A.


Question        | Is there a difference in the Null Hypothesis if we were to
                | transpose this matrix and have occupation as the columns and
                | neighborhoods as the rows?

'''

# Code Generate Chi-Squared Distribution ----------------------------------------


def plot_N01():
    N01 = np.random.normal(0, 1, 100000)
    plt.hist(N01, bins=1000)
    plt.pause(1)

def plot_ch2():
    N01 = np.random.normal(0, 1, 100000)
    chi2_ = (N01**2)
    plt.hist(chi2_, bins=100)
    plt.pause(5)

# Code for Example 1 -------------------------------------------------------------


# Observed Frequencies by Occupation & Neighborhood
df_act = pd.DataFrame({}, index=['White collar', 'Blue collar', 'No collar'])
df_act['A'] = [90, 30, 30]
df_act['B'] = [60, 50, 40]
df_act['C'] = [104, 51, 45]
df_act['D'] = [95, 20, 35]

# Expected Values Vased on Total Observations By Neighborhood * (Total Occupation / Table Sum)
df_exp = pd.DataFrame({}, index=['White collar', 'Blue collar', 'No collar'])
df_exp['A'] = df_act.loc[:, 'A'].sum() * (df_act.sum(axis=1) / df_act.sum().sum())
df_exp['B'] = df_act.loc[:, 'B'].sum() * (df_act.sum(axis=1) / df_act.sum().sum())
df_exp['C'] = df_act.loc[:, 'C'].sum() * (df_act.sum(axis=1) / df_act.sum().sum())
df_exp['D'] = df_act.loc[:, 'D'].sum() * (df_act.sum(axis=1) / df_act.sum().sum())


# Calculate statistic (observed - expected)**2 / expected
''' What does this statistic intuitively say?
    What is the squared difference of my actual minus expected as a prct
    of my expected?  Very large values will indicate a large relative diff.
    p-value
'''
df_stat = ((df_act - df_exp)**2) / df_exp


# Test Statistic
''' The sum of these quantities over all the cells is the test statistic.
'''
test_statistic = df_stat.sum().sum()

# Degrees of Freedom
''' (number of rows -1)*(number of columns -1)
'''

# Utilizing Scipy Function -----------------------------------------
contingency_table = df_act.to_numpy()
stat, p, dof, expected = chi2_contingency(contingency_table)


# Compare Results From Manually Calculated Statistic vs Scipy Package
print('Manually calculated statistic => {} vs Scipy => {}'.format(test_statistic, stat))



# Obtain Critical Value & Compare to Test Statistic
''' The Crirical value will represent the the minimum value
    obtained from the chi-squared distribution that the test-
    statistic can take.  If the test statistic is > then we
    reject the null-hypothesis.

    Explanation of the critical value: https://www.itl.nist.gov/div898/handbook/eda/section3/eda3674.htm
'''

prob = 0.95
alpha = 1-prob
critical = chi2.ppf(prob, dof)

if abs(stat) >= critical:
    print('Reject the null hypothesis as the stat => {} is > than critical value => {}'.format(
        stat, critical))
else:
    print('Fail to reject the null hypothesis as the stat => {} is < critical value => {}'.format(
        stat, critical))

if p <= alpha:
    print('Reject null hypothesis.  P {} <= alpha {}'.format(p, alpha))
else:
    print('Fail to reject the null hypothesis. Pvalue {} >= {}'.format(p, alpha))


