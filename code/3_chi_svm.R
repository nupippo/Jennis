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

tr <- rbind(snp.fold2,snp.fold4,snp.fold5)
val <- snp.fold1

te <- snp.fold3


### blind

tr.x <- tr[, !(colnames(tr) %in% c("case"))]
tr.y <- data.frame(tr$case)

val.x <- val[, !(colnames(val) %in% c("case"))]
val.y <- data.frame(val$case)

te.x <- te[, !(colnames(te) %in% c("case"))]
te.y <- data.frame(te$case)

# tr.x <- sapply(tr.x, as.numeric)
# te.x <- sapply(te.x, as.numeric)

importance <- read.csv(file = 'D:/workspace_R/thalas/20180427/result/chi/chi_val_fold1_blind3_k.csv',header = F)
colnames(importance) <- 'pvalue'
importance$nm <- colnames(tr.x)


importance <- importance[order(importance$pvalue),] 
importance2 <- importance[importance$pvalue <= 0.05,]



param.c <- c(0.0001,0.001,0.01,0.1,1.0,10,100,1000,10000)

accu <- data.frame(V1 = numeric())
accu <- rbind(accu,0)

param <- data.frame(V1 = numeric())
param <- rbind(param,0)

i.tmp <- data.frame(V1 = numeric())
i.tmp <- rbind(i.tmp,0)



# for (i in 2:nrow(importance2)){
for (i in 2:500){
  
  xx <- 1:i
  
  tr.fe <- tr.x[,importance2$nm[xx]]
  te.fe <- val.x[,importance2$nm[xx]]
  
  
  for (k.for in 1:length(param.c)){
    
    model <- svm(tr.fe,tr.y,type = 'C-classification',cost = param.c[k.for])
    result <- predict(model,te.fe)
    # result <- as.numeric(levels(result))[result]
    acc <- confusionMatrix(reference = val.y$val.case,result)
    
    
    accu <- rbind(accu,acc$overall[1])
    param <- rbind(param,param.c[k.for])
    i.tmp <- rbind(i.tmp,i)
    print('###')
    print(i)
    print(param.c[k.for])
    print(acc$overall[1])
    
  }
  
}
# 
tmp.write <- cbind(param,accu,i.tmp)
colnames(tmp.write) <- c('param','accu','fe')
write.csv(x = tmp.write, file = 'D:/workspace_R/thalas/20180427/result/chi/svm/result_chi_svm_val1_test3.csv',row.names = F)
# sum(te.y$te.case)/length(te.y$te.case)
# tmp.write2 <- tmp.write[order(-tmp.write$accu),] 


########################################################################## 2
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

tr <- rbind(snp.fold1,snp.fold4,snp.fold5)
val <- snp.fold3

te <- snp.fold2


### blind

tr.x <- tr[, !(colnames(tr) %in% c("case"))]
tr.y <- data.frame(tr$case)

val.x <- val[, !(colnames(val) %in% c("case"))]
val.y <- data.frame(val$case)

te.x <- te[, !(colnames(te) %in% c("case"))]
te.y <- data.frame(te$case)

# tr.x <- sapply(tr.x, as.numeric)
# te.x <- sapply(te.x, as.numeric)

importance <- read.csv(file = 'D:/workspace_R/thalas/20180427/result/chi/chi_val_fold3_blind2_k.csv',header = F)
colnames(importance) <- 'pvalue'
importance$nm <- colnames(tr.x)


importance <- importance[order(importance$pvalue),] 
importance2 <- importance[importance$pvalue <= 0.05,]



param.c <- c(0.0001,0.001,0.01,0.1,1.0,10,100,1000,10000)

accu <- data.frame(V1 = numeric())
accu <- rbind(accu,0)

param <- data.frame(V1 = numeric())
param <- rbind(param,0)

i.tmp <- data.frame(V1 = numeric())
i.tmp <- rbind(i.tmp,0)



# for (i in 2:length(importance$Feature)){
for (i in 2:500){
  
  xx <- 1:i
  
  tr.fe <- tr.x[,importance2$nm[xx]]
  te.fe <- val.x[,importance2$nm[xx]]
  
  
  for (k.for in 1:length(param.c)){
    
    model <- svm(tr.fe,tr.y,type = 'C-classification',cost = param.c[k.for])
    result <- predict(model,te.fe)
    # result <- as.numeric(levels(result))[result]
    acc <- confusionMatrix(reference = val.y$val.case,result)
    
    
    accu <- rbind(accu,acc$overall[1])
    param <- rbind(param,param.c[k.for])
    i.tmp <- rbind(i.tmp,i)
    print('###')
    print(i)
    print(param.c[k.for])
    print(acc$overall[1])
    
  }
  
}
# 
tmp.write <- cbind(param,accu,i.tmp)
colnames(tmp.write) <- c('param','accu','fe')
write.csv(x = tmp.write, file = 'D:/workspace_R/thalas/20180427/result/chi/svm/result_chi_svm_val3_test2.csv',row.names = F)
# sum(te.y$te.case)/length(te.y$te.case)
# tmp.write2 <- tmp.write[order(-tmp.write$accu),] 


