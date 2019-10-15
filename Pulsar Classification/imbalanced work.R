library(ROSE)
library(rpart)

data(hacide)

head(hacide.test)
head(hacide.train)
treefit <- rpart(cls~.,data = hacide.train)
predTree <- predict(treefit, newdata = hacide.test)

accuracy.meas(hacide.test$cls, predTree[,2])

roc.curve(hacide.test$cls, predTree[,2], plotit = F)

dataBalancedOver <- ovun.sample(cls~., data = hacide.train, method = 'over', N = 1960)$data
table(dataBalancedOver$cls)

dataBalancedUnder <- ovun.sample(cls~., data = hacide.train, method = 'under', N = 40, seed = 1)$data
table(dataBalancedUnder$cls)

dataBalancedBoth <- ovun.sample(cls~., data = hacide.train, method = 'both', p = 0.5, N = 1000, seed = 1)$data
table(dataBalancedBoth$cls)

dataRose <- ROSE(cls~., data = hacide.train, seed = 1)$data

table(dataRose$cls)


treeRose <- rpart(cls~., data = dataRose)
treeBoth <- rpart(cls~.,data = dataBalancedBoth)
treeUnder <- rpart(cls~., data = dataBalancedUnder)
treeOver <- rpart(cls~., data = dataBalancedOver)

predtreeRose <- predict(treeRose, newdata = hacide.test)
predtreeBoth <- predict(treeBoth, newdata = hacide.test)
predtreeUnder <- predict(treeUnder, newdata = hacide.test)
predtreeOver <- predict(treeOver, newdata = hacide.test)


roc.curve(hacide.test$cls, predtreeRose[,2])
roc.curve(hacide.test$cls, predtreeBoth[,2])
roc.curve(hacide.test$cls, predtreeUnder[,2])
roc.curve(hacide.test$cls, predtreeOver[,2])

ROSE.holdout <- ROSE.eval(cls ~ ., data = hacide.train, learner = rpart, method.assess = "holdout", extr.pred = function(obj)obj[,2], seed = 1)

ROSE.Boot <- ROSE.eval(cls ~ ., data = hacide.train, learner = rpart, method.assess = "BOOT", extr.pred = function(obj)obj[,2], seed = 1)


class(ROSE.Boot)



str(hacide.test)
str(hacide.train)
table(hacide.test$cls)
table(hacide.train$cls)
