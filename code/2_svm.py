# -*- coding: utf-8 -*-
"""
Created on Wed May  9 15:10:10 2018

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
from sklearn.svm import SVC

#print(datetime.datetime.now())

path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold1_blind5_trX.feather'
train_x = feather.read_dataframe(path)


path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold1_blind5_trY.feather'
train_y = feather.read_dataframe(path)

path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold1_blind5_teX.feather'
test_x = feather.read_dataframe(path)

path_write = 'D:\\workspace_R\\thalas\\20180427\\result\\svm\\svm_val_fold1_blind5_c'

#train_x = train_x.values
#train_y = np.array(train_y['tr.case'])

collection = [0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000, 10000]

#clf = SVC(cache_size=1600, kernel='linear', C=0.01,max_iter=10000 ,probability=True, verbose=True)
#clf.fit(train_x, train_y)

#result = clf.predict(test_x)

for x in collection:
    
    path_write2 = path_write+str(x)+'.csv' 
    print(x)
    
    np.random.seed(42)
    clf = SVC(cache_size=1600, kernel='linear', C=x
    ,max_iter=10000 ,probability=True, verbose=True)
    clf.fit(train_x, train_y)
    res = pd.DataFrame(clf.predict(test_x))
    res.to_csv(path_write2,sep='|',index=False)
    
#    np.savetxt(path_write2, score, delimiter=",")
    
    
######################################################## 2

path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold2_blind5_trX.feather'
train_x = feather.read_dataframe(path)


path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold2_blind5_trY.feather'
train_y = feather.read_dataframe(path)

path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold2_blind5_teX.feather'
test_x = feather.read_dataframe(path)

path_write = 'D:\\workspace_R\\thalas\\20180427\\result\\svm\\svm_val_fold2_blind5_c'

#train_x = train_x.values
#train_y = np.array(train_y['tr.case'])

collection = [0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000, 10000]

#clf = SVC(cache_size=1600, kernel='linear', C=0.01,max_iter=10000 ,probability=True, verbose=True)
#clf.fit(train_x, train_y)

#result = clf.predict(test_x)

for x in collection:
    
    path_write2 = path_write+str(x)+'.csv' 
    print(x)
    
    np.random.seed(42)
    clf = SVC(cache_size=1600, kernel='linear', C=x
    ,max_iter=10000 ,probability=True, verbose=True)
    clf.fit(train_x, train_y)
    res = pd.DataFrame(clf.predict(test_x))
    res.to_csv(path_write2,sep='|',index=False)

############################################################ 3

path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold3_blind5_trX.feather'
train_x = feather.read_dataframe(path)


path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold3_blind5_trY.feather'
train_y = feather.read_dataframe(path)

path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold3_blind5_teX.feather'
test_x = feather.read_dataframe(path)

path_write = 'D:\\workspace_R\\thalas\\20180427\\result\\svm\\svm_val_fold3_blind5_c'

#train_x = train_x.values
#train_y = np.array(train_y['tr.case'])

collection = [0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000, 10000]

#clf = SVC(cache_size=1600, kernel='linear', C=0.01,max_iter=10000 ,probability=True, verbose=True)
#clf.fit(train_x, train_y)

#result = clf.predict(test_x)

for x in collection:
    
    path_write2 = path_write+str(x)+'.csv' 
    print(x)
    
    np.random.seed(42)
    clf = SVC(cache_size=1600, kernel='linear', C=x
    ,max_iter=10000 ,probability=True, verbose=True)
    clf.fit(train_x, train_y)
    res = pd.DataFrame(clf.predict(test_x))
    res.to_csv(path_write2,sep='|',index=False)
############################################################ 4    
    
    
path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold4_blind5_trX.feather'
train_x = feather.read_dataframe(path)


path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold4_blind5_trY.feather'
train_y = feather.read_dataframe(path)

path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold4_blind5_teX.feather'
test_x = feather.read_dataframe(path)

path_write = 'D:\\workspace_R\\thalas\\20180427\\result\\svm\\svm_val_fold4_blind5_c'

#train_x = train_x.values
#train_y = np.array(train_y['tr.case'])

collection = [0.0001, 0.001, 0.01, 0.1, 1, 10, 100, 1000, 10000]

#clf = SVC(cache_size=1600, kernel='linear', C=0.01,max_iter=10000 ,probability=True, verbose=True)
#clf.fit(train_x, train_y)

#result = clf.predict(test_x)

for x in collection:
    
    path_write2 = path_write+str(x)+'.csv' 
    print(x)
    
    np.random.seed(42)
    clf = SVC(cache_size=1600, kernel='linear', C=x
    ,max_iter=10000 ,probability=True, verbose=True)
    clf.fit(train_x, train_y)
    res = pd.DataFrame(clf.predict(test_x))
    res.to_csv(path_write2,sep='|',index=False)