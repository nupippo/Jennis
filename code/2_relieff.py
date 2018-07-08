# -*- coding: utf-8 -*-
"""
Created on Mon May  7 16:32:29 2018

@author: nupippo
"""

from ReliefF import ReliefF
import feather
import pandas as pd
import numpy as np

from sklearn.feature_selection import mutual_info_classif
from sklearn.feature_selection import SelectKBest


import feather
import pandas as pd
import numpy as np
import datetime


#print(datetime.datetime.now())

### val
#path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold4_blind5_trX.feather'
#train_x = feather.read_dataframe(path)
#
#
#path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold4_blind5_trY.feather'
#train_y = feather.read_dataframe(path)
#
#path_write = 'D:\\workspace_R\\thalas\\20180427\\result\\relieff\\relieff_val_fold4_blind5_k'
### val

### test
path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_trainX_test5.feather'
train_x = feather.read_dataframe(path)


path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_trainY_test5.feather'
train_y = feather.read_dataframe(path)

path_write = 'D:\\workspace_R\\thalas\\20180427\\result\\relieff\\relieff_test_fold5_k'
###test

train_x = train_x.values
train_y = np.array(train_y['tr.case'])

collection = [5, 10, 15, 20, 25, 50, 100]

for x in collection:

    path_write2 = path_write+str(x)+'.csv' 
    print(x)
    
    np.random.seed(42)
    fs = ReliefF(n_neighbors=x)
    fs.fit(X=train_x,y=train_y)

    score = np.asarray(fs.feature_scores)
    np.savetxt(path_write2, score, delimiter=",")