---
title: Go常用命令行工具
date: 2017-04-20 21:39:31
tags: Go
categories: Go
---

执行`go`命令查看所有的命令行工具。

<!--more-->

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/go%E5%B8%B8%E7%94%A8%E5%91%BD%E4%BB%A4%E8%A1%8C%E5%B7%A5%E5%85%B701.png)

# 1.go build 

主要用来编译代码，测试代码是否有编译错误。
1. 如果执行命令的目录不包含main包，则不会产生任何文件。
2. 如果执行命令的目录包含main包，则执行`go build`之后会在当前目录生成一个可执行文件`main`，也可以指定生成文件名称及路径`go build -o **/blockchain`。
3. 如果目录下有多个文件，可以执行文件编译`go build main_01.go`。
4. `go build`会忽略目录下以`_`或`.`开头的go文件。

# 2.go install 

该命令分为两步操作：

    第一步：生成结果文件,可执行文件或者.a包
    第二步：将编译的记过移动到`$GOPATH/bin`或者`$GOPATH/pkg`

# 3.go get 

主要用来下载第三方包的工具。它可以理解为以下两步操作:

    第一步：下载源码包
    第二步：执行go install
    
目前支持的代码仓库有GitHub、Google Code、BitBucket、和Launchpad。所以想要获取这些源码，需要安装相应的源码控制工具。

# 4.go clean 
用来移除当前源码包和关联源码包里面编译生成的文件。这些文件包括

    _obj/            旧的object目录，由Makefiles遗留
    _test/           旧的test目录，由Makefiles遗留
    _testmain.go     旧的gotest文件，由Makefiles遗留
    test.out         旧的test记录，由Makefiles遗留
    build.out        旧的test记录，由Makefiles遗留
    *.[568ao]        object文件，由Makefiles遗留

    DIR(.exe)        由go build产生
    DIR.test(.exe)   由go test -c产生
    MAINFILE(.exe)   由go build MAINFILE.go产生
    *.so             由 SWIG 产生
    
参数介绍

    -i 清除关联的安装的包和可运行文件，也就是通过go install安装的文件
    -n 把需要执行的清除命令打印出来，但是不执行，这样就可以很容易的知道底层是如何运行的
    -r 循环的清除在import中引入的包
    -x 打印出来执行的详细命令，其实就是-n打印的执行版本


# 5.go run 
编译并运行Go程序，指定包含main方法的文件执行`go run main.go`。

# 6.go env 
查看当前go的环境变量

