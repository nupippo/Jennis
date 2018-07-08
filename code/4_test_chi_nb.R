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

# param.c <- c(0.0001,0.001,0.01,0.1,1.0,10,100,1000,10000)

xx <- 1:16

tr.fe <- tr.x[,importance2$nm[xx]]
te.fe <- te.x[,importance2$nm[xx]]

model <- naive_bayes(x = tr.fe,y = tr.y$tr.case, usekernel = TRUE)
result <- predict(model,te.fe)
confusionMatrix(reference = te.y$te.case,result)
