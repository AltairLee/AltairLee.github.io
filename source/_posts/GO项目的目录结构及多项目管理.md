---
title: GO项目的目录结构及多项目管理
date: 2017-04-01 18:54:53
tags: Go
categories: Go
---
# 1.GOPATH

首先了解一下GOPATH，它指定了一些目录：包含除GOROOT之外的包含Go项目源码、第三方包、二进制文件等目录。go的很多命令行工具都会用到这个目录，而且这些go命令搜索目录的原则是从前往后（包括导入包），所以这个GOPATH推荐只配置一个目录。

# 2.Go项目目录结构
Go对项目的目录结构有统一的约定，在项目根目录下，
- src存储项目的源码
- bin存储go build命令生成的可执行文件
- pkg目录存储go install命令生成的包文件。

<!--more-->

如下：

    blockchain
        src 
        bin (go build 生成的可执行文件)
        pkg (go install 生成的包文件，一般为.a后缀)


# 3.Go多项目管理

其实较为麻烦的还是go的多项目管理，常用的有两种方式，但是也是各有利弊。

## 3.1.方式一：

为每个project都配置一个GOPATH，比如我现有在两个Go项目，分别是blockchain和blockchain02，那么我的GOPATH就成了：

    /home/lizhen/go/src/blockchain:/home/lizhen/go/src/blockchain02

缺点：使用go get命令下载的第三方包会全部保存在第一个gopath目录下。

## 3.2.方式二（推荐）：
只配置一个gopath，所有project都放在该目录下的src下。比如我的GOPATH为：

    /home/lizhen/go

这种情况下，各个项目build或者install生成的包文件都会存在该目录下的bin/pkg文件夹下。

该目录下有两个工程blockchain和blockchain02。目录分别是：/home/lizhen/go/src/blockchain和/home/lizhen/go/src/blockchain02。

这种方式，下载的第三方包会下载到gopath的src目录下，独立于项目之外，我们可以使用第三方包管理工具（如：govendor）将项目所需的包在自己项目中管理。


# 4.包导入

go导入包的查找顺序是按照GOPATH中配置环境变量的顺序查找的，所以，一般情况下我们都推荐导入包的时候，使用全路径导入 ，也就是包含项目名的方式，否则出现重名包的话，可能会出错。如blockchain项目：

    import (
	    "blockchain/src/hello"
    )

不推荐使用类似`./hello`的方式导入包。
