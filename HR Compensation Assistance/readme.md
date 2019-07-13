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

${\displaystyle \operatorname {MSE} ={\frac {1}{n}}\sum _{i=1}^{n}(Y_{i}-{\hat {Y_{i}}})^{2}.}$
