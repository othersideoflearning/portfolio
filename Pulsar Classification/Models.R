library(ROSE)
library(rpart)
library(readr)
library(psych)
library(caret)
library(e1071)
library(rattle)
# library(naivebayes)
# library(Boruta)


HTRU_2 <- read_csv("D:/Academics/Semester-IV(Late Spring 2017)/Machine Learning - I/Project work/Data/HTRU2/HTRU_2.csv", col_types = cols(Class = col_factor(levels = c("0", "1"))), na = "NA")

# shuffling row qise

HTshuf <- HTRU_2[sample(nrow(HTRU_2)),]


# split into training and testing set being 80% data in training set

size <- round(nrow(HTshuf)*0.8)
trainset <- HTshuf[1:size,]
testset <- HTshuf[size: nrow(HTshuf),]

# feaSel <- Boruta(Class~., data = trainset, doTrace = 2)
# 
# feaSel$ImpHistory

# Chekcing the proportion of training and testing set pulsar Vs. noise

# prop.table(table(trainset$Class))
# prop.table(table(testset$Class))

# Creting decision tree moel

tree <- rpart(Class~., data = trainset)

# tree$variable.importance

predtree <- predict(tree, newdata = testset)

# Checking for accuracy of the model.

accuracy.meas(testset$Class, predtree[,2])
roc.curve(testset$Class, predtree[,2])

# Balancing imbalanced dataset with ROse Function

trainRose <- ROSE(Class~.,data = trainset, seed = 1)$data
testRose <- ROSE(Class~., data = testset, seed = 1)$data

# Checking the proportion of training and test set pulsar Vs. noise
# table(trainRose$Class)
# table(testRose$Class)

# Modeling with Decision Tree algorothm

treeRose <- rpart(Class~., data = trainRose)
# treeRose$variable.importance
PredtreeRose <- predict(treeRose, newdata = testRose)
# accuracy.meas(testRose$Class, PredtreeRose[,2])
# roc.curve(testRose$Class, PredtreeRose[,2])
# plotting tree
# fancyRpartPlot(treeRose, palettes=c("Greys", "Oranges"))


confusionMatrix(round(PredtreeRose[,2], digits = 0), testRose$Class)

# round(PredtreeRose[,2], digits = 0)
# plot(treeRose, uniform=TRUE, main="Classification Tree for Plusars")
# text(treeRose, use.n=TRUE, all=TRUE, cex=.7)
# labels(treeRose, digits = 4, minlength = 1L, pretty, collapse = FALSE)
# 
# plotcp(treeRose)
# text(treeRose)


# treeRoseImp <- rpart(Class~SkeIGP+EKIGP+MeanIG+SDDMSNR+EKDMSNR+MeanDMSNR+SDIGP, data = trainRose)
# treeRoseImp$variable.importance
# PredtreeRoseImp <- predict(treeRoseImp, newdata = testRose)
# accuracy.meas(testRose$Class, PredtreeRose[,2])
# roc.curve(testRose$Class, PredtreeRose[,2])

# accuracy.meas(testRose$Class, PredtreeRose[,2])
# roc.curve(testRose$Class, PredtreeRose[,2])

 # confusionMatrix(PredtreeRose, testset$Class)
# naive bayes

# Modleing with Naive Bayes Algorithm



# model2 <- naive_bayes(Class~.,data = trainRose)
# PredModel2 <- predict(model2, newdata = testRose)
# 
# plot(model2, which = NULL, ask = TRUE, legend = TRUE, main = "Naive Bayes Plot")

# Modeling with Naive Bayes Algorithn
model <- naiveBayes(Class~., data = trainRose)

# Stats of model
# class(model)
# summary(model)
# print(model)

# Predecting pulsar or noise using developed model
predmodel <- predict(model, newdata = testRose)

# Checking accuracy of the model
confusionMatrix(predmodel, testRose$Class)
# roc.curve(testRose$Class, predmodel )
