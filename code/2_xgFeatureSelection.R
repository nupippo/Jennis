rm(list = ls())
setwd("D:/workspace_R/thalas/")
library(xgboost)
library(caret)
library(mgcv)
library(feather)
library(e1071)
# load("D:/workspace_R/thalas/20180304/dataset/snp_clean.RData")
load("D:/workspace_R/thalas/20180427/dataset/snp_missing_1per_numeric.RData")

# snp.clean <- sapply(snp.clean, as.numeric)
# snp.clean <- data.frame(snp.clean)
set.seed(546789)
indexFolds <- createFolds(snp.clean$case,5)
snp.fold1 <- snp.clean[indexFolds$Fold1,]
snp.fold2 <- snp.clean[indexFolds$Fold2,]
snp.fold3 <- snp.clean[indexFolds$Fold3,]
snp.fold4 <- snp.clean[indexFolds$Fold4,]
snp.fold5 <- snp.clean[indexFolds$Fold5,]

remove(snp)
remove(snp.clean)

tr <- rbind(snp.fold2,snp.fold3,snp.fold4)
val <- snp.fold1

te <- snp.fold5

tr.x <- tr[, !(colnames(tr) %in% c("case"))]
tr.y <- data.frame(tr$case)

# tr.x <- sapply(tr.x, as.numeric)

tr.x <- data.matrix(tr.x)


val.x <- val[, !(colnames(val) %in% c("case"))]
val.y <- data.frame(val$case)

# val.x <- sapply(val.x, as.numeric)

val.x <- data.matrix(val.x)

te.x <- te[, !(colnames(te) %in% c("case"))]
te.y <- data.frame(te$case)

# 
remove(snp.fold1)
remove(snp.fold2)
remove(snp.fold3)
remove(snp.fold4)
remove(snp.fold5)
remove(tr)
remove(te)
gc()
# param <- list("objective" = "binary:logistic",
#               # "scale_pos_weight" = 0.65,
#               "bst:eta" = 0.01,
#               "colsample_bytree" = 0.5,
#               "bst:max_depth" = 5,
#               "eval_metric" = "auc",
#               "silent" = 1,
#               "nthread" = 6)


colsam <- c(0.025,0.05, 0.075, 0.1, 0.25, 0.5, 0.75)

colsam2 <- c('0_025','0_05', '0_075', '0_1', '0_25', '0_5', '0_75')
tmp.res <- 0
tmp.colsam <- 0

for (i in 1:length(colsam)) {
  


param <- list("objective" = "binary:logistic",
              # "scale_pos_weight" = 0.65,
              "bst:eta" = 0.001,
              "colsample_bytree" = colsam[i],
              "bst:max_depth" = 5,
              "eval_metric" = "auc",
              "silent" = 1,
              "nthread" = 6)


# res <- predict(model.fe1,data.matrix(te.fe.1))
set.seed(123)
model <- xgboost(data = tr.x,
                 label = tr.y$tr.case,
                 params = param,
                 nround = 2000,
                 # silent = 1
)

gc()

# model <- xgboost(data = data.matrix(tr.x),
#                  label = tr.y$tr.case,
#                  params = param,
#                  nround = 10
# )


res <- predict(model,val.x)
res[res >= 0.5] <- 1
res[res < 0.5] <- 0

print(confusionMatrix(reference = val.y$val.case,res))

confM <- confusionMatrix(reference = val.y$val.case,res)
confM <- confM$overall[1]
tmp.res <- c(tmp.res,confM)
tmp.colsam <- c(tmp.colsam,colsam[i])

print(i)
}

sum(val.y)/length(val.y$val.case)

tmp.write <- cbind(colsam,tmp.res[-1])

write.csv(x = tmp.write,file = "D:\\workspace_R\\thalas\\20180427\\result2\\result_tuning_colsam_fold1_blind5.csv")
# importance <- xgb.importance(feature_names = colnames(tr.x), model = model)


