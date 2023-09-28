#marketing campaign analysis of wine business
import pandas as pd
import seaborn as sns
from scipy import stats
import  matplotlib.pyplot as plt
from datetime import datetime,timedelta
import numpy as np
import os
#读取数据
filepath = "/Users/Linpingping/Desktop/marketing_campaign.csv"
df_wine = pd.read_csv(filepath,sep = ';')

#查看数据集包含字段，列值据格式
print(df_wine.info())
print(df_wine.columns)
print(df_wine.head())

#检查空值
null_sum = df_wine.isnull().sum()
for column, count in null_sum.items():
    print(f"column'{column}':{count} null values \n")


#计算用户年龄
current_date = datetime.now()

df_wine['Age'] = (current_date.year - df_wine['Year_Birth'])



# print(df_wine['Year_Birth'].unique())
# print(df_wine['Age'].unique())
# print(df_wine['Age'].dtype)
# print(df_wine.info())
# print(df_wine['Age'].isnull().sum())


#看用户年龄分布

unique_ids = df_wine['ID'].unique()
df_unique = pd.DataFrame({'ID': unique_ids})
df_merged = pd.merge(df_unique, df_wine, on = 'ID', how = 'left')

# df_age = df_merged['Age']
# df_age.plot(kind ='hist', x = 'Age')
# plt.xlabel('Age')
# plt.ylabel('Count')
# plt.title('Age Distribution')
# plt.show()

#教育水平分布
# print(df_merged['Education'].unique())
# edu_counts = df_merged['Education'].value_counts()
# labels = edu_counts.index
# counts = edu_counts.values

# plt.figure(figsize= (8,8))
# plt.pie(counts, labels = labels, autopct = '%1.1f%%',startangle=90)
# plt.axis('equal')
# plt.title('Education distribution')
# plt.show()

#收入分布
# df_income = df_merged['Income']
# df_income.plot(kind='hist', x = 'Income')
# plt.xlabel('Income')
# plt.ylabel('Count')
# plt.title('Income Distribution')
# plt.show()

# print(df_merged['Income'].unique())

print(df_merged['Recency'].head())
print(df_merged['Kidhome'].unique())
print(df_merged['MntWines'].head())
print(df_merged['Marital_Status'].unique())

#婚姻状态分布
# df_marital = df_merged['Marital_Status']
# marital_counts = df_marital.value_counts()
# labels = marital_counts.index
# counts = marital_counts.values
# plt.figure(figsize =(8,8))
# plt.pie(counts, labels = labels, autopct= '%1.1f%%', startangle=90) 
# plt.axis('equal')
# plt.title('Martial status distribution')
# plt.subplots_adjust(top= 1)  # 调整顶部边缘的位置
# plt.show()

# df_recency = df_merged['Recency']
# plt.hist(df_recency, bins = 30)
# plt.show()

#家庭子女数量分布
# df_kid = df_merged['Kidhome']
# print(df_kid)
# kid_counts = df_kid.value_counts()
# print(kid_counts)
# plt.bar(kid_counts.index,kid_counts.values)
# plt.title('Distribution of numbers of kids home')
# plt.xlabel('Number of kids home')
# plt.ylabel('Counts')
# plt.show()

#婚姻状态分布
df_mari = df_merged['Marital_Status']
print(df_mari)

# mari_counts = df_mari.value_counts()
# print(mari_counts)
# plt.bar(mari_counts.index, mari_counts.values)
# plt.title('Distribution of marriage status')
# plt.xlabel('Marital status')
# plt.ylabel('Counts')
# plt.show()
#出现一个柱子上两种颜色

# print(sum(mari_counts.values))
# print(sum([864,580,480,232,77,3,2,2]))

#各渠道顾客购买频次分布
# df_channel = pd.DataFrame(df_merged.loc[:,('NumCatalogPurchases','NumStorePurchases','NumWebPurchases')].sum())

# df_channel.columns = ['Number of purchases']
# print(df_channel)

# plt.pie(df_channel['Number of purchases'], labels = df_channel.index, autopct= '%1.1f%%', startangle=90)
# plt.title('Purchase channel breakdown')
# plt.subplots_adjust(top= 0.8)
# plt.show()

#各品类消费金额对比
# df_cater = pd.DataFrame(df_merged.loc[:,('MntFishProducts','MntMeatProducts','MntFruits','MntSweetProducts','MntWines')].sum())
# print(df_cater)
# plt.bar(df_cater.index,df_cater.iloc[:,0])
# plt.title('Purchase amount of different catergories')
# plt.xlabel('Catergory')
# plt.ylabel('Amount')
# plt.show()

#各活动的用户反馈情况
# accepted_campaigne_columns = ['AcceptedCmp1','AcceptedCmp2','AcceptedCmp3','AcceptedCmp4','AcceptedCmp5']
# counts_accepted = df_merged[accepted_campaigne_columns].sum()
# counts_rejected = df_merged[accepted_campaigne_columns].eq(0).sum()
# print("Counts of accepted campaigns(1):")
# print(counts_accepted)
# print("Counts of rejected campaigns(1):")
# print(counts_rejected)

# colors = ['red','blue']
# bar_width = 0.4
# x_ticks = np.arange(len(accepted_campaigne_columns))

# plt.bar(accepted_campaigne_columns,counts_accepted,color = colors[0],label = 'Accepted')
# plt.bar(accepted_campaigne_columns, counts_rejected, bottom=counts_accepted,color = colors[1],label = 'Rejected')

