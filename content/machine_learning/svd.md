---
title: 奇异值分解的应用
date: 2017-02-02 10:37:10
---
[TOC]

## 特征值分解
奇异值分解和特征值分解有紧密的联系，特征值分解和奇异值分解的目的都是一样，就是提取出一个矩阵最重要的特征。

### 特征值与特征向量

- 定义

如果说一个向量v是方阵A的特征向量，将一定可以表示成下面的形式：
$$
Av = \lambda v
$$
这时候λ就被称为特征向量v对应的特征值，一个矩阵的一组特征向量是一组正交向量。特征向量必须是非零向量，且必是列向量。

- 含义
     - 特征向量的代数上含义是：将矩阵乘法转换为数乘操作。
     - 特征向量的几何含义是：特征向量通过方阵A变换只进行伸缩，而保持特征向量的方向不变。
     - 特征值表示的是这个特征到底有多重要，类似于权重，而特征向量在几何上就是一个点，从原点到该点的方向表示向量的方向。

### 特征值分解的定义

![特征值分解](http://oa5sa0jqw.bkt.clouddn.com/c2e4911a29158770ea870f6e98eb2304.png)

## 奇异值分解
特征值分解是一个提取矩阵特征很不错的方法，但是它只适用于方阵，奇异值分解则是一个能适用于任意的矩阵的一种分解的方法。

### 奇异值分解的定义

任一矩阵A都可以分解为
$$A_{m * n}=U_{m * m}\Sigma_{m * n}{V^T}_{n * n}$$

U里面的向量是正交的，称为左奇异向量。V里面的向量也是正交的，称为右奇异向量。
$\Sigma$除了对角线的元素都是0，对角线上的元素称为奇异值。

### 奇异值分解和特征值分解的对应关系
U的列是$AA^T$的特征向量，V的列是$A^TA$的特征向量，奇异值的平方是特征值。

![svd和特征值分解的关系](http://oa5sa0jqw.bkt.clouddn.com/05b644b2ba9a4715518b9a07ce2ad9c0.png)

### 矩阵压缩
![矩阵压缩](http://oa5sa0jqw.bkt.clouddn.com/eb41401bef80f57aebd6049dd1a6a619.png)

右边的三个矩阵相乘的结果将会是一个接近于A的矩阵，在这儿，r越接近于n，则相乘的结果越接近于A。而这三个矩阵的面积之和（在存储观点来说，矩阵面积越小，存储量就越小）要远远小于原始的矩阵A，我们如果想要压缩空间来表示原矩阵A，我们存下这里的三个矩阵：U、Σ、V就好了。

## PCA算法

### 理论分析
参考[PCA的数学原理](http://blog.codinglabs.org/articles/pca-tutorial.html)，有详细的分析。

注意的点：

- 分解$X^TX$或者$XX^T$（协方差矩阵）都可以求解PCA，前者从V矩阵里获取投影矩阵，后者从U矩阵里获取投影矩阵（[参考](https://www.zhihu.com/question/39234760)）
- 对于对称方阵，其特征值分解和奇异值分解是一样的

### 直观理解

$$
A_{m  *  n} \approx U_{m * r}\Sigma_{r * r}{V^T}_{r * n}
$$

由于V是正交矩阵，则

$$
A_{m * n} V_{n * r} \approx U_{m * r}\Sigma_{r * r}
$$
右边的矩阵即达到了对A矩阵列降维的目的。其实对$X^TX$分解求特征向量的过程，就是求上式V矩阵的过程（参考奇异值分解和特征值分解的对应关系）。

因此分解A的协方差矩阵或者分解A的内积或者直接对A做SVD分解，都是进行PCA降维的途径。