########### 2222222222222222222222
rm(list = ls())
setwd("D:/workspace_R/thalas/")
library(xgboost)
library(caret)
library(mgcv)
library(feather)
library(e1071)
# load("D:/workspace_R/thalas/20180304/dataset/snp_clean.RData")
load("D:/workspace_R/thalas/20180427/dataset/snp_missing_1per_numeric.RData")

# snp.clean <- sapply(snp.clean, as.numeric)
# snp.clean <- data.frame(snp.clean)
set.seed(546789)
indexFolds <- createFolds(snp.clean$case,5)
snp.fold1 <- snp.clean[indexFolds$Fold1,]
snp.fold2 <- snp.clean[indexFolds$Fold2,]
snp.fold3 <- snp.clean[indexFolds$Fold3,]
snp.fold4 <- snp.clean[indexFolds$Fold4,]
snp.fold5 <- snp.clean[indexFolds$Fold5,]

remove(snp)
remove(snp.clean)

tr <- rbind(snp.fold1,snp.fold3,snp.fold4)
val <- snp.fold2

te <- snp.fold5

tr.x <- tr[, !(colnames(tr) %in% c("case"))]
tr.y <- data.frame(tr$case)

# tr.x <- sapply(tr.x, as.numeric)

tr.x <- data.matrix(tr.x)


val.x <- val[, !(colnames(val) %in% c("case"))]
val.y <- data.frame(val$case)

# val.x <- sapply(val.x, as.numeric)

val.x <- data.matrix(val.x)

te.x <- te[, !(colnames(te) %in% c("case"))]
te.y <- data.frame(te$case)

# 
remove(snp.fold1)
remove(snp.fold2)
remove(snp.fold3)
remove(snp.fold4)
remove(snp.fold5)
remove(tr)
remove(te)
gc()
# param <- list("objective" = "binary:logistic",
#               # "scale_pos_weight" = 0.65,
#               "bst:eta" = 0.01,
#               "colsample_bytree" = 0.5,
#               "bst:max_depth" = 5,
#               "eval_metric" = "auc",
#               "silent" = 1,
#               "nthread" = 6)


colsam <- c(0.025,0.05, 0.075, 0.1, 0.25, 0.5, 0.75)

colsam2 <- c('0_025','0_05', '0_075', '0_1', '0_25', '0_5', '0_75')

tmp.res <- 0
tmp.colsam <- 0

for (i in 1:length(colsam)) {
  
  
  
  param <- list("objective" = "binary:logistic",
                # "scale_pos_weight" = 0.65,
                "bst:eta" = 0.001,
                "colsample_bytree" = colsam[i],
                "bst:max_depth" = 5,
                "eval_metric" = "auc",
                "silent" = 1,
                "nthread" = 6)
  
  
  # res <- predict(model.fe1,data.matrix(te.fe.1))
  set.seed(123)
  model <- xgboost(data = tr.x,
                   label = tr.y$tr.case,
                   params = param,
                   nround = 2000,
                   # silent = 1
  )
  
  gc()
  
  # model <- xgboost(data = data.matrix(tr.x),
  #                  label = tr.y$tr.case,
  #                  params = param,
  #                  nround = 10
  # )
  
  
  res <- predict(model,val.x)
  res[res >= 0.5] <- 1
  res[res < 0.5] <- 0
  
  print(confusionMatrix(reference = val.y$val.case,res))
  
  confM <- confusionMatrix(reference = val.y$val.case,res)
  confM <- confM$overall[1]
  tmp.res <- c(tmp.res,confM)
  tmp.colsam <- c(tmp.colsam,colsam[i])
  
  print(i)
}

sum(val.y)/length(val.y$val.case)

tmp.write <- cbind(colsam,tmp.res[-1])

write.csv(x = tmp.write,file = "D:\\workspace_R\\thalas\\20180427\\result2\\result_tuning_colsam_fold2_blind5.csv")



