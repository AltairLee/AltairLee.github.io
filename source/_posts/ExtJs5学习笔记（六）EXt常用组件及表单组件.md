---
title: ExtJs5学习笔记（六）EXt常用组件及表单组件
date: 2016-06-07 20:57:46
tags: ExtJs5
categories: ExtJs5
---

之前学了页面的布局组件，我们要往布局组件上添加各种小组件完成整个页面的构建，下面就来学习下Extjs中丰富的组件家族。

# 常用组件 #

<!-- more -->

## Button： ##

首先看一个例子，首先定义一个window对象，来存放button等组件：

```
	var window = Ext.create('Ext.window.Window', {
	    title: 'ExtJsWindow',
	    height: 400,
	    width: 500,
	    layout: {
		    type: 'vbox',
		    align: 'left'
		},
		constrain: true, //设置窗体拖动，不能移除浏览器边界
	    modal: true, //设置模态窗体，相当于遮住窗体后面的界面，使之不可编辑
	    plane: false, //
	    tbar: [button1,button2,button3,button4,button5],//这里是10个button对象，具体实现在后边，学习过程中可以一次添加button按钮
		bbar: [msg1,msg2,msg3,msg4,msg5]
	}).show();
```

Button属性相当简单，一般情况下都会在按钮上添加事件，我们就看一下事件的几种实现方式：

Button1:

```javascript
	/*
	 * Button常用属性及按钮事件实现的三种方式
	 */
	var button1 = Ext.create('Ext.Button', {
					id : 'button1',
					renderTo  : Ext.getBody(),
				    text: '事件实现1',
				    allowDepress: true,     //是否允许按钮被按下的状态
				    enableToggle: false,     //按钮在弹起和按下两种状态中切换,ture:单击切换，false：自动切换
				    handler: function () {
				        Ext.Msg.alert('提示', '第一个事件');
				    }
				});
```

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-16.png" >


Button2:

```
	var button2 = Ext.create("Ext.Button", {
					id: 'button2',
					renderTo  : Ext.getBody(),
				    text: "事件实现2",
				    listeners: { "click": function () {
				        Ext.Msg.alert("提示", "第二个事件");
				    }
				    },
				    scale: 'medium' //button的大小--'small'：16px high。'medium'： 24px high。'large'：32px high。
				});		
```
<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-17.png" >

Button3:

```
	var button3 = Ext.create('Ext.Button', {
					id : 'button3',
					renderTo  : Ext.getBody(),
				    text: '事件实现3',
				    scale: 'large'
				});
				
	button3.on('click', function () {
	    Ext.Msg.alert('提示', '第三个事件');
	});
```
<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-18.png" >

按钮图标和菜单按钮。

Button4:

```
	/*
	 * 带图标和菜单的按钮。
	 */
	var button4 = Ext.create('Ext.Button',{
		id: 'button4',
		text      : 'Menu button',
    	renderTo  : Ext.getBody(),
    	arrowAlign: 'right', //菜单标识箭头的位置
		iconCls: 'icon-thumbs-up', //图片，使用的是fontawesome，当然也可以自定义
		iconAlign: 'right', //图片的位置
		menu:{
			items: [{
				text:'Item 1',
				handler:function(){
					Ext.Msg.alert('提示','点我！Item 1');
				}
			},{
				text:'Item 2',
				handler:function(){
					Ext.Msg.alert('提示','点我！Item 2');
				}
			},{
				text:'Item 3',
				handler:function(){
					Ext.Msg.alert('提示','点我！Item 3');
				}
			}]
		}
	});
```
<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-19.png" >	

Button5:

```
	/*
	 * 菜单式按钮
	 */
	var button5 = Ext.create('Ext.button.Cycle', {
		id: 'button5',
		renderTo  : Ext.getBody(),
	    showText: true,
	    prependText: 'View as ',
	    menu: {
	        items: [{
	            text: 'text only',
	            iconCls: 'view-text',
	            checked: true
	        },{
	            text: 'HTML',
	            iconCls: 'view-html'
	        }]
	    },
	    changeHandler: function(cycleBtn, activeItem) {
	        Ext.Msg.alert('Change View', activeItem.text);
	    }
	});
```

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-20.png" >

## MessageBox： ##

MessageBox1:

```javascript
	/*
	 * MessageBox的alert方法：提示框
	 */
	var msg1 = Ext.create('Ext.Button', {
					id: 'Msg1',
					renderTo  : Ext.getBody(),
				    text: 'Msg1',
				    handler:function(){
				    	Ext.MessageBox.alert('提醒', '这是一个alert');
				    }
				});
```
<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-21.png" >

MessageBox2:

