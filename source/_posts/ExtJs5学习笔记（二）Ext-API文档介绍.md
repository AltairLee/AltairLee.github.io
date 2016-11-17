---
title: ExtJs5学习笔记（二）Ext API文档介绍
date: 2016-05-12 17:59:55
tags: ExtJs5
categories: ExtJs5
---

文档API是最好的教程，这句话一点都没错，不管是学习什么语言，查看文档是一项必备的技能。

<!-- more -->

# 1、API挂载至服务器 #

* 首先下载ext-docs-5.1，自行百度，这个应该不是问题，下载完成后解压，可以看到主目录下有一个5.1.0-apidocs的文件夹，这里面存放的才是Ext的API，打开后看到里面index.php，我把它改成了index.html。

* 这个index.html文件直接打开也是可以看的，但是其中一些例子的预览是没办法显示的，如下图：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-8.png" >

我们需要将这个文件夹挂载到一个服务器上，这里我使用了一个非常小巧的服务器EasyWebSvr.exe，整个服务器大小不过百k，网上有好多下载方法。

* 下载完成后，双击启动，可以看下系统右下角任务中有一个图标就是服务器已经启动了，双击该图标打开其界面，在其主面板上右键，点击设置：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-9.png" >

选择服务器主目录，这个目录是到我们刚才下载文件的主目录即可,比如我的目录就是`D:\5.1.0-apidocs`。设置完成之后，点击确定，如果这里提示重启服务器，确定即可。如果没有提示，需要自己手动重启。同样是在面板上右键，点击启动或者重启服务器即可。

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-10.png" >

* 挂载完成后，我们就可以访问API了，同样在面板右键，点击浏览主页，会自动寻找`D:\5.1.0-apidocs\index.html`，并将其打开，这时，再看某些例子的预览，就可以显示了。

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-11.png" >

# 2、API内容介绍 #

## 2.1、最左边的树： ##

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-12.png" style="float:left">表示单例对象（singleton）：单例对象，在代码中可以直接使用该对象，而不用new。

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-13.png" style="float:left">表示包（package）： 类似于java的那种包结构，访问对象时，也是使用严格的包结构。

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-14.png" style="float:left">表示类（class）： 可以new一个class实例对象。

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-15.png" style="float:left">表示组件（component）：可以使用creat或者define创建一个组件。


## 2.2、类的基本内容： ##
* Config：该类创建时构造方法的参数。通过这些配置项，我们可以改变页面显示该元素的样式等内容。
* Properties：该类的成员变量，可以通过`.`来访问。
* Methods：该类支持的方法。
* Events：该类支持的事件。

## 2.3、类之间的继承关系： ##
* Ext.Base：基类，Ext所有的类都继承自它
* 在页面右边有类的层级关系。

# 3、总结 #

每一个元素中都有有很多很多以上的属性，比如，Button组件就有219个方法，我们不可能完全用到，也基本上不可能全部都认识，当然我们也不必全部都认识，了解常用的方法、配置即可，如果有其他需要，可以查找api解决。