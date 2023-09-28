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

# #判断是否拒绝零假设
# if probability < alpha:
#     print("拒绝零假设，该批商品正品率不大于95%")
# else:
#     print("无法拒绝零假设，该批商品正品率>95%")

#应用案例3，仓库送来一包a款衣服，共200件，衣服胸围尺寸要求按工艺单108cm，99%的商品尺寸误差不大于2cm才可接收。质检员现从中抽取10件，胸围分别为：107,109,110,107.6,108.5,106.7,107.1,107.3,108,105,该批衣服是否可接收入库

#H0:该批衣服不满足99%的尺寸在[106,110]，不可接收
#H1:该批衣服满足99%的尺寸在[106,110]，可接收

import pandas as pd
import math
from scipy.stats import t
dataSer3 = pd.Series([107,109,110,107.6,108.5,106.7,107.1,107.3,108,105])
sample3_mean = dataSer3.mean()
sample3_std = dataSer3.std()
pop_mean3 = 108      #总体均值
sample3_size = 10   #样本量
print('样本均值=%.2f'%sample3_mean)
print('样本方差=%.2f'%sample3_std)

#设定显著性水平为1%
alpha1 = 0.005
# t_value3 = (sample3_mean-pop_mean3)/(sample3_std/ np.sqrt(sample3_size))
# df3 = sample3_size-1   #自由度

# p_value3 = 2 *(1 - t.cdf(abs(t_value3),df3))
# print(p_value3)

t3,p3_twotail = stats.ttest_1samp(dataSer3,pop_mean3)
print('t值=',t3,'双尾检验p值',p3_twotail)

p3_onetail = p3_twotail/2

if p3_onetail < alpha1:
    print("拒绝零假设")
else:
    print("不拒绝零假设")


import random as rd
x = rd.randint(1,10)
print(x)








