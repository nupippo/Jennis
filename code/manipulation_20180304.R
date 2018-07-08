rm(list = ls())
setwd("D:/workspace_R/thalas/")
library(xgboost)
library(caret)
library(mgcv)
library(feather)
library(e1071)
load("D:/workspace_R/thalas/dataset/py/as_numeric.RData")
nm <- read.csv(file = 'D:/workspace_R/thalas/20170821/file/snpName_Full.csv')
nm <- as.character(nm[,-1])

colnames(snp) <- nm
remove(snp.fold1)
remove(snp.fold2)
remove(snp.fold3)
remove(snp.fold4)
remove(snp.fold5)

dta2 <- snp
dta3 <- dta2 

missing.threshold <- 6
tmp.colname <- colnames(dta2)
tmp.name.miss <- 'missing'


for(i in 1:(ncol(dta2)-1)){
# for(i in 1:50000){
  
  # tmp <- subset(dta2, select= tmp.colname[i])
  tmp <- dta2[,i]
  tmp.missing <- tmp[tmp==3]
  # print(tmp.missing)
  if(length(tmp.missing) >= missing.threshold){
    # dta3 <- dta3[ , -which(names(dta3) %in% tmp.colname[i])]
    # print(i)
    # print('remove')
    tmp.name.miss <- c(tmp.name.miss,tmp.colname[i])
    
  }
  print(i)
  # df[ , -which(names(df) %in% c("z","u"))]
}

# dta3 <- dta3[ , -which(names(dta3) %in% tmp.name.miss)]


# tmp <- ftable(dta2[,3])
# tmp <- data.frame(tmp, stringsAsFactors = F)

tmp.colname <- colnames(dta3)

tmp.name.major <- 'major'
for(i in 1:(ncol(dta3)-1)){
  tmp <- dta3[,i]
  tmp <- ftable(tmp)
  tmp <- data.frame(tmp, stringsAsFactors = F)
  if(max(tmp$Freq) >= 556){
    #90%
    tmp.name.major <- c(tmp.name.major,tmp.colname[i])
  }
  print(i)
}

dta4 <- dta3[ , -which(names(dta3) %in% tmp.name.major)]


snp.clean <- dta4
remove(dta2)
remove(dta3)
remove(dta4)
remove(tmp)


getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

for(i in 1:(ncol(snp.clean)-1)){
 tmp <- snp.clean[,i]
 tmp[tmp==3] <- getmode(tmp)
 snp.clean[,i] <- tmp
 print(i)
}

tmp <- snp.clean[snp.clean==3]



set.seed(5468)
indexFolds <- createFolds(snp$case,8)

snp.fold1 <- snp[indexFolds$Fold1,]
snp.fold2 <- snp[indexFolds$Fold2,]
snp.fold3 <- snp[indexFolds$Fold3,]
snp.fold4 <- snp[indexFolds$Fold4,]
snp.fold5 <- snp[indexFolds$Fold5,]
snp.fold6 <- snp[indexFolds$Fold6,]
snp.fold7 <- snp[indexFolds$Fold7,]
snp.fold8 <- snp[indexFolds$Fold8,]

tr <- rbind(snp.fold1,snp.fold2,snp.fold3,snp.fold4,snp.fold5,snp.fold6)
te <- snp.fold7

### blind
blind <- snp.fold8