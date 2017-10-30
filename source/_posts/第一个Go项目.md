---
title: 第一个Go项目
date: 2017-03-13 19:43:01
tags: Go
categories: Go
---

# 准备工作
首先安装并配置好IDE工具，推荐使用Gogland，做的还是比较好的，也可以使用其他IDE，像LiteIDE等。
其实这里主要有两个配置，而且一般IDE会自动在系统环境变量中加载到这里这些配置：

GOROOT:

<!--more-->

![image](http://7xsp5x.com2.z0.glb.clouddn.com/first-go-%E7%AC%AC%E4%B8%80%E4%B8%AAgo%E9%A1%B9%E7%9B%AE01.png)

GOPATH:（这里配置了两个，因为我本地设置的两个gopath，默认只需要一个即可）

![image](http://7xsp5x.com2.z0.glb.clouddn.com/first-go-%E7%AC%AC%E4%B8%80%E4%B8%AAgo%E9%A1%B9%E7%9B%AE02.png)

# Ready GO！

开始第一个GO项目的编写：

File --> New --> Project：将项目名定义为：blockchain

![image](http://7xsp5x.com2.z0.glb.clouddn.com/first-go-%E7%AC%AC%E4%B8%80%E4%B8%AAgo%E9%A1%B9%E7%9B%AE03.png)

Go对项目文件夹有一个简单的约定，一般项目包含以下几个文件夹：

    blockchain
        src 
        bin (go build 生成的可执行文件)
        pkg (go install 生成的包文件，一般为.a后缀)

下面我们编写一个最著名的程序：Hello World!

在src下面创建一个main.go文件：


```
package main

import (
	"fmt"
)

func main() {
	fmt.Println("GoLang : Hello World!")
}
    
```

右键执行`RUN main.go`

![image](http://7xsp5x.com2.z0.glb.clouddn.com/first-go-%E7%AC%AC%E4%B8%80%E4%B8%AAgo%E9%A1%B9%E7%9B%AE04.png)

简单介绍一下main.go：

1. 首先声明了一个package main（每个项目都要有这个package，而且包内要有一个main方法），文件名最好使用main.go。

1. 然后导入了一个系统包`fmt`，这个包主要是用来打印log文本的包。

1. 最后声明一个main方法，调用`fmt`包中的`Println`方法打印输出。

我们稍微变化一下写法：

首先在src下新建一个hello包，然后创建一个hello.go的文件：

```
package hello

import "fmt"

func SayHello(name string) {
	fmt.Println("Hello World,", name)
}

```

然后修改一下main.go，使其调用hello.go的SayHello：

```
package main

import (
	"blockchain/src/hello"
)

func main() {
	var name string = "Go"
	hello.SayHello(name)
}
```

然后再次在main.go右键，运行`RUN main.go`

![image](http://7xsp5x.com2.z0.glb.clouddn.com/first-go-%E7%AC%AC%E4%B8%80%E4%B8%AAgo%E9%A1%B9%E7%9B%AE05.png)

简单介绍下：

1. 首先我们定义了一个名为`hello`的`package`，并创建一个名为`hello.go`的文件，但这里需要注意的是：**文件夹名**才是表示`package`名，该文件夹下所有文件都属于同一个`package`。我们虽然定义了一个`hello.go`的文件，打算其实这里的文件名是任意的，并无影响。

2. 然后我们在main.go里引入名`hello`的`package`，这里的引入方式是直接从项目名开始的，因为我并没有在`gopath`中配置该项目的地址，所以这里只能使用全路径导入包，不能使用项目`src`下的包名直接导入。（这也是个人比较推荐的一种导入方式以及多项目管理方式，后边会有文章比较这两种方式）

3. 然后我们声明一个变量`name`，注意声明方式。然后使用引入的`hello`包调用他自身的`SayHello`方法。这里要注意的是：`SayHello`方式首字母为大写，在Go中，并没有像public、private等访问控制修饰符，它通过首字符大小写来控制可见性的。大写开头的变量、函数、结构体等表示能被其他包访问，否则只能在包内访问。



The End!
