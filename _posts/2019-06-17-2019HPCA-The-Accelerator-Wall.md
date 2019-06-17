---
layout:     post
title:      2019HPCA Best Papers
subtitle:   计算机体系结构旗舰会议之一HPCA 2019 的Best Papers
date:       2019-06-17
author:     Lin
header-img: img/2019HPCA-1.jpg
catalog: true
tags:
    - Paper
    - architecture
    - HPCA
---
# 前言

> Hi everyone, Here I will present the **HPCA2019** best papers.

# The Accelerator Wall: Limits of Chip Specialization
Adi Fuchs, David Wentzlaff. Princeton University.

##摘要
使用硬件加速器的定制化芯片已成为减小增长的计算需要与由于CMOS扩展下降而停滞的晶体管预算导致的隔阂的主要方法。
芯片定制化的收益大多数源于在给定一个芯片的晶体管预算下优化一个计算问题。不幸的是，可用的晶体管数量的停滞将限制加速器设计优化空间，
导致降低定制化反馈，最终hitting 一个 加速墙，accelerator wall。

本文，我们处理什么是未来加速器和定制芯片的限制的问题。我们通过刻画当前的加速器是如何依赖于CMOS扩展，基于一个物理模型工具使用几千个芯片的数据手册构建来做
这项工作。我们确定了定制芯片中使用的关键概念，并探索了案例分析来理解在不同应用的时间跨度上和芯片平台（如GPU,FPGAs,ASICs）上定制是如何进展的。利用这些探
视，我们构建了一个模型，映射前面来看将来会收获什么，将来可以或不可以从定制性芯片获得什么。一个定制反馈的量化分析和技术阻隔是关键的用于帮助研究人员理解加
速器的限制和开发方法来客服他们。

## 关键字 accelerator wall，moore's law, CMOS Scaling

citation 
```
@inproceedings{fuchs2019accelerator,
  title={The Accelerator Wall: Limits of Chip Specialization},
  author={Fuchs, Adi and Wentzlaff, David},
  booktitle={2019 IEEE International Symposium on High Performance Computer Architecture (HPCA)},
  pages={1--14},
  year={2019},
  organization={IEEE}
```
