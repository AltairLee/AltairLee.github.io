---
title: Ubuntu和Windows搭建go环境
date: 2017-03-07 20:19:09
tags: Go
categories: Go
---
# 1.Ubuntu安装
## 1.1.安装包
使用wget下载go安装包

	wget https://storage.googleapis.com/golang/go1.9.linux-amd64.tar.gz

如果wget下载失败，可以使用百度云盘手动下载新版的离线包:

[https://pan.baidu.com/s/1pL0Ca4V](https://pan.baidu.com/s/1pL0Ca4V)

<!-- more -->

然后执行命令

	sudo tar -C /usr/local -xzf go1.9.linux-amd64.tar.gz

**注意**：不要使用apt-get安装go，版本太低

## 1.2.配置环境变量
在用户目录下创建go文件夹（也可以按照自己的喜好创建目录，环境变量中做相应的改变即可）

	cd ~ 
	mkdir go

编辑环境变量：

	vi ~/.profile 

添加以下内容到配置文件：

	export PATH=$PATH:/usr/local/go/bin 
	export GOROOT=/usr/local/go 
	export GOPATH=$HOME/go 
	export PATH=$PATH:$HOME/go/bin

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/go-env-Ubuntu%E5%92%8CWindows%E6%90%AD%E5%BB%BAgo%E7%8E%AF%E5%A2%8301.png)

重新载入配置文件：

	source ~/.profile

## 1.3 安装完成，检查go版本：

	go version

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/go-env-Ubuntu%E5%92%8CWindows%E6%90%AD%E5%BB%BAgo%E7%8E%AF%E5%A2%8302.png)

ok，go环境安装完成，接下来既可以进行go语言的开发了。

# 2.windows安装
## 2.1.go运行环境sdk下载安装：

官方地址：[https://golang.org/dl/](https://golang.org/dl/)

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/go-env-Ubuntu%E5%92%8CWindows%E6%90%AD%E5%BB%BAgo%E7%8E%AF%E5%A2%8303.png)

同样也可以使用百度云盘手动下载新版的离线包:

[https://pan.baidu.com/s/1pL0Ca4V](https://pan.baidu.com/s/1pL0Ca4V)

win下直接安装在默认位置C:\Go即可。

## 2.2.配置环境变量：
**（1）GOPATH**

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/go-env-Ubuntu%E5%92%8CWindows%E6%90%AD%E5%BB%BAgo%E7%8E%AF%E5%A2%8304.png)

**（2）GOROOT**

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/go-env-Ubuntu%E5%92%8CWindows%E6%90%AD%E5%BB%BAgo%E7%8E%AF%E5%A2%8305.png)

## 2.3.安装完成，简单测试

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/go-env-Ubuntu%E5%92%8CWindows%E6%90%AD%E5%BB%BAgo%E7%8E%AF%E5%A2%8306.png)

新建hello.go文件，编写如下代码：

```
	package main  
	import "fmt"  
	func main() {  
	    fmt.Printf("hello, world\n")  
	}
```
使用命令`go run`执行

	go run hello.go

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/go-env-Ubuntu%E5%92%8CWindows%E6%90%AD%E5%BB%BAgo%E7%8E%AF%E5%A2%8307.png)

到这里go的基本环境就算搭建完成了。

## 2.4.go的C语言调用：
如果你需要go调用C语言的代码，你还需要安装MinGW，下载安装程序，大约86K

	[https://sourceforge.net/projects/mingw/](https://sourceforge.net/projects/mingw/)

下载完成后，直接安装，

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/go-env-Ubuntu%E5%92%8CWindows%E6%90%AD%E5%BB%BAgo%E7%8E%AF%E5%A2%8308.png)

第二步，安装 mingw-developer-toolkit 和 mingw32-base

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/go-env-Ubuntu%E5%92%8CWindows%E6%90%AD%E5%BB%BAgo%E7%8E%AF%E5%A2%8309.png)

Apply

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/go-env-Ubuntu%E5%92%8CWindows%E6%90%AD%E5%BB%BAgo%E7%8E%AF%E5%A2%8310.png)

安装过程可能很慢，耐心等待。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/go-env-Ubuntu%E5%92%8CWindows%E6%90%AD%E5%BB%BAgo%E7%8E%AF%E5%A2%8311.png)

安装完成

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/go-env-Ubuntu%E5%92%8CWindows%E6%90%AD%E5%BB%BAgo%E7%8E%AF%E5%A2%8312.png)

配置MinGW安装路径下的bin目录到环境变量Path中，然后在命令行运行gcc -v，如下显示，说明安装成功。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/go-env-Ubuntu%E5%92%8CWindows%E6%90%AD%E5%BB%BAgo%E7%8E%AF%E5%A2%8313.png)







