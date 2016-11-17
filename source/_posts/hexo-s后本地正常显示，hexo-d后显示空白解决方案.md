---
title: hexo s后本地正常显示，hexo d后显示空白解决方案
date: 2016-11-17 11:17:58
tags: Hexo
categories: Hexo
---
记录于2016-11-16

**问题：**
突然间我的博客访问出错了，显示空白，在控制台查看，所有vendor文件夹下的js全部加载异常。

**原因：**
查找资料才发现由于github在11月3号更新之后，升级了 Jekyll 到 3.3，Jekyll 为了加快构建速度，忽略 vendor 和 node_modules 文件夹。所以才出现了上边的问题。

**解决方案：**
1.更新主题（我没有试验，用的是第二种方法）
2.在你本地博客目录下，找到themes/next/source目录，将vendor文件夹修改为lib（或者其他），然后找到主题的配置文件，在next的根目录下_config.yml，将其中vendors: vendors修改为vendors: lib，或者是_internal: vendors修改为_internal: lib，看你自己的配置。