########### 3333333333333333
rm(list = ls())
setwd("D:/workspace_R/thalas/")
library(xgboost)
library(caret)
library(mgcv)
library(feather)
library(e1071)
# load("D:/workspace_R/thalas/20180304/dataset/snp_clean.RData")
load("D:/workspace_R/thalas/20180427/dataset/snp_missing_1per_numeric.RData")

# snp.clean <- sapply(snp.clean, as.numeric)
# snp.clean <- data.frame(snp.clean)
set.seed(546789)
indexFolds <- createFolds(snp.clean$case,5)
snp.fold1 <- snp.clean[indexFolds$Fold1,]
snp.fold2 <- snp.clean[indexFolds$Fold2,]
snp.fold3 <- snp.clean[indexFolds$Fold3,]
snp.fold4 <- snp.clean[indexFolds$Fold4,]
snp.fold5 <- snp.clean[indexFolds$Fold5,]

remove(snp)
remove(snp.clean)

tr <- rbind(snp.fold1,snp.fold2,snp.fold4)
val <- snp.fold3

te <- snp.fold5

tr.x <- tr[, !(colnames(tr) %in% c("case"))]
tr.y <- data.frame(tr$case)

# tr.x <- sapply(tr.x, as.numeric)

tr.x <- data.matrix(tr.x)


val.x <- val[, !(colnames(val) %in% c("case"))]
val.y <- data.frame(val$case)

# val.x <- sapply(val.x, as.numeric)

val.x <- data.matrix(val.x)

te.x <- te[, !(colnames(te) %in% c("case"))]
te.y <- data.frame(te$case)

# 
remove(snp.fold1)
remove(snp.fold2)
remove(snp.fold3)
remove(snp.fold4)
remove(snp.fold5)
remove(tr)
remove(te)
gc()
# param <- list("objective" = "binary:logistic",
#               # "scale_pos_weight" = 0.65,
#               "bst:eta" = 0.01,
#               "colsample_bytree" = 0.5,
#               "bst:max_depth" = 5,
#               "eval_metric" = "auc",
#               "silent" = 1,
#               "nthread" = 6)


colsam <- c(0.025,0.05, 0.075, 0.1, 0.25, 0.5, 0.75)

colsam2 <- c('0_025','0_05', '0_075', '0_1', '0_25', '0_5', '0_75')

tmp.res <- 0
tmp.colsam <- 0

for (i in 1:length(colsam)) {
  
  
  
  param <- list("objective" = "binary:logistic",
                # "scale_pos_weight" = 0.65,
                "bst:eta" = 0.001,
                "colsample_bytree" = colsam[i],
                "bst:max_depth" = 5,
                "eval_metric" = "auc",
                "silent" = 1,
                "nthread" = 6)
  
  
  # res <- predict(model.fe1,data.matrix(te.fe.1))
  set.seed(123)
  model <- xgboost(data = tr.x,
                   label = tr.y$tr.case,
                   params = param,
                   nround = 2000,
                   # silent = 1
  )
  
  gc()
  
  # model <- xgboost(data = data.matrix(tr.x),
  #                  label = tr.y$tr.case,
  #                  params = param,
  #                  nround = 10
  # )
  
  
  res <- predict(model,val.x)
  res[res >= 0.5] <- 1
  res[res < 0.5] <- 0
  
  print(confusionMatrix(reference = val.y$val.case,res))
  
  confM <- confusionMatrix(reference = val.y$val.case,res)
  confM <- confM$overall[1]
  tmp.res <- c(tmp.res,confM)
  tmp.colsam <- c(tmp.colsam,colsam[i])
  
  print(i)
}

sum(val.y)/length(val.y$val.case)

tmp.write <- cbind(colsam,tmp.res[-1])

write.csv(x = tmp.write,file = "D:\\workspace_R\\thalas\\20180427\\result2\\result_tuning_colsam_fold3_blind5.csv")





