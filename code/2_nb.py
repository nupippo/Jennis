# -*- coding: utf-8 -*-
"""
Created on Sun May 13 08:34:41 2018

@author: nupippo
"""

import feather
import pandas as pd
import numpy as np

import feather
import pandas as pd
import numpy as np
import datetime
from sklearn.naive_bayes import GaussianNB

#print(datetime.datetime.now())

path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold1_blind5_trX.feather'
train_x = feather.read_dataframe(path)


path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold1_blind5_trY.feather'
train_y = feather.read_dataframe(path)

path = 'D:\\workspace_R\\thalas\\20180427\\dataset\\dataset_val_fold1_blind5_teX.feather'
test_x = feather.read_dataframe(path)

path_write = 'D:\\workspace_R\\thalas\\20180427\\result\\nb\\nb_val_fold1_blind5.csv'


gnb = GaussianNB()
y_pred = gnb.fit(train_x, train_y).predict(test_x)
