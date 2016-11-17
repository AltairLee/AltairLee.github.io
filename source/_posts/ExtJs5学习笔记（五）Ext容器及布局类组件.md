---
title: ExtJs5学习笔记（五）Ext容器及布局类组件
date: 2016-05-30 18:34:27
tags: ExtJs5
categories: ExtJs5
---

这里我们看一下常用的布局类组件。

# 1、视图组件--Ext.container.Viewport： #

这个是Ext提供的一个页面布局，他分为上、下、左、右、中，五部分，我们可以在每一部分进行再开发。

<!-- more -->

```
Ext.onReady(function(){
	/*
	 * Ext.container.Viewport
	 */
	Ext.create('Ext.container.Viewport', {
	    layout: 'border',//layout一般默认为auto，但Viewport必须为border。
	    items: [{
	    	//可以用来写整个页面的标题，logo等信息
	        region: 'north', //region设置所处的位置
	        html: '<h1 class="x-panel-header">页面标题</h1>',
	        border: false,
	        margin: '0 0 5 0'
	    }, {
	    	//左侧面板可以写一棵树作为导航之类的东西
	        region: 'west',
	        collapsible: true,
	        title: 'Navigation',
	        width: 150
	    }, {
	    	//这里可以写一下补充信息等内容
	        region: 'south',
	        title: 'South Panel',
	        collapsible: true,
	        html: 'Information goes here',
	        split: true,
	        height: 100,
	        minHeight: 100
	    }, {
	        region: 'east',
	        title: 'East Panel',
	        collapsible: true,
	        split: true,
	        width: 150
	    }, {
	    	//主面板，页面主要内容一般在这里
	        region: 'center',
	        xtype: 'tabpanel', // TabPanel itself has no title
	        activeTab: 0,      // First tab active by default
	        items: {
	            title: 'Default Tab',
	            html: 'The first tab\'s content. Others may be added dynamically'
	        }
	    }]
	});
});
```

运行如下：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4-1.png" >

# 2、窗口组件--Ext.window.Window： #

可以配置关闭、最大化等按钮，大部分情况下使用在弹窗的需求中。

```
Ext.onReady(function(){
	Ext.create('Ext.window.Window', {
	    title: 'Hello',
	    height: 200,
	    width: 400,
	    layout: 'fit',
//	    items: [],//这里可以添加其他Ext组件,一般情况会添加panel的子类
	    html:'World!' 
	}).show();
});
```

运行如下：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4-2.png" >

# 3、面板组件--Ext.panel.Panel： #

是Ext中所有panel的父类，一般在它里面会包含多个panel子类，完成页面布局。

Panel中常用的属性：
1. title:设置面板标题
2. items：正文部分的Ext控件
3. html：正文部分的文字
4. tbar：工具栏，可以放置在四个位置，分别为tbar,lbar,rbar,bbar
5. buttons：按钮区域

```
Ext.onReady(function(){
	var filterPanel = Ext.create('Ext.panel.Panel', {
	    bodyPadding: 5,
	    width: 300,
	    title: 'Filters',
	    items: [{ //items中可以存放其他Ext组件,这里只是示例
	        xtype: 'datefield',
	        fieldLabel: 'Start date'
	    }, {
	        xtype: 'datefield',
	        fieldLabel: 'End date'
	    }],
	    renderTo: Ext.getBody()
	});
});
```

运行如下：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4-3.png" >

# 4、树组件--Ext.tree.Panel： #

用于树的开发，一般会放置在父Panel中。

```
Ext.onReady(function(){
	//store用来存储数据，项目中一般数据来自数据库
	var store = Ext.create('Ext.data.TreeStore', {
	    root: {
	        expanded: true,
	        children: [
	            { text: "detention", leaf: true },
	            { text: "homework", expanded: true, children: [
	                { text: "book report", leaf: true },
	                { text: "algebra", leaf: true}
	            ] },
	            { text: "buy lottery tickets", leaf: true }
	        ]
	    }
	});
	
	Ext.create('Ext.tree.Panel', {
	    title: 'Simple Tree',
	    width: 200,
	    height: 300,
	    store: store, //tree中的数据来自store
	    rootVisible: false,
	    renderTo: Ext.getBody()
	});
});
```

运行如下：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4-4.png" >

自定义数的实现
```
Ext.onReady(function(){
	/*
	 * 自定义树的实现
	 */
	//自定义类myApp.Territory，继承自Ext.data.TreeModel
	Ext.define('myApp.Territory', {
	    extend: 'Ext.data.TreeModel',
	    fields: [{
	        name: 'text',
	        mapping: 'name'
	    }]
	});
	Ext.define('myApp.Country', {
	    extend: 'Ext.data.TreeModel',
	    fields: [{
	        name: 'text',
	        mapping: 'name'
	    }]
	});
	Ext.define('myApp.City', {
	    extend: 'Ext.data.TreeModel',
	    fields: [{
	        name: 'text',
	        mapping: 'name'
	    }]
	});
	Ext.create('Ext.tree.Panel', {
	    renderTo: Ext.getBody(),
	    height: 200,
	    width: 400,
	    title: 'Sales Areas - using typeProperty',
	    rootVisible: false,
	    store: {
	        // Child types use namespace of store's model by default
	        model: 'myApp.Territory',
	        proxy: {
	            type: 'memory',
	            reader: {
	                typeProperty: 'mtype'
	            }
	        },
	        root: {
	            children: [{
	                name: 'Europe, ME, Africa',
	                mtype: 'Territory',
	                children: [{
	                    name: 'UK of GB & NI',
	                    mtype: 'Country',
	                    children: [{
	                        name: 'London',
	                        mtype: 'City',
	                        leaf: true
	                    }]
	                }]
	            }, {
	                name: 'North America',
	                mtype: 'Territory',
	                children: [{
	                    name: 'USA',
	                    mtype: 'Country',
	                    children: [{
	                        name: 'Redwood City',
	                        mtype: 'City',
	                        leaf: true
	                    }]
	                }]
	            }]
	        }
	    }
	});
});
```

