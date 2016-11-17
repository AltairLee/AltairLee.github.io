---
title: ExtJs5学习笔记（四）Ext常见知识点补充
date: 2016-05-27 19:49:40
tags: ExtJs5
categories: ExtJs5
---

# 1、类定义、继承及引用 #

JavaScript是面向对象的，所以也有类的概念，当然在js中可能用的不多，但Ext又将它进一步封装，看起来更像一个类了。

<!-- more -->

## 1.1、类的定义： ##
```
Ext.onReady(function(){
	//定义一个类。My.awesome是命名空间
	Ext.define('My.awesome.Class', {
	    someProperty: 'something', 	//属性someProperty
	    someMethod: function(s) {	//方法someMethod
	        alert(s + this.someProperty);
	    }
	});
	//创建一个类
	var obj = new My.awesome.Class();
	
	obj.someMethod('Say '); // alerts 'Say something'
});
```

运行如下：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4.1.png" >

看一下浏览器控制台输出：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4.2.png" >

可以看到类的属性、方法都已经显示在类中，而且类定义的时候，我们并没有指定它的父类，但是它的superclass是`Ext.Base`,它就相当于java中的Object类，所有类默认继承自它。

其他常用属性：
```
Ext.onReady(function(){
	//定义一个类。My.awesome是命名空间
	Ext.define('My.awesome.Animal', {
		alias: 'animal',//别名，在类引用时，可以直接使用别名
	    config : {	//可配置项，设置默认值，Ext会自动为其添加get和set方法。
			name : 'animal',
			age : '0'
		},
		constructor:function(cfg){	//构造函数，接受用户自动以的配置
			this.initConfig(cfg);
		},
		statics:{ 	//类的静态属性  
	        info:'say something'
	    },
		someProperty: 'something', 	//属性someProperty
	    someMethod: function(s) {	//方法someMethod
	        alert(s + this.someProperty);
	    }
	});
	//实例化一个类
	var obj = new My.awesome.Animal();
	//实例化类的另一个方法，也是Ext的推荐方法
	var obj1 = Ext.create('animal',{
		name : 'dog',
		age : '10'
	});
	
	console.log(obj);
	
	console.log(obj1);
	
	obj1.someMethod('Say '); // alerts 'hello nothing'

});
```

查看控制台输出：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4.3.png" >

obj的config配置项的值是默认值。

obj1的config配置项的值是用户指定的值。

## 1.2、类的继承： ##

我们在原来代码的基础上添加以下代码：
```
	//继承一个类
	Ext.define('My.awesome.Person',{
		extend:'My.awesome.Animal',//表示Person继承自Animal类
		alias: 'person'
		
//		requires: [ //表示要使用Person需要先加载Other类
//	        'My.awesome.Other'
//	     ]
	});
	var per = Ext.create('person',{
	
	});
	console.log(per);
	
	per.someMethod('person ');
```

可以看到第二个弹窗：
<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4.4.png" >

说明Person继承了父类的方法

以及后台输出：
<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4.5.png" >

说明Person定义了自己的属性


# 2、常见方法 #

## 2.1、Ext.onReady() ##

用于监听ExtJS以及所有的HTML页面是否加载完成。当一切都加载完成后执行Ext.onReady()指定的方法。

Ext.onReady(Object fn, Object scope, Object options)
* 第一个参数fn指定ExtJS和HTML页面加载完成后要执行的方法
* 第二个参数scope是可选的，表示fn方法的执行的范围
* 第三个参数options是可选的，执行一些附加选项，比如delay等

```
var fn = function() {
	alert("名字是：" + this.name);
};
var user = {
	"name" : "lz"
};

Ext.onReady(fn, user);
```

上述代码的意思是，当页面加载完成，执行fn函数，并且是在user的范围内。可以理解为fn中的this就代表的user，如果没有指定user，默认为整个页面document。


## 2.2、Ext.apply()和Ext.applyIf() ##

两个方法都是用于把一个对象中的属性复制到另一个对象中，也就是这两个方法都用于实现属性复制。不同的是，Ext.apply()将会覆盖目标中的属性，而Ext.applyIf()只复制目标对象中没有、而源对象中有的属性不会发生属性覆盖。

```
Ext.onReady(function(){
	var user = {
		name : "lz",
		age : 23,
		sex : "boy"
	};
	
	var cat = {
		name : "cat",
		age : 22
	};
	
	var animal = {
		name : "animal",
		age : 23,
		sex : "female"
	};
	
	var dog = {
		name : "dog",
		age : 20,
		sex : "male",
		color : "balack"
	};
	
	// 将cat对象的属性复制到user中
	Ext.apply(user, cat);
	console.log(user);
	// 将cat对象的属性复制到user中，如果属性已经存在，则不复制
	Ext.applyIf(animal, dog);
	console.log(animal);
});
```

查看控制台输出：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4.6.png" >