########### 4444444444444444444
rm(list = ls())
setwd("D:/workspace_R/thalas/")
library(xgboost)
library(caret)
library(mgcv)
library(feather)
library(e1071)
# load("D:/workspace_R/thalas/20180304/dataset/snp_clean.RData")
load("D:/workspace_R/thalas/20180427/dataset/snp_missing_1per_numeric.RData")

# snp.clean <- sapply(snp.clean, as.numeric)
# snp.clean <- data.frame(snp.clean)
set.seed(546789)
indexFolds <- createFolds(snp.clean$case,5)
snp.fold1 <- snp.clean[indexFolds$Fold1,]
snp.fold2 <- snp.clean[indexFolds$Fold2,]
snp.fold3 <- snp.clean[indexFolds$Fold3,]
snp.fold4 <- snp.clean[indexFolds$Fold4,]
snp.fold5 <- snp.clean[indexFolds$Fold5,]

remove(snp)
remove(snp.clean)

tr <- rbind(snp.fold1,snp.fold2,snp.fold3)
val <- snp.fold4

te <- snp.fold5

tr.x <- tr[, !(colnames(tr) %in% c("case"))]
tr.y <- data.frame(tr$case)

# tr.x <- sapply(tr.x, as.numeric)

tr.x <- data.matrix(tr.x)


val.x <- val[, !(colnames(val) %in% c("case"))]
val.y <- data.frame(val$case)

# val.x <- sapply(val.x, as.numeric)

val.x <- data.matrix(val.x)

te.x <- te[, !(colnames(te) %in% c("case"))]
te.y <- data.frame(te$case)

# 
remove(snp.fold1)
remove(snp.fold2)
remove(snp.fold3)
remove(snp.fold4)
remove(snp.fold5)
remove(tr)
remove(te)
gc()
# param <- list("objective" = "binary:logistic",
#               # "scale_pos_weight" = 0.65,
#               "bst:eta" = 0.01,
#               "colsample_bytree" = 0.5,
#               "bst:max_depth" = 5,
#               "eval_metric" = "auc",
#               "silent" = 1,
#               "nthread" = 6)


colsam <- c(0.025,0.05, 0.075, 0.1, 0.25, 0.5, 0.75)

colsam2 <- c('0_025','0_05', '0_075', '0_1', '0_25', '0_5', '0_75')

tmp.res <- 0
tmp.colsam <- 0

for (i in 1:length(colsam)) {
  
  
  
  param <- list("objective" = "binary:logistic",
                # "scale_pos_weight" = 0.65,
                "bst:eta" = 0.001,
                "colsample_bytree" = colsam[i],
                "bst:max_depth" = 5,
                "eval_metric" = "auc",
                "silent" = 1,
                "nthread" = 6)
  
  
  # res <- predict(model.fe1,data.matrix(te.fe.1))
  set.seed(123)
  model <- xgboost(data = tr.x,
                   label = tr.y$tr.case,
                   params = param,
                   nround = 2000,
                   # silent = 1
  )
  
  gc()
  
  # model <- xgboost(data = data.matrix(tr.x),
  #                  label = tr.y$tr.case,
  #                  params = param,
  #                  nround = 10
  # )
  
  
  res <- predict(model,val.x)
  res[res >= 0.5] <- 1
  res[res < 0.5] <- 0
  
  print(confusionMatrix(reference = val.y$val.case,res))
  
  confM <- confusionMatrix(reference = val.y$val.case,res)
  confM <- confM$overall[1]
  tmp.res <- c(tmp.res,confM)
  tmp.colsam <- c(tmp.colsam,colsam[i])
  
  print(i)
}

sum(val.y)/length(val.y$val.case)

tmp.write <- cbind(colsam,tmp.res[-1])

write.csv(x = tmp.write,file = "D:\\workspace_R\\thalas\\20180427\\result2\\result_tuning_colsam_fold4_blind5.csv")
