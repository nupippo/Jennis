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

k <- 10
importance <- read.csv(file = paste0('D:\\workspace_R\\thalas\\20180427\\result\\relieff\\relieff_test_fold5_k',k,'.csv',sep=""),header = F)
importance$nm <- colnames(tr.x)
colnames(importance) <- c('score','nm')  

importance <- importance[order(-importance$score),] 

xx <- 1:234

tr.fe <- tr.x[,importance$nm[xx]]
te.fe <- te.x[,importance$nm[xx]]

param <- list("objective" = "binary:logistic",
              # "scale_pos_weight" = 0.65,
              "bst:eta" = 0.0001,
              # "colsample_bytree" = colsam[i],
              "bst:max_depth" = 5,
              "eval_metric" = "auc",
              "silent" = 1,
              "nthread" = 6)

set.seed(123)
model <- xgboost(data = data.matrix(tr.fe),
                 label = tr.y$tr.case,
                 params = param,
                 nround = 1000,
                 # silent = 1
)

result <- predict(model,data.matrix(te.fe))
result[result >= 0.5] <- 1
result[result < 0.5] <- 0
confusionMatrix(reference = te.y$te.case,result)