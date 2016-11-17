---
title: ExtJs5学习笔记（一）从零开始
date: 2016-05-04 09:32:13
tags: ExtJs5
categories: ExtJs5
---

之前使用过ExtJs2.x，但没有系统的学习过，刚好有时间想系统的学习下ExtJs，想来想去还是直接学ExtJS 5吧。

Ext JS 5的第一版本发行于2014年04月09日，ExtJS是一个基于JavaScript编写、主要用于创建前端用户界面、与后台技术无关的前端AJAX框架，可以用来开发富客户端的AJAX应用。因此，可以把ExtJS用在.Net、 Java、Php等各种开发语言开发的应用中。

<!-- more -->

# 1、What's New in Ext JS 5 #
## 1.1、不再支持IE6和IE7 ##

Ext JS 5支持IE8+和最新的平板电脑平台，如iOS6/7、Chrome上的Android4.1+和Win8触屏设备（如Surface和触屏笔记本）运行的IE10+。

## 1.2、顺应HTML5大潮 ##

添加了DOCTYPE文档类型标签<!DOCTYPE html>，且不支持省略该标签。

## 1.3、MVC和MVVM ##

Ext JS 4引入了对MVC架构的支持，在Ext JS 5中，又新增对MVVM（模型 - 视图 - 视图 - 模型）的支持，MVVM模式其中一个大的特点是数据绑定，将模型层和视图层链接起来，修改其中一个，另一个也会随之变化。

## 1.4、整合进Sencha Cmd包 ##

Ext JS 5现在包含在Sencha Cmd包中，名为ext，当你使用Sencha Cmd生成、构建、更新你的应用程序时（添加-ext参数），即可自动下载最新版的ExtJS。

## 1.5、配置系统和组件 ##

Ext JS 5扩展了配置系统，使之更加向后兼容。

## 1.6、新的主题和图表 ##

在Ext JS 5中，默认的经典主题被Neptune主题替代，新生成的应用程序将默认使用Neptune主题。ExtJS5中还包含一个增强版的图表包，带来了大量新功能，并且在平板电脑上拥有很好的性能。

## 1.7、More ##

更详细内容请查阅：<http://docs.sencha.com/extjs/5.0/whats_new/whats_new500.html>

# 2、在web系统中集成Ext JS 5 #
## 2.1、API下载： ##

我下载的是ext-5.1.0，如下图，下载途径有很多，可以去官网下载也可以在第三方网站下载。
<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-1.png" >

## 2.2、利用Sencha CMD ##

在网上学习的时候，有人利用Sencha CMD来创建Extjs5的项目，我平时做JavaEE开发，使用eclipse，如果这种方式将大量extjs5的资源导入到我的项目中，其中有很多内容是我们用不到的，这些内容会导致项目过于庞大，手工去删又很麻烦，所以我没有使用这种方式。不过这种方式有中好处就是会直接生成一个成形的目录结构，比较方便的使用MVC模式。

如果想了解的可以参考：<http://blog.csdn.net/jfok/article/details/35550713>

使用这种方式需要注意执行`sencha -sdk`命令时，要cd到你的ext-5.x目录中，比如我在myeclipse中建立了一个名为Extjs的java web项目，工作空间为：

`D:\Workspaces\MyEclipse 8.5\`

需要执行的命令就是：

`sencha -sdk ext-5.1.0 generate app Extjs D:\Workspaces\MyEclipse 8.5\Extjs5\WebRoot`

如果执行此命令时不是在ext-5.x目录下，会有错误提示：

`Unable to locate supported Framework...`

# 3、 手动引入必要文件 #
## 3.1、寻找有用的资源 ##

解压下载的源文件，并打开其中的build文件夹，首先找到ext-all.js和ext-all-debug.js，这两个js是ext比较核心的js，它包含了所有extjs的控件，ext-all.js是经过处理的，仍然有1.88M。ext-all-debug.js是没有经过处理的，其中包含空格换行等。

然后找到bootstrap.js，这个文件会在不同的环境中自动引用不同的js，在开发环境中会引用ext-all-debug.js，在正式环境中会使用ext-all.js。

查看注释：

```
/**
 * Load the library located at the same path with this file
 *
 * Will automatically load ext-all-dev.js if any of these conditions is true:
 * - Current hostname is localhost
 * - Current hostname is an IP v4 address
 * - Current protocol is "file:"
 *
 * Will load ext-all.js (minified) otherwise
 */
