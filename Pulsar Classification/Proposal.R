library(readr)
library(psych)


HTRU_2 <- read_csv("D:/Academics/Semester-IV(Late Spring 2017)/Machine Learning - I/Project work/Data/HTRU2/HTRU_2.csv", col_types = cols(Class = col_factor(levels = c("0", "1"))), na = "NA")

View(HTRU_2)


str(HTRU_2)

prop.table(table(HTRU_2$Class))

HTshuf <- HTRU_2[sample(nrow(HTRU_2)),]
nrow(HTshuf)

size <- round(nrow(HTshuf)*0.8)
testset <- HTshuf[size: nrow(HTshuf),]
trainset <- HTshuf[1:size,]

pairs.panels(trainset[c('MeanIG','SDIGP', 'EKIGP', 'SkeIGP','MeanDMSNR', 'SDDMSNR', 'EKDMSNR', 'SkeDMSNR')])

nrow(HTshuf)* 0.8
round(nrow(HTshuf) * 0.8)
round(nrow(HTshuf) * 0.1)
