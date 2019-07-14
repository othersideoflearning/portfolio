# Can we determine the price of an item based on its description?

## Nuts and Bolts
To answer this question I have used mercari provided the dataset. <br>

` According to mercari`- 
 > "Mercari is the selling app. We make it super easy to sell (or buy) almost anything. We all have things we don't use, never used or simply outgrew. However, that stuff still has value. Mercari gives you the power to simply sell it, ship it, and earn some cash for it. Fashion to toys. Sporting goods to electronics. All the brands you know and love".<br>

***Data Description:***

- **train_id:** The id of the listing.
- **name:** The title of the listing. 
- **item_condition_id:** The condition of the items provided by the seller.
- **category_name:** Category of the listing.
- **brand_name:** Brand name of the product.
- **Shipping:** 1 if the seller pays and 0 if buyer pays the shipping fee by buyer.
- **item_description:** Full description of the item. 
- **Price:** The price of an object.  Price is the target variable for this analysis. The unit of cost is in USD. 


## Evaluation Metric
Root Mean Squared Logarithmic Error was chosen as an evaluation metric for this analysis.

The mathematical formula for RMSLE is

> <img src="https://latex.codecogs.com/png.latex?\bg_white&space;\epsilon&space;=&space;\sqrt{\frac{1}{n}\sum_{i=1}^{n}(log(p_{i}&plus;1)-log(a_{i}&plus;1))^{2}}" title="\epsilon = \sqrt{\frac{1}{n}\sum_{i=1}^{n}(log(p_{i}+1)-log(a_{i}+1))^{2}}" />

Where:
- *ϵ* is the RMSLE value (score)
- *n* is the total number of observations in the (public/private) data set,
- *pi* is your prediction of price, and
- *ai* is the actual sale price for i. 
- *log(x)* is the natural logarithm of x

## Scope of the work
* Clean and preprocess the data.
*  Exploratory analysis on the preprocessed data.
* Develop a model using supervised learning techniques.
* Since we are predicting continuous variable(Price), using below regression algorithms.
    - Ridge Regression
    - Lasso
    - Linear Regression
    - RandomForest Regressor
    - XGBoost Regressor
    - LightGBM Regressor
* Generate a file with predictions for look up style deployment.

## Future Work
* More feature engineering by combining all the text into one feature then process the previously mentioned NLP techniques to extract the information.
* Use deep neural nets to obtain more information from the text.
* Run on GPUs to get the adequate computational power to run neural nets.
* Create an API which can take features as an input and spits out predictions.
* Further optimization to improve prediction accuracy.



## Benchmark Results
The benchmark RMSLE value for this analysis is 0.5. Anything below that is treated as a good model.

### Quick Notes:
 1) Currently, the complete analysis is available in Jupyter Notebook.
 2) I have used an experimental approach to create the report.
 3) I have a plan to create production-ready python file and upload it shortly.