```

注释中提示使用ext-all-dev.js，实际代码中使用的ext-all-debug.js。且在5.1x源文件中也没有找到ext-all-dev.js。

查看bootstrap.js中代码:
```
document.write('<script type="text/javascript" charset="UTF-8" src="' + 
        path + 'ext-all' + (isDevelopment ? '-debug' : '') + '.js"></script>');
```

path是bootstrap.js所在目录。


然后是packages文件夹，这个文件夹中包含extjs主题、语言包等，如下图所示，红线圈出的是几个必要的文件夹。

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-2.png" >

其中ext-aria和ext-charts暂时不会用到，先保留下来备用。

ext-locale是本地化语言包，我们只需要里面的ext-locale-zh_CN.js，这个是简体中文语言包。

接下来的四个文件夹都是extjs的主题包，分别是经典主题、清新主题、灰色主题和海王星主题，其中ext-theme-crisp（清新主题）是extjs5新增的；ext-theme-neptune（海王星主题）是extjs4中新增的。经典主题和灰色主题大家会比较熟悉，从extjs诞生就存在的两个主题。这里可以根据自己的需要选择，初学还是都导入进行，看一下不同主题的效果。

## 3.2、集成至java web项目中 ##

在将Ext引入项目之前，需要将项目设置js不自动编译，否则的话会编译很长很长很长时间，导致你的工具卡死，具体怎么设置，请自行google。

我们在myeclipse中新建一个web项目，然后将extjs5必须的文件拷贝到项目里，得到如下图所示的目录结构：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-3.png" >

然后在webRoot根目录下新建文件index.html，并填入以下代码：
```javascript
<!DOCTYPE HTML>
<html>
<head>
    <title>Welcome</title>
    	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript"  src="extjs/packages/ext-all.js"></script>
	<script type="text/javascript"  src="extjs/packages/ext-locale/ext-locale-zh_CN.js"></script>
	<link rel="stylesheet" type="text/css" href="extjs/packages/ext-theme-neptune/build/resources/ext-theme-neptune-all.css">
	<script type="text/javascript" src="app.js"></script>
</head>
<body></body> 
</html>
```
然后我们在webRoot根目录下新建文件app.js，并填入以下代码：
```javascript
Ext.onReady(function () {
    Ext.MessageBox.alert("确定", "Hello World");
});
```
部署到tomcat中，运行并访问：<http://localhost:8082/Extjs5/index.html>

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4.png" >

如果觉得上述方法引入的还是太多，可以直接找到自己需要的文件引入。

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-5.png" >

使用这种方法，并对index.html中引入文件做对应的修改即可：
```javascript
<!DOCTYPE HTML>  
<html>  
<head>
    <title>Welcome</title>
    	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="js/extjs/bootstrap.js"></script>
    	<script type="text/javascript"  src="js/extjs/ext-locale-zh_CN.js"></script>
    	<link rel="stylesheet" type="text/css" href="resources/ext-theme-neptune-all.css">
	<script type="text/javascript" src="app.js"></script>
</head>  
<body></body>  
</html> 
```

由于以上html中引入了bootstrap.js，且我在bootstrap.js中增加以下代码：
```javascript
document.write('<script type="text/javascript" charset="UTF-8" src="' + 
        path + 'ext-locale-zh_CN' + (isDevelopment ? '-debug' : '') + '.js"></script>');
```
所以，当我的访问地址是localhost的时候，系统会调用`-debug`的js，如下:

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-6.png" >

到这里，extjs5已经可以正常使用了。

**注意：**

extjs需要是页面上第一个引入的js，否则的话会有如下错误提示，但是这个错误不影响页面的显示。

`Uncaught ReferenceError: Ext is not defined`