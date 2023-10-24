#应用案例1：汽车引擎新排放标准是平均值<20ppm，现某公司抽取10台汽车样本，其引擎排放水平为 15.6 16.2 22.5 20.5 16.4 19.4 16.6 17.9 12.7 13.9，判断该公司汽车是否符合新排放标准？

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
#建立样本数据
# dataSer = pd.Series([15.6,16.2,22.5,16.4,19.4,16.6,17.9,12.7,13.9])
# #求样本平均值和标准差
# sample_mean = dataSer.mean()
# sample_std = dataSer.std()
# print('样本平均值=%.2f'%sample_mean)
# print('样本标准差=%.2f'%sample_std)
# print('单位：ppm')

# import seaborn as sns
# sns.distplot(dataSer)
# plt.title('数据分布')
# plt.show()

# #H0: 汽车排放平均值>=20，不符合标准
# #H1: 汽车排放平均值<20，符合标准

# #找证据
from scipy import stats
# pop_mean = 20
# t,p_twoTail = stats.ttest_1samp(dataSer,pop_mean)
# print('t值=',t,'双尾检验的p值',p_twoTail)

# p_oneTail = p_twoTail/2

# print(p_oneTail)

# from matplotlib.font_manager import FontProperties

# #应用案例2：仓库送来200件服装，入库要求正品率>95%,质检8件商品其中1件是次品，该批商品该不该接收入库？
# #H0: 该批商品正品率>95%
# #H1:该批商品正品率<=95%
# #设定显著性水平 
# alpha = 0.05
# from scipy.stats import binom
# n = 8
# p = 0.95
# k = 1
# #计算样本中1件次品发生的概率
# probability = binom.pmf(k,n,p)









