# Recruiter's Compensation Assistance tool

## Nuts and Bolts
* In this project, we are developing a mathematical model which can predict the salary for a job based on various features such as Years of Experience, Miles From Metropolis, Degree, Industry, Major and Job Type.
* The dataset used for this analysis is consisting of a million observations with eight features.
* There are 2 million observations in the dataset with the following features.
  - JobId
  - CompanyId
  - Degree 
  - Major
  - Industry
  - YearsExperience
  - MilesFromMetropolis
  - Salary 
## Evaluation Methods

*If a vector of ***n*** predictions generated from a sample of n data points on all variables, and ***Y*** is the vector of observed values of the variable being predicted, then the within-sample MSE of the predictor is computed as*

<img src="https://latex.codecogs.com/png.latex?\bg_white&space;MSE&space;=\frac{1}{n}\sum&space;\left&space;(&space;Y_{i}-\hat{Y}_{i}&space;\right&space;)^{2}" title="MSE =\frac{1}{n}\sum \left ( Y_{i}-\hat{Y}_{i} \right )^{2}" />


## Scope of the Work
* Since we planned to predict the salary, we are using regression techniques to solve the problem.
* Clean and preprocess the data.
* Exploratory analysis of the given data.
* Below is the list of algorithms to apply during the development.
  - Linear Regression
  - Linear Regression with Polynomial features
  - Ridge Regression
  - Random Forest Regressor
  - Gradient Boost Regressor
  - LightGBM Regressor
* Generate a file with predictions for lookup style deployment.

## Future work
* Create an API which can take features as an input and spits out predictions.
* Further optimization to improve prediction accuracy.

## Benchmark Results
* The results of the baseline model, such as prediction accuracy and MSE values are benchmark results for this analysis.
