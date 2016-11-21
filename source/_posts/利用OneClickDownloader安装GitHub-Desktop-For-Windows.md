---
title: 利用OneClickDownloader安装GitHub Desktop For Windows
date: 2016-11-04 19:57:13
tags: tools
categories: tools
---

下载微软OneClick方式部署的软件安装包到本地磁盘，方便墙内安装GitHub Desktop for Windows。

**下载地址：**
git：
https://github.com/lingbage/OneClickDownloader
百度云：
链接：http://pan.baidu.com/s/1slaVcnj 密码：a24l

<!-- more -->

**使用方法:**

1.打开cmd控制台，cd到OneClickDownloader.exe文件所在目录：

2.创建任务，执行命令: 

`OneClickDownloader.exe CreateTask GitHubSetup http://github-windows.s3.amazonaws.com/GitHub.application`

3.下载文件,执行命令: 

`OneClickDownloader.exe RunTask GitHubSetup`

4.网络不稳定的情况下部分文件可能下载失败，反复运行下载文件命令，直到提示所有文件下载完成，然后双击.application文件，安装软件
