rm(list = ls())
setwd("D:/workspace_R/thalas/")
library(xgboost)
library(caret)
library(mgcv)
library(feather)
library(e1071)
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
### blind

# tr.x <- tr[, !(colnames(tr) %in% c("case"))]
# tr.y <- data.frame(tr$case)
# 
# val.x <- val[, !(colnames(val) %in% c("case"))]
# val.y <- data.frame(val$case)
# 
# te.x <- te[, !(colnames(te) %in% c("case"))]
# te.y <- data.frame(te$case)

# path <- "D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold4_blind5_trX.feather"
# write_feather(tr.x, path)
# 
# path <- "D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold4_blind5_trY.feather"
# write_feather(tr.y, path)

# path <- "D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold4_blind5_teX.feather"
# write_feather(val.x, path)

### for test


path <- "D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_trainX_test5.feather"
write_feather(tr.x, path)


path <- "D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_trainY_test5.feather"
write_feather(tr.y, path)


# 
# tmp <- is.na(tr)
# tmp2 <- is.na(tmp == TRUE)
# 
# new_DF <- snp.clean[,rowSums(is.na(snp.clean)) > 0]

# snp.clean[22,]