# plt.xlabel('Campaign Name', fontsize = 5)
# plt.ylabel('Count', fontsize = 14)
# plt.title('Counts of Accepted and Rejected Campaigns',fontsize = 16)
# plt.xticks(rotation = 45)
# plt.legend()
# plt.show()

# accpeted_ratio = (counts_accepted / len(df_merged))*100
# print("Accepted Ratio")
# print(accpeted_ratio.round(2))

# print()

# print(df_merged.groupby('Response').size())

# from textblob import TextBlob
# a = TextBlob("I miss shanghai")
# print(a.sentiment)

# b = TextBlob("Finally it's time to leave this city. Finnaly get to stay away from family")
# print(b.sentiment)

# c = TextBlob("Why the hell are these people so stupid ")
# print(c.sentiment)

# d = TextBlob("She is so mean that I want to punch her")
# print(d.sentiment)

# f = TextBlob("Based on the IQ tests, these people are not smart at all")
# print(f.sentiment)

#增加消费总频次和总金额
df_merged['total_frequency'] = df_merged['NumWebPurchases']+df_merged['NumCatalogPurchases']+df_merged['NumStorePurchases']

df_merged['total_amount'] = df_merged['MntWines'] + df_merged['MntFruits'] + df_merged['MntMeatProducts'] + df_merged['MntFishProducts'] + df_merged['MntSweetProducts'] + df_merged['MntGoldProds']

print(df_merged.head)

print(df_merged.describe(include = 'all'))

data =  df_merged.copy()

data = data.drop(['ID'], axis = 1)

data['Income'] = data['Income'].fillna( data['Income'].median())
print(data.info())

data['Education'] = data['Education'].map({'Graduation':1,'PhD':1,'Master':1,'Basic':0,'2n Cycle':0})

data['Marital_Status'] = data['Marital_Status'].map({'Single':0, 'Together':1, 'Married':2, 'Divorced':0, 'Widow':0, 'Alone':0, 'Absurd':0, 'YOLO':0})

date_data = data.copy()

# sns.lmplot(x = 'Income', y = 'total_amount', data = data)
# plt.show()

# date_data['Dt_Customer'] = pd.to_datetime(date_data['Dt_Customer'])

# print(date_data['Dt_Customer'].dtypes)

# list_month = [date_data['Dt_Customer'][i].month for i in range(date_data.shape[0])]
# date_data['enroll_month'] = list_month

# def date_to_weekday(date_value):
#     return date_value.weekday()
# date_data['enroll_weekday'] = date_data['Dt_Customer'].apply(date_to_weekday)

# date_data = date_data.drop(['Dt_Customer'],axis = 1)


# col = ['Year_Birth', 'Education', 'Marital_Status', 'Income', 'Kidhome',
#        'Teenhome', 'enroll_month', 'enroll_weekday',
#        'Recency', 'MntWines', 'MntFruits', 'MntMeatProducts',
#        'MntFishProducts', 'MntSweetProducts', 'MntGoldProds',
#        'NumDealsPurchases', 'NumWebPurchases', 'NumCatalogPurchases',
#        'NumStorePurchases', 'NumWebVisitsMonth', 'AcceptedCmp3',
#        'AcceptedCmp4', 'AcceptedCmp5', 'AcceptedCmp1', 'AcceptedCmp2',
#        'Complain', 'Z_CostContact', 'Z_Revenue', 'Response']

# date_data = date_data[col]

# print(date_data.head())

# data_with_dummies = date_data.copy()
# data_with_dummies = data_with_dummies.drop(['Z_CostContact'], axis = 1)
# data_with_dummies = data_with_dummies.drop(['Z_Revenue'], axis = 1)

# print(data_with_dummies.describe())

# col = ['Marital_Status', 'Kidhome', 'Teenhome', 'enroll_month', 'enroll_weekday']

# data_with_dummies = pd.get_dummies(data_with_dummies, columns = col, dtype = int)

# purchasing_behavior = data.loc[:,['total_frequency','total_amount','Income']]
# income_corr = purchasing_behavior.corr()['Income']
# print(income_corr)

data_with_dummies = pd.get_dummies(data, columns = [ ], dtype = int )


# from sklearn.linear_model import LinearRegression
# model = LinearRegression()
# x = np.array(purchasing_behavior['Income']).reshape(-1,1)
# print(x)
# y = np.array(purchasing_behavior['total_frequency'])
# model.fit(x, y)
# x_test = np.array([10000]).reshape(-1, 1) 
# y_pred = model.predict(x_test)
# print(y_pred)

# print(model.intercept_)
# print(model.coef_)

#相关性探索
# feature_corr = data_with_dummies.corr()['Response'].sort_values(ascending = False)
# print(feature_corr)



# col = ['AcceptedCmp5', 'AcceptedCmp1', 'AcceptedCmp3', 'MntWines', 'MntMeatProducts',
#        'NumCatalogPurchases', 'AcceptedCmp4', 'AcceptedCmp2', 'Teenhome_0', 'Marital_Status_0',
#        'Recency', 'Teenhome_1', 'Marital_Status_2', 'Marital_Status_1', 'Kidhome_1', 'Response']

# data_preprocessed = data_with_dummies[col]
# print(data_preprocessed)
m = [1,'a',3]
print(m[1])