第一次输出，name、age属性都被替换了。

第二次输出，name、age、sex都没有替换。

# 3、数据Data #

基本上所有的应用程序都是以数据传递和交互为目的的，所以Ext中有一系列管理数据的类，都处在Ext.data中，其中最重要的是model，proxy，reader，store几个类，比如我们在ComboBox或者Grid中用到的数据，都是通过data包中的类来获取的。这里我们先大体了解一下，到以后的应用中就不会不知所措。

* model - Ext.data.Model:数据模型，相当于java中的bean，定义了数据格式。
* store - Ext.data.Store：存储数据，可以理解为数据的存储器，组件取数通常是使用它。
* proxy - Ext.data.proxy.Proxy：请求数据，可能来自不同的地方，如数据缓存、服务器后台等。
* reader - Ext.data.reader.Reader：接收数据，负责对不同格式的数据进行接收。

## 3.1、model ##

Ext.data.Model的四个主要部分，Fields（字段）, Proxies（代理）, Associations（关联），Validations（验证）。

```
Ext.onReady(function(){
	var data = {//后边使用
	    users: [
	        {
	            id: 1,
	            name:'lz',
		        age: '25',
		        phone:'1301234',
		        gender:'mail',
		        alive:true
	        },
	        {
	            id: 2,
	            name: 'Abe Elias',
	            phoneNumber: '666 1234'
	        }
	    ]
	};
	
	//	定义一个User数据模型
	Ext.define('User', {
	    extend: 'Ext.data.Model', //数据模型，都要继承Model类
	    fields: [ //模型所包含的字段及类型 . fields可以不定义类型直接定义为 fields: ['id','name', ... ]，不过最好还是定义type，会有诸多好处
	        { name: 'id',     type: 'int' },
	        { name: 'name',     type: 'string' },
	        { name: 'age',      type: 'int' },
	        { name: 'phone',    type: 'string' },
	        { name: 'gender',   type: 'string' },
	        { name: 'alive',    type: 'boolean', defaultValue: true }
	    ],
	    validators: { //数据验证 
	        id: 'presence',	//presence表示必须的
	        name: { type: 'length', min: 2 },	//长度验证，最少为2的字节
	        gender: { type: 'inclusion', list: ['Male', 'Female'] }	//内容验证，是否是Male或者Female
//	        username: [
//	            { type: 'exclusion', list: ['Admin', 'Operator'] },	//不能是Admin或者Operator
//	            { type: 'format', matcher: /([a-z]+)[0-9]{2,3}/i }	//格式验证，支持正则表达式
//	        ]
	    }
	});
});
```

这个一个最基本的的数据模型，当然，如果不需要验证的话，validators也不需要。Proxies可以直接定义在model中，但是我通常不这样做，我会在store中再去定义proxy。

Associations表示该数据模型与其他数据模型的关联关系。比如我们的user类，每一个user可以创建很多posts（帖子），也就是说user相当于post的一个外键，我们可以这样定义：
```
Ext.define('Post', {
    extend: 'Ext.data.Model', //数据模型，都要继承Model类
    fields: [
    	{ name: 'user_id', reference: 'User' }//定义user与post一对多的关联关系，可以称之为外键。
 	]
});
```
Ext中还可以表示其他的Associations，有一对一，多对多等，具体例子可以查看API介绍。

除了proxy，以上就是model的所有内容了。

## 3.2、store、proxy、reader ##

store相当于一个存储器，它的两个主要属性就是model和proxy，proxy是一个重要属性就是reader。

在上边的代码后增加以下代码：

```
//定义一个Store
var myStore = Ext.create('Ext.data.Store', {
    model: 'User', //使用User模型
	data : data,//读取本地数据时，要定义数据来源
    proxy: {	//设置代理
        type: 'memory',	//读取本地数据
    	reader: {
            type: 'json',	//要读取的数据格式为json
            rootProperty: 'users'	//从json中要读取的对象
        }
    },
    autoLoad: true
});
```

上边就是一个基本的Store，首先看一下其中的proxy。type是它的一个主要配置，表示数据的来源，有两大类：客户端和服务器端。

**客户端：**

* memory：
* localstorage：
* sessionstorage：

最常用的就是memory，直接在js中定义一个数据对象，就像上边的例子。

**服务器端：**

* ajax
* jsonp
* rest
* direct

最常用的是ajax，通过url从后台获取数据，这种方式的时候，我们就不需要data属性了：
```
proxy: {
    type: 'ajax',//使用ajax方式读取后台数据
    url : 'users.json'
	reader: {
            type: 'json',	//要读取的数据格式为json
            rootProperty: 'users'	//从json中要读取的对象
        }
}
```

reader相当于数据的解析，它可以解析json，xml，array。可以根据自己的需要选择，不过json还是最优秀的一种数据格式。

这一节的具体事实例应用请查看博文grid的实现。

