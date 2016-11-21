---
title: win10下利用DockerToolbox-1.12.2安装及使用Docker
date: 2016-11-21 09:29:01
tags: tools
categories: tools
---

利用DockerToolbox使用Docker是相当方便的，当然你也可以不用DockerToolbox而直接安装Docker。官方文档讲的还是非常详细的，地址：https://docs.docker.com/docker-for-windows/ 。不过，需要注意的是在官网中提到，如果不使用DockerToolbox，最新版的Docker只能在win10专业版、企业版和教育版下安装，且要启用Hyper-V（微软自带的虚拟机），当然，也可能不一定非是这样，我并没有读的非常仔细，因为我使用的是DockerToolbox。

# 1.下载
**↓↓↓**
官方下载：
https://www.docker.com/products/docker-toolbox
GItHub：
https://github.com/docker/toolbox/releases
百度云：
链接：http://pan.baidu.com/s/1o88QGeI  
密码：hizo
git下载较慢，建议使用百度云
<!-- more -->
# 2.安装
系统及硬件安装要求：
（1）系统必须是win7及以上64位系统。
（2）硬件必须支持虚拟化技术且已经开启。

没有开启的话需要在BIOS中设置，方法请自行google。对于win10来讲，可以在任务管理器中查看是否已开启
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/docker-install-win%E8%99%9A%E6%8B%9F%E5%8C%96.png)

满足以上两个条件后就可以进行安装了。接打开DockerToolbox-1.12.2.exe进行安装
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/docker-install-%E5%AE%89%E8%A3%851.png)

如果你已经安装了VirtualBox，记得去掉勾选，其他的默认即可
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/docker-install-%E5%AE%89%E8%A3%852.png)
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/docker-install-%E5%AE%89%E8%A3%853.png)
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/docker-install-%E5%AE%89%E8%A3%854.png)

安装完成后，就可以看到桌面上会出现三个图标
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/docker-install-%E5%AE%8C%E6%88%90%E6%88%AA%E5%9B%BE.png)

运行Docker Quickstart Terminal，第一次执行他会进行一些初始化配置操作，稍等一段时间，初始化完成后，会看到以下内容
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/docker-install-docker%E5%88%9D%E5%A7%8B%E5%8C%96.png)

通过运行·docker run hello-world·验证是否安装成功，如果出现以下内容，说明Docker已经安装成功了。
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/docker-install-docker%E5%AE%89%E8%A3%85%E6%B5%8B%E8%AF%95.png)

# 3.简介


# 4.使用方法简介
