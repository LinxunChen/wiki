---
title: Pandas
date: 2017-02-19 10:37:10
---
[TOC]

``` python
import pandas as pd
```
## 文本读取
读csv文件用`pd.read_csv`（默认分隔符为逗号），读txt用`pd.read_table`（默认分隔符为tab符），例：
``` python
data = pd.read_table('%path%',sep=',',header=None, names=['shop','dt','week','holiday','pay'], dtype={'dt':'str'})
```
参考文档：[pandas读写文本数据](http://freefarm.cc/2016/05/23/PANDAS%E5%B8%B8%E7%94%A8%E6%89%8B%E5%86%8C-I-%E8%AF%BB%E5%86%99%E6%96%87%E6%9C%AC%E6%95%B0%E6%8D%AE/)

## 创建对象
![pandas数据结构](http://oa5sa0jqw.bkt.clouddn.com/3d18ec345d080d3aed6532a1742045d0.png)

## 查看数据

### 查看概况
``` python
print(data.head(5))  前5个
print(data.tail(5))  后5个
print(data.describe())  注：非数字和null的看不到；25%、75%那个是百分位数
print(data["holiday"].unique()) 看某特征有哪些取值
```

## 排序

### 按列值排序
```python
# 先按shop升序排序，再按dt来，ascending默认是True
data = data.sort(['shop','dt'])
```
### 按轴排序
```python
# 按列名排序，如果axis=0则按照rowID进行排序
data = data.sort_index(axis=1, ascending=False)
```

## 选择

### 简单粗暴
- 列选择
```python
# 选择一个单独的列
data = data['shop']
# 选择多个列
data = data[["shop", "dt"]]
```
- 行选择
```python
# 选择前三列，和多列选择一定要注意区分
data = data[0:3]
# rowid按时间选择
data = data['20160102':'20160109']
```
### 使用标签选取
```python
df.loc[行标签,列标签]
df.loc['a':'b'] #选取ab两行数据
df.loc[:,'one'] #选取one列的数据
```
df.loc的第一个参数是行标签，第二个参数为列标签（可选参数，默认为所有列标签），两个参数既可以是列表也可以是单个字符，如果两个参数都为列表则返回的是DataFrame，否则，则为Series。

### 使用位置选取
```python
df.iloc[行位置,列位置]
df.iloc[1,1]#选取第二行，第二列的值，返回的为单个值
df.iloc[[0,2],:]#选取第一行及第三行的数据
df.iloc[0:2,:]#选取第一行到第三行（不包含）的数据
df.iloc[:,1]#选取所有记录的第一列的值，返回的为一个Series
df.iloc[1,:]#选取第一行数据，返回的为一个Series
```
更广义的是使用df.ix，自动判断使用位置还是标签进行切片

### 使用布尔值选取
```python
df[逻辑条件]
df[df.one>=2]#单个逻辑条件
df[(df.one>=1) & (df.one<3)]#多个逻辑条件组合
```
这种方式获得的数据切片都是DataFrame。

## 基本运算

### 转置
```python
print(data.T)
```

### 统计计算
```python
df.mean()#计算列的平均值，参数为轴，可选值为0或1（即mean(1)）.默认为0，即按照列运算
df.sum(1)#计算每行的和
```

### 基于一列产生新的一列
```python
# 每一个元素都处理
titanic["NameLength"] = titanic["Name"].apply(lambda x: len(x))
```
```python
# 每一个元素都处理，调用函数
import re
titles = titanic["Name"].apply(get_title)  
# A function to get the title from a name.
def get_title(name):
    # Use a regular expression to search for a title.  Titles always consist of capital and lowercase letters, and end with a period.
    title_search = re.search(' ([A-Za-z]+)\.', name)
    # If the title exists, extract and return it.
    if title_search:
        return title_search.group(1)
    return ""
```
```python
# 每一行都处理，一行一行的调用函数
family_ids = titanic.apply(get_family_id, axis=1)
# A function to get the id given a row
def get_family_id(row):
    # Find the last name by splitting on a comma
    last_name = row["Name"].split(",")[0]
    ...
```

## 缺失处理
```python
# 缺失值填充
titanic['Age'] = titanic['Age'].fillna(titanic['Age'].median())
# 去掉缺失值的行
df.dropna(how='any')
```

## 其他
### 类型转换
```python
# 将第一列全部转换为string类型
data.iloc[:,1].astype(str)
```
### 字符串转时间对象
```python
import datetime
x = '20160102'
datetime.datetime(int(x[0:4]),int(x[4:6]),int(x[6:]))
```