```
	/*
	 * Ext.MessageBox是Ext.Msg的简写
	 * Msg的confirm方法:确认框
	 */
	var msg2 = Ext.create('Ext.Button', {
					id: 'Msg2',
					renderTo  : Ext.getBody(),
				    text: 'Msg2',
				    handler:function(){
					    	Ext.Msg.confirm( '提醒', '查看点击的选项？', function(btn){
					    		console.log('你点击了'+btn);
					    	} )
				    }
				});
```

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-22.png" >

MessageBox3:

```
	/*
	 * Msg的prompt方法:输入并确认框
	 */
	var msg3 = Ext.create('Ext.Button', {
					id: 'Msg3',
					renderTo  : Ext.getBody(),
				    text: 'Msg3',
				    handler:function(){
				    	Ext.Msg.prompt('Name', 'Please enter your name:', function(btn, text){
						    if (btn == 'ok'){
						        console.log('你输入的名字是：'+text)
						    }else{
						    	console.log('你取消了操作')
						    }
						});
				    }
				});
```
<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-23.png" >

MessageBox4:

```
	/*
	 * Msg的show方法：
	 */			
	var msg4 = Ext.create('Ext.Button', {
					id: 'Msg4',
					renderTo  : Ext.getBody(),
				    text: 'Msg4',
				    handler:function(){
				    	Ext.Msg.show({
						    title:'Save Changes?',
						    message: 'You are closing a tab that has unsaved changes. Would you like to save your changes?',
						    buttons: Ext.Msg.YESNOCANCEL,//显示的按钮类型,详细请查看Ext.MessageBox的properties
						    icon: Ext.Msg.QUESTION,
						    fn: function(btn) {
						    	console.log('you pressed '+btn);
						    }
						});
				    }
				});
```

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-24.png" >

MessageBox5:

```
	/*
	 * Msg的show方法：
	 */	
	var msg5 = Ext.create('Ext.Button', {
					id: 'Msg5',
					renderTo  : Ext.getBody(),
				    text: 'Msg5',
				    handler:function(){
				    	Ext.Msg.show({
						    title: 'Address',
						    message: 'Please enter your address:',
						    width: 300,
						    buttons: Ext.Msg.YESNO, 
						    multiline: true, //多行文本输入框
						    animateTarget: 'button10', //动画效果，窗口从哪里弹出，值为id或者Element。
						    icon: Ext.window.MessageBox.INFO,
						    fn: function(btn){
						    	console.log('you pressed '+btn);
						    }
						});
				    }
				});
```

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-25.png" >

## LoadMask ##
LoadMask:
<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-26.png" >
```javascript
	/*
	 * 正在加载组件
	 */
	var myMask = new Ext.LoadMask({
	    msg    : 'Please wait...',
	    target : window
	});			
	myMask.show();	
	setTimeout(function () {
        myMask.hide();
        Ext.Msg.alert('提示', '加载完成！');
    }, 3000);
```

##  ToolTip ##

ToolTip例一：

将鼠标移动至msg1按钮，可以看到该提示自动弹出，移出后自动消失。

```
 	/*
     * 提示
     */
    var toolTip1 = Ext.create('Ext.tip.ToolTip', {
	    id : 'toolTip1',
	    target: 'Msg1',
	    html: '这是什么？',
	    trackMouse: true  //跟随鼠标移动
	    //closable: true, //带有关闭按钮的
	    //draggable: true //是否可拖动
	});
```

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-27.png" >

ToolTip例二：

提示有箭头，并指向来源：

```
    var toolTip2 = Ext.create('Ext.tip.ToolTip', {
	    id : 'toolTip2',
	    target: 'Msg2',
	    anchor: 'left',   //指定箭头的指向 top,buttom,left,right
	    width: 120,
	    anchorOffset: 10, //指定箭头的位置
	    html: '带箭头的提示，并指定方向'
	});
```
<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-28.png" >

ToolTip例三：

在js中加入此代码后，
```
Ext.QuickTips.init();
```

可以直接在组件中使用`tooltip`属性：

```
	/*
	 * QuickTips
	 */
	var quickTipsButton = Ext.create("Ext.Button", {
		id: 'quickTips',
	    text: 'quickTips',
	    tooltip: '提示信息'
	});
```

将该按钮添加至bbar，查看效果。

<img src="http://7xsp5x.com2.z0.glb.clouddn.com/extjs5-29.png" >

# 表单组件 #







displayfield文本显示

label标签字段

textarea多行文本框

textfield单行文本框

numberfield数字

spinnerfield微调字段

hidden隐藏表单域

checkbox复选框

checkboxgroup复选框组

radio单选

radiogroup单选组

combobox组合框（下拉框）

datefield日期

displayfield文本显示

filefield文件选择

timefield时间选择框

fieldset字段集

htmleditorHTML编辑器


