# -*- coding: utf-8 -*-
"""
Created on Wed May  9 12:00:11 2018

@author: nupippo
"""

# -*- coding: utf-8 -*-
"""
Created on Mon May  7 16:32:29 2018

@author: nupippo
"""

from ReliefF import ReliefF
import feather
import pandas as pd
import numpy as np
from sklearn.feature_selection import chi2
from scipy.stats import chisquare


from sklearn.feature_selection import mutual_info_classif
from sklearn.feature_selection import SelectKBest


import feather
import pandas as pd
import numpy as np
import datetime


#print(datetime.datetime.now())

#### val
#path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold3_blind1_trX.feather'
#train_x = feather.read_dataframe(path)
#
#
#path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold3_blind1_trY.feather'
#train_y = feather.read_dataframe(path)
#
#path_write = 'D:\\workspace_R\\thalas\\20180427\\result\\chi\\chi_val_fold3_blind1_k.csv'
### val


#### test
path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_trainX_test5.feather'
train_x = feather.read_dataframe(path)


path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_trainY_test5.feather'
train_y = feather.read_dataframe(path)

path_write = 'D:\\workspace_R\\thalas\\20180427\\result\\chi\\chi_test_fold5.csv'
### test

chi2, pval = chi2(X=train_x,y=train_y)
x2 = np.asarray(pval)
#np.savetxt("fold1_score.csv", x2, delimiter=",")
np.savetxt(path_write, x2, delimiter=",")