########################################################################## 3
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

tr <- rbind(snp.fold1,snp.fold2,snp.fold5)
val <- snp.fold4

te <- snp.fold3


### blind

tr.x <- tr[, !(colnames(tr) %in% c("case"))]
tr.y <- data.frame(tr$case)

val.x <- val[, !(colnames(val) %in% c("case"))]
val.y <- data.frame(val$case)

te.x <- te[, !(colnames(te) %in% c("case"))]
te.y <- data.frame(te$case)

# tr.x <- sapply(tr.x, as.numeric)
# te.x <- sapply(te.x, as.numeric)

importance <- read.csv(file = 'D:/workspace_R/thalas/20180427/result/chi/chi_val_fold4_blind3_k.csv',header = F)
colnames(importance) <- 'pvalue'
importance$nm <- colnames(tr.x)


importance <- importance[order(importance$pvalue),] 
importance2 <- importance[importance$pvalue <= 0.05,]



param.c <- c(0.0001,0.001,0.01,0.1,1.0,10,100,1000,10000)

accu <- data.frame(V1 = numeric())
accu <- rbind(accu,0)

param <- data.frame(V1 = numeric())
param <- rbind(param,0)

i.tmp <- data.frame(V1 = numeric())
i.tmp <- rbind(i.tmp,0)



# for (i in 2:length(importance$Feature)){
for (i in 2:500){
  
  xx <- 1:i
  
  tr.fe <- tr.x[,importance2$nm[xx]]
  te.fe <- val.x[,importance2$nm[xx]]
  
  
  for (k.for in 1:length(param.c)){
    
    model <- svm(tr.fe,tr.y,type = 'C-classification',cost = param.c[k.for])
    result <- predict(model,te.fe)
    # result <- as.numeric(levels(result))[result]
    acc <- confusionMatrix(reference = val.y$val.case,result)
    
    
    accu <- rbind(accu,acc$overall[1])
    param <- rbind(param,param.c[k.for])
    i.tmp <- rbind(i.tmp,i)
    print('###')
    print(i)
    print(param.c[k.for])
    print(acc$overall[1])
    
  }
  
}
# 
tmp.write <- cbind(param,accu,i.tmp)
colnames(tmp.write) <- c('param','accu','fe')
write.csv(x = tmp.write, file = 'D:/workspace_R/thalas/20180427/result/chi/svm/result_chi_svm_val4_test3.csv',row.names = F)
# sum(te.y$te.case)/length(te.y$te.case)
# tmp.write2 <- tmp.write[order(-tmp.write$accu),] 


########################################################################## 3
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

tr <- rbind(snp.fold1,snp.fold2,snp.fold4)
val <- snp.fold5

te <- snp.fold3


### blind

tr.x <- tr[, !(colnames(tr) %in% c("case"))]
tr.y <- data.frame(tr$case)

val.x <- val[, !(colnames(val) %in% c("case"))]
val.y <- data.frame(val$case)

te.x <- te[, !(colnames(te) %in% c("case"))]
te.y <- data.frame(te$case)

# tr.x <- sapply(tr.x, as.numeric)
# te.x <- sapply(te.x, as.numeric)

importance <- read.csv(file = 'D:/workspace_R/thalas/20180427/result/chi/chi_val_fold5_blind3_k.csv',header = F)
colnames(importance) <- 'pvalue'
importance$nm <- colnames(tr.x)


importance <- importance[order(importance$pvalue),] 
importance2 <- importance[importance$pvalue <= 0.05,]



param.c <- c(0.0001,0.001,0.01,0.1,1.0,10,100,1000,10000)

accu <- data.frame(V1 = numeric())
accu <- rbind(accu,0)

param <- data.frame(V1 = numeric())
param <- rbind(param,0)

i.tmp <- data.frame(V1 = numeric())
i.tmp <- rbind(i.tmp,0)



# for (i in 2:length(importance$Feature)){
for (i in 2:500){
  
  xx <- 1:i
  
  tr.fe <- tr.x[,importance2$nm[xx]]
  te.fe <- val.x[,importance2$nm[xx]]
  
  
  for (k.for in 1:length(param.c)){
    
    model <- svm(tr.fe,tr.y,type = 'C-classification',cost = param.c[k.for])
    result <- predict(model,te.fe)
    # result <- as.numeric(levels(result))[result]
    acc <- confusionMatrix(reference = val.y$val.case,result)
    
    
    accu <- rbind(accu,acc$overall[1])
    param <- rbind(param,param.c[k.for])
    i.tmp <- rbind(i.tmp,i)
    print('###')
    print(i)
    print(param.c[k.for])
    print(acc$overall[1])
    
  }
  
}
# 
tmp.write <- cbind(param,accu,i.tmp)
colnames(tmp.write) <- c('param','accu','fe')
write.csv(x = tmp.write, file = 'D:/workspace_R/thalas/20180427/result/chi/svm/result_chi_svm_val5_test3.csv',row.names = F)
sum(te.y$te.case)/length(te.y$te.case)
tmp.write2 <- tmp.write[order(-tmp.write$accu),]
