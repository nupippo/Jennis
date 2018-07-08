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

tr <- rbind(snp.fold2,snp.fold4,snp.fold5)
val <- snp.fold3

te <- snp.fold1


### blind

tr.x <- tr[, !(colnames(tr) %in% c("case"))]
tr.y <- data.frame(tr$case)

val.x <- val[, !(colnames(val) %in% c("case"))]
val.y <- data.frame(val$case)

te.x <- te[, !(colnames(te) %in% c("case"))]
te.y <- data.frame(te$case)

# tr.x <- sapply(tr.x, as.numeric)
# te.x <- sapply(te.x, as.numeric)

importance <- read.csv(file = 'D:/workspace_R/thalas/20180427/result/chi/chi_val_fold3_blind1_k.csv',header = F)
colnames(importance) <- 'pvalue'
importance$nm <- colnames(tr.x)


importance <- importance[order(importance$pvalue),] 
importance2 <- importance[importance$pvalue <= 0.05,]



param.c <- c(0.0001,0.001,0.01,0.1,1.0,10,100,1000,10000)

accu <- data.frame(V1 = numeric())
accu <- rbind(accu,0)



i.tmp <- data.frame(V1 = numeric())
i.tmp <- rbind(i.tmp,0)



# for (i in 2:nrow(importance2)){
for (i in 2:1000){
  
  xx <- 1:i
  
  tr.fe <- tr.x[,importance2$nm[xx]]
  te.fe <- val.x[,importance2$nm[xx]]
  
     
    model <- naive_bayes(x = tr.fe,y = tr.y$tr.case, usekernel = TRUE)
    result <- predict(model,te.fe)
    # result <- as.numeric(levels(result))[result]
    acc <- confusionMatrix(reference = val.y$val.case,result)
    
    
    accu <- rbind(accu,acc$overall[1])
    i.tmp <- rbind(i.tmp,i)
    print('###')
    print(i)
    # print(param.c[k.for])
    print(acc$overall[1])
    

  
}
# 
tmp.write <- cbind(accu,i.tmp)
colnames(tmp.write) <- c('accu','fe')
write.csv(x = tmp.write, file = 'D:/workspace_R/thalas/20180427/result/chi/nb/result_chi_nb_val3_test1.csv',row.names = F)
# sum(val.y$val.case)/length(val.y$val.case)
# tmp.write2 <- tmp.write[order(-tmp.write$accu),]

#######################################2

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

tr <- rbind(snp.fold1,snp.fold3,snp.fold4)
val <- snp.fold2

te <- snp.fold5


### blind

tr.x <- tr[, !(colnames(tr) %in% c("case"))]
tr.y <- data.frame(tr$case)

val.x <- val[, !(colnames(val) %in% c("case"))]
val.y <- data.frame(val$case)

te.x <- te[, !(colnames(te) %in% c("case"))]
te.y <- data.frame(te$case)

# tr.x <- sapply(tr.x, as.numeric)
# te.x <- sapply(te.x, as.numeric)

importance <- read.csv(file = 'D:/workspace_R/thalas/20180427/result/chi/chi_val_fold2_blind5_k.csv',header = F)
colnames(importance) <- 'pvalue'
importance$nm <- colnames(tr.x)


importance <- importance[order(importance$pvalue),] 
importance2 <- importance[importance$pvalue <= 0.05,]



param.c <- c(0.0001,0.001,0.01,0.1,1.0,10,100,1000,10000)

accu <- data.frame(V1 = numeric())
accu <- rbind(accu,0)



i.tmp <- data.frame(V1 = numeric())
i.tmp <- rbind(i.tmp,0)



# for (i in 2:nrow(importance2)){
for (i in 2:1000){
  
  xx <- 1:i
  
  tr.fe <- tr.x[,importance2$nm[xx]]
  te.fe <- val.x[,importance2$nm[xx]]
  
  
  model <- naive_bayes(x = tr.fe,y = tr.y$tr.case, usekernel = TRUE)
  result <- predict(model,te.fe)
  # result <- as.numeric(levels(result))[result]
  acc <- confusionMatrix(reference = val.y$val.case,result)
  
  
  accu <- rbind(accu,acc$overall[1])
  i.tmp <- rbind(i.tmp,i)
  print('###')
  print(i)
  # print(param.c[k.for])
  print(acc$overall[1])
  
  
  
}
# 
tmp.write <- cbind(accu,i.tmp)
colnames(tmp.write) <- c('accu','fe')
write.csv(x = tmp.write, file = 'D:/workspace_R/thalas/20180427/result/chi/nb/result_chi_nb_val2_test5.csv',row.names = F)
# sum(val.y$val.case)/length(val.y$val.case)
# tmp.write2 <- tmp.write[order(-tmp.write$accu),]

