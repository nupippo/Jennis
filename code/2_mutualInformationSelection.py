# -*- coding: utf-8 -*-
"""
Created on Fri Apr 27 08:23:26 2018

@author: nupippo
"""

from sklearn.feature_selection import mutual_info_classif
from sklearn.feature_selection import SelectKBest


import feather
import pandas as pd
import numpy as np
import datetime


print(datetime.datetime.now())

path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold4_blind5_trX.feather'
train_x = feather.read_dataframe(path)


path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold4_blind5_trY.feather'
train_y = feather.read_dataframe(path)

np.random.seed(42)
sel = mutual_info_classif(train_x,train_y)
score = pd.DataFrame(sel)


print(datetime.datetime.now())

score.to_csv('D:\\workspace_R\\thalas\\20180427\\result\\mutual\\mutual_val4_test5.csv',sep=',',index=False)

#
#train_x.isnull().values.any()
#tmp = train_x[train_x == np.nan]