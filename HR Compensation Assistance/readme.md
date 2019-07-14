# Recruiter's Compensation Assistance tool.

## Nuts and Bolts
* In this casestudy, we are going to develop a mathematical model whihc can predict the salary for a job based on various features such as `Years of Experience`, `Miles From Metropolis`, `Degree`, `Industry`, `Major` and `Job Type.`<br>
 * There are 2 million observations in the dataset with the following features.
* The dataset used for this analysis is consisting of a million observations with 8 features
  - JobId: Job id for the role
  - CompanyId: CompanyId for the respective job id.
  - Degree: Applicant's degree for the respective job id. Available categories are 'MASTERS', 'HIGH_SCHOOL', 'DOCTORAL', 'BACHELORS', 'NONE'
  - Major: specialization of major degree for the respective applicant.
  - Industry: Job industry for the respective job id.
  - YearsExperience: Years of experience for the respective applicant.
  - MilesFromMetropolis: Distance between the work area and nearby metropolitan city.
  - Salary: Salary in thousands for the respective job id.
  
## Evaluation Methods

*If a vector of ***n*** predictions generated from a sample of n data points on all variables, and ***Y*** is the vector of observed values of the variable being predicted, then the within-sample MSE of the predictor is computed as*

<img src="https://latex.codecogs.com/png.latex?\bg_white&space;MSE&space;=\frac{1}{n}\sum&space;\left&space;(&space;Y_{i}-\hat{Y}_{i}&space;\right&space;)^{2}" title="MSE =\frac{1}{n}\sum \left ( Y_{i}-\hat{Y}_{i} \right )^{2}" />


## Scope of the Work
* Since we planned to predict the salary, we are using regression techniques to solve the problem.
* Clean and preprocess the data.
* Exploratory analysis on the given data
* Below are the list of algorithms planning to apply during the development.
  - Linear Regression
  - Linear Regression with Polynomial features
  - Ridge Regressio
  - Random Forest Regressor
  - Gradient Boost Regressor
  - LightGBM Regressor
* Generate file with predictions for lookup style deployment.

## Future work
* Creatre a API which can take features as an input and spitout predictions.
* Further optimization to improve the prediction accracy.

## Benchmark Results
* The base line model prediction accuracy and MSE values are treated as bench mark results for this analysis. 