#######################################3
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

tr <- rbind(snp.fold1,snp.fold2,snp.fold4)
val <- snp.fold3

te <- snp.fold5


### blind

tr.x <- tr[, !(colnames(tr) %in% c("case"))]
tr.y <- data.frame(tr$case)

val.x <- val[, !(colnames(val) %in% c("case"))]
val.y <- data.frame(val$case)

te.x <- te[, !(colnames(te) %in% c("case"))]
te.y <- data.frame(te$case)

# tr.x <- sapply(tr.x, as.numeric)
# te.x <- sapply(te.x, as.numeric)

importance <- read.csv(file = 'D:/workspace_R/thalas/20180427/result/chi/chi_val_fold3_blind5_k.csv',header = F)
colnames(importance) <- 'pvalue'
importance$nm <- colnames(tr.x)


importance <- importance[order(importance$pvalue),] 
importance2 <- importance[importance$pvalue <= 0.05,]



param.c <- c(0.0001,0.001,0.01,0.1,1.0,10,100,1000,10000)

accu <- data.frame(V1 = numeric())
accu <- rbind(accu,0)



i.tmp <- data.frame(V1 = numeric())
i.tmp <- rbind(i.tmp,0)



# for (i in 2:nrow(importance2)){
for (i in 2:1000){
  
  xx <- 1:i
  
  tr.fe <- tr.x[,importance2$nm[xx]]
  te.fe <- val.x[,importance2$nm[xx]]
  
  
  model <- naive_bayes(x = tr.fe,y = tr.y$tr.case, usekernel = TRUE)
  result <- predict(model,te.fe)
  # result <- as.numeric(levels(result))[result]
  acc <- confusionMatrix(reference = val.y$val.case,result)
  
  
  accu <- rbind(accu,acc$overall[1])
  i.tmp <- rbind(i.tmp,i)
  print('###')
  print(i)
  # print(param.c[k.for])
  print(acc$overall[1])
  
  
  
}
# 
tmp.write <- cbind(accu,i.tmp)
colnames(tmp.write) <- c('accu','fe')
write.csv(x = tmp.write, file = 'D:/workspace_R/thalas/20180427/result/chi/nb/result_chi_nb_val3_test5.csv',row.names = F)
# sum(val.y$val.case)/length(val.y$val.case)
# tmp.write2 <- tmp.write[order(-tmp.write$accu),]

#######################################2
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

tr <- rbind(snp.fold1,snp.fold2,snp.fold3)
val <- snp.fold4

te <- snp.fold5


### blind

tr.x <- tr[, !(colnames(tr) %in% c("case"))]
tr.y <- data.frame(tr$case)

val.x <- val[, !(colnames(val) %in% c("case"))]
val.y <- data.frame(val$case)

te.x <- te[, !(colnames(te) %in% c("case"))]
te.y <- data.frame(te$case)

# tr.x <- sapply(tr.x, as.numeric)
# te.x <- sapply(te.x, as.numeric)

importance <- read.csv(file = 'D:/workspace_R/thalas/20180427/result/chi/chi_val_fold4_blind5_k.csv',header = F)
colnames(importance) <- 'pvalue'
importance$nm <- colnames(tr.x)


importance <- importance[order(importance$pvalue),] 
importance2 <- importance[importance$pvalue <= 0.05,]



param.c <- c(0.0001,0.001,0.01,0.1,1.0,10,100,1000,10000)

accu <- data.frame(V1 = numeric())
accu <- rbind(accu,0)



i.tmp <- data.frame(V1 = numeric())
i.tmp <- rbind(i.tmp,0)



# for (i in 2:nrow(importance2)){
for (i in 2:1000){
  
  xx <- 1:i
  
  tr.fe <- tr.x[,importance2$nm[xx]]
  te.fe <- val.x[,importance2$nm[xx]]
  
  
  model <- naive_bayes(x = tr.fe,y = tr.y$tr.case, usekernel = TRUE)
  result <- predict(model,te.fe)
  # result <- as.numeric(levels(result))[result]
  acc <- confusionMatrix(reference = val.y$val.case,result)
  
  
  accu <- rbind(accu,acc$overall[1])
  i.tmp <- rbind(i.tmp,i)
  print('###')
  print(i)
  # print(param.c[k.for])
  print(acc$overall[1])
  
  
  
}
# 
tmp.write <- cbind(accu,i.tmp)
colnames(tmp.write) <- c('accu','fe')
write.csv(x = tmp.write, file = 'D:/workspace_R/thalas/20180427/result/chi/nb/result_chi_nb_val4_test5.csv',row.names = F)
sum(val.y$val.case)/length(val.y$val.case)
tmp.write2 <- tmp.write[order(-tmp.write$accu),]
