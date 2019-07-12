# Can we determine the price of an item based on it's description?

## Nuts and Bolts
To answer this question I have used mecari provided dataset. <br>

` According to mercari`- 
 > "Mercari is the selling app. We make it super easy to sell (or buy) almost anything. We all have things we don’t use, never used or simply outgrew. But that stuff still has value. Mercari gives you the power to simply sell it, ship it, and earn some cash for it. Fashion to toys. Sporting goods to electronics. All the brands you know and love".<br>

***Data Description:***

- **train_id:** The id of the listing.
- **name:** The title of the listing. 
- **item_condition_id:** The condition of the items provided by the seller.
- **category_name:** Category of the listing.
- **brand_name:** Brand name of the product.
- **Shipping:** 1 if the seller pays and 0 if buyer pays the shipping fee by buyer.
- **item_description:** the full description of the item. 
- **price:** The price that the item.  Price is the target variable for this analysis. The unit of price is in USD. 


***Evaluation Metric:***
Root Mean Squared Logarithmic Error choosed for this analysis.

The mathematical formula for RMSLE is

> ***ϵ=1n∑i=1n(log(pi+1)−log(ai+1))2***

Where:
- *ϵ* is the RMSLE value (score)
- *n* is the total number of observations in the (public/private) data set,
- *pi* is your prediction of price, and
- *ai* is the actual sale price for i. 
- *log(x)* is the natural logarithm of x

```
Currently, entire analysis is available in Jupyter Notebook. I have use expermintal appraoch to create the anlaysis. I have a plan to create production ready python file. Soon I will uplod pyton file aswell
```
