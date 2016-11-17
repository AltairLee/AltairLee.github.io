---
title: ExtJs5学习笔记--了解ExtJs中的MVC、MVVM
date: 2016-05-05 19:05:30
tags: ExtJs5
categories: ExtJs5
---

MVC模式应该每一个开发人员都不陌生，Model-View-Controller是一种软件架构模式，它把应用分为相对独立的三部分，每一个部分负责自己的工作。在不同的应用里，MVC的实现可能不太相同，但每个模块负责的内容却基本类似。

* Model（模型）是应用程序中用于处理应用程序数据逻辑的部分，通常模型对象负责在数据库中存取数据。
* View（视图）是应用程序中处理数据显示的部分，通常视图是依据模型数据创建的。
* Controller（控制器）是应用程序中处理用户交互的部分，通常控制器负责从视图读取数据，控制用户输入，并向模型发送数据。

<!-- more -->

上边是MVC较为通用的解释，在ExtJs中，具体一点来讲就是：

* Model（模型）描述了app中用到的通用数据格式，也可以包含业务规则、校验逻辑、和其他功能
* View（视图）负责展现数据给用户，可以有多个视图通过不同的方式展现同一份数据，例如图标和表格
* Controller（控制器）是MVC应用的中心，它监听事件，代理视图和模型的相互调用

在JS的开发过程中，大规模的JS脚本难以组织和维护，这一直是困扰前端开发人员的头等问题。Extjs为了解决这种问题，在Extjs 4.x版本中引入了MVC开发模式，开始将一个JS（Extjs）应用程序分割成Model-View-Controller三层，为JS应用程序的如何组织代码指明了方向，同时使得大规模JS代码变得更加易于重用和维护；在Extjs 5.x版本中又引入了MVVC模式，虽然两者相差不大，但还是要有所了解。

# 常规开发 #

在extjs4之前，我们都是使用的常规开发的模式，就是一个页面的相关内容都写在一个js中，或者是一个文件夹下。下面首先用常规模式写一个小程序。

app.js
```
Ext.onReady(function () {
	//1.定义Model
	var model = Ext.create('Ext.data.Model',{
		fields : [
			{name : 'name', type : 'string'},
			{name : 'email', type : 'string'},
			{name : 'phone', type : 'string'},
			{name : 'id', type : 'string'}
		]
	});
	
	//2.创建store
	var store = Ext.create('Ext.data.Store',{
		model: model,
		data : [
			{'name': 'Lisa', 'email': 'lisa@simpsons.com','phone': '555-111-1224'},
			{'name': 'Bart', 'email': 'bart@simpsons.com','phone': '555-222-1234'},
	        {'name': 'Homer', 'email': 'homer@simpsons.com','phone': '555-222-1244'},
	        {'name': 'Marge', 'email': 'marge@simpsons.com','phone': '555-222-1254'}
		]
	});
	//3.创建grid
	var viewport = Ext.create("Ext.container.Viewport", {
        layout: "fit",
        items: {
            xtype: "grid",
            model: model,
            store: store,
            columns: [
                { text: '姓名', dataIndex: 'name' },
                { text: '邮箱', dataIndex: 'email' },
                { text: '电话', dataIndex: 'phone' }
            ]
        }
    });
});
```
index.html
```
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
部署至tomcat后运行：
<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-7.png" >

# MVC模式 #

使用常规模式开发完成后，我们再看一下如何利用MVC模式开发。
(未完)


# 总结 #

在这个例子中，看上去可能常规模式的开发要比MVC模式更简单，这个是由于我们的例子过于简单造成的，MVC主要为我们提供一个完善的代码组织和维护的方式，有利于代码的解耦。在大型的系统开发过程中，大量的页面会逐渐体现MVC模式的优势。
