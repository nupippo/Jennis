rm(list = ls())
setwd("D:/workspace_R/thalas/")
library(xgboost)
library(caret)
library(mgcv)
library(feather)
library(e1071)
library(naivebayes)
# load("D:/workspace_R/thalas/20180304/dataset/snp_clean.RData")
load("D:/workspace_R/thalas/20180427/dataset/snp_missing_1per_numeric.RData")

set.seed(546789)
indexFolds <- createFolds(snp.clean$case,5)
snp.fold1 <- snp.clean[indexFolds$Fold1,]
snp.fold2 <- snp.clean[indexFolds$Fold2,]
snp.fold3 <- snp.clean[indexFolds$Fold3,]
snp.fold4 <- snp.clean[indexFolds$Fold4,]
snp.fold5 <- snp.clean[indexFolds$Fold5,]

# tr <- rbind(snp.fold1,snp.fold2,snp.fold3)
# val <- snp.fold4
# 
# te <- snp.fold5

### for test
tr <- rbind(snp.fold1,snp.fold2,snp.fold3,snp.fold4)
te <- snp.fold5



tr.x <- tr[, !(colnames(tr) %in% c("case"))]
tr.y <- data.frame(tr$case)

te.x <- te[, !(colnames(te) %in% c("case"))]
te.y <- data.frame(te$case)

importance <- read.csv(file = 'D:/workspace_R/thalas/20180427/result/chi/chi_test_fold5.csv',header = F)
colnames(importance) <- 'pvalue'
importance$nm <- colnames(tr.x)


importance <- importance[order(importance$pvalue),] 
importance2 <- importance[importance$pvalue <= 0.05,]

param.c <- 1

xx <- 1:2

tr.fe <- tr.x[,importance2$nm[xx]]
te.fe <- te.x[,importance2$nm[xx]]

model <- svm(tr.fe,tr.y,type = 'C-classification',cost = param.c)
result <- predict(model,te.fe)
result <- as.numeric(levels(result))[result]
confusionMatrix(reference = te.y$te.case,result)
