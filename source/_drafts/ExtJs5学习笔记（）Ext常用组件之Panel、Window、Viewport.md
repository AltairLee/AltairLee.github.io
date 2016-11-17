---
title: ExtJs5学习笔记（四）Ext常用组件之Panel、Window、Viewport
date: 2016-05-17 20:06:15
tags: ExtJs5
categories: ExtJs5
---

这三个是Extjs中常用的容器类控件

# 1、Ext.Panel 面板控件 #

在panel面板中，常用的几部分包括：

1. title:设置面板标题
2. items：正文部分的Ext控件
3. html：正文部分的文字
4. tbar：工具栏，可以放置在四个位置，分别为tbar,lbar,rbar,bbar
5. buttons：按钮区域

<!-- more -->

```
Ext.onReady(function () {
	Ext.create('Ext.panel.Panel', {
	    title: 'Hello',
	    width: 500,
	    height: 400,
	    items:[
	    		{
		            xtype    : 'textfield',
		            name     : 'field1',
		            emptyText: 'enter search term'
	        	},Ext.create('Ext.button.Button',{text:"正文控件"})
	    	],
	    html: '<p>正文文本World!</p>',
	    tbar: [{	//tbar,lbar,rbar,bbar:分别设置上、左、右、下四个位置
	            	// xtype: 'button', // default for Toolbars
	            	text: '工具栏'
	        	},
	        	Ext.create('Ext.toolbar.Toolbar', { items: ["工具栏"] })
	         ],
	    buttons: [{
	    		xtype: 'button',
	            text: "按钮",
	            handler: function () {
	                Ext.Msg.alert("提示", "按钮区域");
	            },
	            id: "button1"
	        }
	    ],
	    renderTo: Ext.getBody()
	});
});
```

运行后，如下图：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4-1.png" >


# 2、Ext.window.Window 窗口控件 #

窗口控件Window与panel类似，但看上去更像一个窗口,具有最大化、最小化、打开关闭、拖动等效果，看下面实例：

```
Ext.onReady(function () {
    var window1 = Ext.create('Ext.window.Window', {
        applyTo: 'window1',
        layout: 'auto',       		//布局类型，Ext.enums.Layout，所有类型都在这个类里面，可自行查看     
        width: 500,
        height: 400,
        title: "窗口标题",
        maximizable: true,          //是否可以最大化
        minimizable: true,          //是否可以最小化
        closable: false,            //是否可以关闭
        modal: true,                //是否为模态窗口
        resizable: false,           //是否可以改变窗口大小
        closeAction: 'hide',    	//窗口关闭的方式：hide/close
        items: [{
            text: '按钮',
            xtype: "button"
        }, {
            xtype    : 'textfield',
            name     : 'field1',
            emptyText: 'enter search term'
    	}],
        buttons: [{
            text: '确定',
            disabled: true
        }, {
            text: '取消',
            handler: function () {
                window1.hide();
            }
        }]
    }).show();
});
```

运行后，如下图：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4-2.png" >

# 2、Ext.container.Viewport 布局控件 #

Viewport一般用于整个页面的布局，它利用border布局，将页面分成了上、下、左、右、中，五个区域。

```
Ext.onReady(function(){
	Ext.create('Ext.container.Viewport', {
	    layout: 'border',
	    items: [{
	        region: 'north',
	        html: '<h1 class="x-panel-header">Page Title</h1>',
	        border: false,
	        margin: '0 0 5 0'
	    }, {
	        region: 'west',
	        collapsible: true,
	        title: 'Navigation',
	        width: 150
	        // could use a TreePanel or AccordionLayout for navigational items
	    }, {
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

运行后，如下图：

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-4-2.png" >
