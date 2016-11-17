---
title: Struts2学习笔记（一）
date: 2016-04-29 08:42:04
tags: Struts2
categories: Struts2
---
# 1、Struts环境搭建
## 1.1、jar包的导入
一般开发所需的7个jar包：
commons-fileupload-1.2.1.jar
commons-io-1.3.2.jar
freemarker-2.3.16.jar
javassist-3.7.ga.jar
ognl-3.0.jar
struts2-core-2.2.1.jar
xwork-core-2.2.1.jar
<!-- more -->
## 1.2、配置web.xml和引入struts.xml
在web.xml中加入struts2的默认filter，过滤所有的请求：
```xml
<filter>
	<filter-name>struts2</filter-name>
	<filter-class>
	org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter
	</filter-class>
</filter>
<filter-mapping>
	<filter-name>struts2</filter-name>
	<url-pattern>/*</url-pattern>
</filter-mapping>
```
将struts.xml文件加入到src目录下，（src目录下的文件，经过编译后，所有非java拓展名的文件都会被放到classes目录下）。

## 1.3、配置DTD文件（代码提示功能）
在struts核心包中找到struts-2.0.dtd，放到某个本地位置，在eclipse中选择window-->preference-->输入xml-->XML Catalog-->add-->选择dtd文件，uri= http://struts.apache.org/dtds/struts-2.0.dtd。
<img src="http://7xsp5x.com2.z0.glb.clouddn.com/struts2-1-1.png" >
配置完成后在struts.xml文件中加入如下代码
```
<!DOCTYPE struts PUBLIC
    "-//Apache Software Foundation//DTD Struts Configuration 2.0//EN"
    "http://struts.apache.org/dtds/struts-2.0.dtd">
```