---
title: （转）Go语言高效的五个特性（三）：垃圾回收机制
date: 2017-06-09 19:31:16
tags: Go
categories: Go
---
# 垃圾回收机制（Garbage Collection)

Go语言因为强制的内存垃圾回收机制变得更加简单和安全。但这并不意味着垃圾回收机制把Go程序变慢了，或者说垃圾回收机制最终决定了你程序的速度。不可否认，在堆（heap）上分配内存是有代价的。每次垃圾回收机制触发都会消耗一定的CPU。除非内存都被释放了，这些开销是不可避免的。

但是还有另外一个地方我们可以用来分配内存。那就是栈（stack）。

<!--more-->

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%89%EF%BC%8901.jpg)

与C语言不同，Go语言不需要你选择一个变量是分配在堆上（通过malloc），还是栈上（通过将这个变量定义成函数内的局部变量）。Go语言实现了一个叫做**逃逸分析**（Escape Analysis）的优化技术。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%89%EF%BC%8902.jpg)

逃逸分析能够判断是否有任何对函数局部变量的引用在此函数之外也被用到了。如果没有引用在函数之外被用到，那么这个局部变量就可以安全地存储在栈上。在栈上存储的变量不需要特别的分配和释放操作。让我们来看看下面这个例子：

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%89%EF%BC%8903.jpg)

Sum 函数把1到100之间的数字相加并返回结果。我们通常不会这么来写这个函数，只是用它来展示逃逸分析算法。

因为numbers 变量只在Sum 函数里被引用，编译器会将这100整数存储在栈上而不是堆上。所以也就不需要去垃圾回收numbers 变量，它会在Sum 函数返回的时候自动被释放掉。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%89%EF%BC%8904.jpg)

上面显示的第二个例子也是为了阐述同样的问题而创造出来的。在CenterCursor 函数里，我们创建了一个新的Cursor 结构并且把它的指针保存在变量c 里。然后我们将变量c 传入Center() 函数。Center() 函数将Cursor 结构平移半个屏幕的距离。最后把Cursor 结构的X和Y的坐标打印出来。虽然变量c 是通过new 函数分配的，它不会被存储在堆上。这是因为变量c 的引用并没有在CenterCursor 函数之外被用到。

Go语言的优化在缺省设置下总是被打开的。你可以用-gcflags=-m 参数来查看编译器的逃逸分析和内联决定。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%89%EF%BC%8905.jpg)

逃逸分析是在编译时而不是运行的时候做的。无论垃圾回收机制多么高效，栈的分配总是比堆的分配要快。接下来，我还会讨论到栈。

> 英文原文：https://dave.cheney.net/2014/06/07/five-things-that-make-go-fast
> 
> 本文转自：http://xiecode.cn/post/cn_01_five_things_that_make_go_fast_3/

