# -*- coding: utf-8 -*-
"""
Created on Thu May 24 12:18:36 2018

@author: nupippo
"""

import pandas as pd
import numpy as np
import feather
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score

from catboost import CatBoostClassifier


path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_catboost_chi_train_1k_val2_test1X.feather'
train_x = feather.read_dataframe(path)


path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_catboost_chi_train_1k_val2_test1Y.feather'
train_y = feather.read_dataframe(path)

path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_catboost_chi_test_1k_val2_test1X.feather'
test_x = feather.read_dataframe(path)

path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_catboost_chi_test_1k_val2_test1Y.feather'
test_y = feather.read_dataframe(path)



var_length = list(range(2,1001))

result = [999]

for x in var_length:
  
    tmp_trainX = train_x.iloc[:,0:x]
    tmp_testX = test_x.iloc[:,0:x]
    
    itera = list(range(0,x))
    
    model = CatBoostClassifier(
        eval_metric='F1',
        iterations=50,
        random_seed=42,
        logging_level='Verbose',
        thread_count= 6,
    #    use_best_model=True,
        od_type='Iter',
        
    #    depth=10,
    #    task_type='GPU',
    #    learning_rate=0.01
    #    verbose=True
        
    
    )

    model.fit(
    tmp_trainX, train_y,
    cat_features=itera)

    predictions = model.predict(tmp_testX)
    print(confusion_matrix(test_y, predictions))
    print(accuracy_score(test_y, predictions))
    result.append(accuracy_score(test_y, predictions))

result = result.remove(999)

#dataset_catboost_chi_train_test1X
#
#path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_catboost_chi_train_test1X.feather'
#
#tmp = feather.read_dataframe(path)
#
#path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_catboost_chi_test_test1X.feather'
#
#tmp2 = feather.read_dataframe(path)
#
#predictions2 = model.predict(tmp2)
#accuracy_score(test_y, predictions2)
