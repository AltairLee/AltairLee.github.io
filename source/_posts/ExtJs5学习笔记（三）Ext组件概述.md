---
title: ExtJs5学习笔记（三）Ext组件概述
date: 2016-05-26 19:27:45
tags: ExtJs5
categories: ExtJs5
---

组件是Ext中非常重要的一个组成部分，也是在开发过程中会经常使用的东西，我在官网上并没有找到各个组件是如何分类的，所以我就按照自己的理解简单的分类介绍一下，具体每个组件的应用会在之后的文章介绍。

<!-- more -->

# 1、容器及布局类组件 #

实际应用过程中，界面的千变万化的，而各个页面的整体布局的构成，就是由以下组件完成的。

**viewport  --  Ext.container.Viewport：**视图组件，这个是Ext提供的一个页面布局，他分为上、下、左、右、中，五部分，我们可以在每一部分进行再开发。

**window  --  Ext.window.Window：**窗口组件，可以配置关闭、最大化等按钮，大部分情况下使用在弹窗的需求中。

**panel  --  Ext.panel.Panel：**面板组件，是Ext中所有panel的父类，一般在它里面会包含多个panel子类，完成页面布局。

**treepanel  --  Ext.tree.Panel：**树组件：用于树的开发，一般会放置在父Panel中。

**from  --  Ext.form.Panel：**表单组件：用于表单开发，在表单上可以添加更多的组件组成完成的表单，完成后的表单与JSP的表单结构相类似。

**grid  --  Ext.grid.Panel：**表格组件：通常用来展示表格类的数据。

**tabpanel  --  Ext.tab.Panel：**选项面板：一般用来显现标签页

# 2、常用组件： #

**button -- Ext.button.Button：**按钮

**progressbar -- Ext.ProgressBar：**进度条

**slider -- Ext.slider.Single：**滑动条

# 3、from包下的表单组件，一般使用在formpanel上 #

**checkbox -- Ext.form.field.Checkbox：**复选框

**checkboxgroup -- Ext.form.CheckboxGroup：**复选框组

**radio -- Ext.form.field.Radio：**单选

**radiogroup -- Ext.form.RadioGroup：**单选组

**combobox -- Ext.form.field.ComboBox：**组合框（下拉框）

**datefield -- Ext.form.field.Date：**日期

**displayfield -- Ext.form.field.Display：**文本显示

**filefield -- Ext.form.field.File：**文件选择

**hidden -- Ext.form.field.Hidden：**隐藏表单域

**numberfield -- Ext.form.field.Number：**数字

**spinnerfield -- Ext.form.field.Spinner：**微调字段

**textfield -- Ext.form.field.Text：**单行文本框

**textarea -- Ext.form.field.TextArea：**多行文本框

**timefield -- Ext.form.field.Time：**时间选择框

**fieldset -- Ext.form.FieldSet：**字段集

**label -- Ext.form.Label：**标签字段

**htmleditor -- Ext.form.field.HtmlEditor：**HTML编辑器

# 4、工具栏组件 #

**toolbar -- Ext.toolbar.Toolbar：**工具栏

**pagingtoolbar -- Ext.toolbar.Paging：**分页工具栏

**tbfill -- Ext.toolbar.Fill：**工具栏填充区

**tbitem -- Ext.toolbar.Item：**工具条项目

**tbspacer -- Ext.toolbar.Spacer：**工具栏分隔符

**tbseparator -- Ext.toolbar.Separator：**工具栏空白

**tbtext -- Ext.toolbar.TextItem：**工具栏文本项


# 5、按钮拓展 #

**cycle -- Ext.button.Cycle：**带下拉选项菜单的按钮

**splitbutton -- Ext.button.Split：**带下拉菜单的按钮

**segmentedbutton -- Ext.button.Segmented：**存储按钮

# 6、选择器组件 #

**colorpicker -- Ext.picker.Color：**颜色选择器

**datepicker -- Ext.picker.Date：**日期选择器

**timepicker -- Ext.picker.Time：**时间选择器

# 7、菜单组件 #

**menu -- Ext.menu.Menu：**菜单

**menucheckitem -- Ext.menu.CheckItem：**选项菜单项

**colormenu -- Ext.menu.ColorPicker：**颜色选择菜单

**datemenu -- Ext.menu.DatePicker：**日期选择菜单

**menuitem -- Ext.menu.Item：**文本菜单项

**menuseparator -- Ext.menu.Separator：**菜单分隔线