运行如下：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4-5.png" >


# 5、表单组件--Ext.form.Panel： #

用于表单开发，在表单上可以添加更多的组件组成完成的表单，完成后的表单与JSP的表单结构相类似。

```
Ext.onReady(function(){
	Ext.create('Ext.form.Panel', {
	    title: 'Simple Form',
	    bodyPadding: 5,
	    width: 350,

	    // from的submmit方法会以ajax的方式请求该url
	    url: 'ajax-url.do',

	    // anchor表示自动填充高度和宽度
	    layout: 'anchor',
	    defaults: {
	        anchor: '100%'
	    },
	    defaultType: 'textfield', //默认组件类型
	    items: [{ //items中组件不写类型的话，会使用默认类型defaultType
	        fieldLabel: 'First Name',
	        name: 'first',
	        allowBlank: false //是否可以为空，false表示非空
	    },{
	        fieldLabel: 'Last Name',
	        name: 'last',
	        allowBlank: false
	    }],
	
	    // Reset and Submit buttons
	    buttons: [{
	        text: 'Reset',
	        handler: function() {
	            this.up('form').getForm().reset();//重置所以组件的值
	        }
	    }, {
	        text: 'Submit',
	        formBind: true, //当所有非空组件都录入数据之后，submit才可用
	        disabled: true,
	        handler: function() {
	            var form = this.up('form').getForm();
	            if (form.isValid()) {
	                form.submit({
	                    success: function(form, action) {
	                       Ext.Msg.alert('Success', action.result.msg);
	                    },
	                    failure: function(form, action) {
	                        Ext.Msg.alert('Failed', action.result.msg);
	                    }
	                });
	            }
	        }
	    }],
	    renderTo: Ext.getBody()
	});
});
```

运行如下：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4-6.png" >

# 6、表格组件--Ext.grid.Panel： #

通常用来展示表格类的数据。

```
Ext.onReady(function(){
	//store中存储列表中要展示的数据
	Ext.create('Ext.data.Store', {
	    storeId:'simpsonsStore',
	    fields:['name', 'email', 'phone'],
	    data:{'items':[
	        { 'name': 'Lisa',  "email":"lisa@simpsons.com",  "phone":"555-111-1224"  },
	        { 'name': 'Bart',  "email":"bart@simpsons.com",  "phone":"555-222-1234" },
	        { 'name': 'Homer', "email":"homer@simpsons.com",  "phone":"555-222-1244"  },
	        { 'name': 'Marge', "email":"marge@simpsons.com", "phone":"555-222-1254"  }
	    ]},
	    proxy: {
	        type: 'memory',
	        reader: {
	            type: 'json',
	            rootProperty: 'items'
	        }
	    }
	});
	
	//列表
	Ext.create('Ext.grid.Panel', {
	    title: 'Simpsons',
	    //数据来源
	    store: Ext.data.StoreManager.lookup('simpsonsStore'),
	    //定义列表中要显示的列，这里的dataIndex要和store中的name保持一致，这里的text是表头，也可以使用header
	    columns: [ 
	        { text: 'Name',  dataIndex: 'name' },
	        { text: 'Email', dataIndex: 'email', flex: 1 },
	        { text: 'Phone', dataIndex: 'phone' }
	    ],
	    height: 200,
	    width: 400,
	    renderTo: Ext.getBody()
	});
});
```

运行如下：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4-7.png" >

可编辑列表配置方法：

（1）columns配置中增加editor:{xtype: 'textfield'}

```
{text: 'Last Name',  dataIndex:'lastname',editor:{xtype: 'textfield'},width:50},
```

（2）添加plugins属性：
```
plugins: {
    ptype: 'cellediting',
    clicksToEdit: 1
}
```


# 7、选项面板--Ext.tab.Panel： #

一般用来显现标签页

```
Ext.onReady(function(){
	/*
	 * 官方API中有很多例子，可以自己学习
	 */
	Ext.create('Ext.tab.Panel', {
	    width: 300,
	    height: 200,
	    activeTab: 0,
	    //这里定义了两个tab页，可以每个tab中的items中添加其他组件.
	    items: [
	        {
	            title: 'Tab 1',
	            bodyPadding: 10,
	            html : 'A simple tab'
	        },
	        {
	            title: 'Tab 2',
	            html : 'Another one'
	        }
	    ],
	    renderTo : Ext.getBody()
	});
});
```

运行如下：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4-8.png" >

