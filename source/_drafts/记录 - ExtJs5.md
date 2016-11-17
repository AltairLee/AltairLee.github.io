---
title: 记录
tags: ExtJs5
---



# Ext.util.Format的格式化（单例类） #
使用时不需要实例化，直接用就可以。

# Ext学习笔记（）之布局（layout） #
容器布局：
border布局也称边界布局
accordion布局：accordion布局也称手风琴布局
Card布局__类似向导
fit 布局
Anchor布局
Absolute布局
Column布局__列布局

表单布局:
layout：form，column
行布局，列布局
常用的布局方式的效果

# Ext学习笔记（六）EXt常用组件及表单组件 #

# Ext学习笔记（七）EXt其他组件 #

# Ext学习笔记（八）EXt学习阶段性总结 #

# Ext学习笔记（）之页面构造 #
panel并不是最常用的，最常用的他的子类：Ext.tree.Panel（树）、Ext.form.Panel（表单）、Ext.grid.Panel（列表）、Ext.tab.Panel（标签页）。

最常用的页面布局方式：

弹窗页面，最外层使用的是Ext.window.Window，在window中添加panel的子类完成整个页面。
如下图：

单纯页面，最外层使用的是Ext.panel.Panel，在panel中添加panel的子类完成整个页面。
如下图：

当然也可以使用Ext自己的布局空间Ext.container.Viewport，然后在各个位置添加需要的panel子类完成页面。
如下图：

当然也可以直接在panel或者window中添加组件，并不是那么的严格。查看API可得知window是panel的子类，所以所有panel可以完成的功能，理论上来讲window都可以完成，但实际上我们并不会那样做，让它们各司其职才是正确的做法。



