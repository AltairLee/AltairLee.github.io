---
title: （转）Go语言高效的五个特性（二）：函数调用不是免费的
date: 2017-06-08 18:23:53
tags: Go
categories: Go
---
# 函数调用不是免费的

一个函数调用有三个步骤:
1. 创建一个新的堆栈框（stack frame）并把调用者的详细信息记录下来。
2. 把任何会被被调用函数用到的寄存器内容保存到堆栈。
3. 计算被调用函数的地址，并执行跳转指令到那个新的地址。

<!--more-->

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%8C%EF%BC%8901.jpg)

因为函数调用是频繁操作，CPU的设计者花费了很多精力来优化这个过程，但他们不可能消除所有的开销。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%8C%EF%BC%8902.jpg)

根据被调用函数的功能，这个调用开销可能是可以忽略不计的，也可能是非常显著的。有一个降低调用开销的优化技术叫**内联**（inlining）。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%8C%EF%BC%8903.jpg)

Go语言编译器通过把被调用函数代码当作调用者代码的一部分来实现内联。内联也是有代价的。它会增加编译出来的二进制可执行文件的大小。只有在调用函数的开销占到被调用函数本身的工作量很大一部分的时候，内联才有意义。所以只有简单的函数才被考虑启用内联。调用函数的开销往往不占复杂函数的大头，所以他们也就不会被内联。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%8C%EF%BC%8904.jpg)

上面这个例子展示了函数Double 对util.Max 的调用。为了降低调用util.Max 的成本，编译器会把util.Max 内联到Double 函数里，产生如下内容：

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%8C%EF%BC%8905.jpg)

内联之后，util.Max 将不会被调用，但是Double 的行为并没有改变。内联并不是Go语言独有的。几乎所有编译的或者即时编译（JITed）的语言会提供这项优化。**那么Go语言里的内联是怎么工作的呢？**

Go语言的实现非常简单。当一个包（package）被编译的时候，任何适合内联的小函数都被标记并且按正常情况编译。然后将源代码和编译后的二进制同时保存下来。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%8C%EF%BC%8906.jpg)

上面的图片显示了util.a 的内容。源代码被做了稍微的改动以方便编译器的快速处理。当编译器编译Double 的时候，它会发现util.Max 是可以内联的并且util.Max 的源代码也存在。这时编译器会插入原函数的源代码，而不是插入一个util.Max 的调用。

保存源代码还使得其它优化成为可能。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%8C%EF%BC%8907.jpg)

比如上面这个例子，虽然Test 函数总是返回false ，Expensive 在执行它之前是无法知道的。但是当Test 被内联的时候，我们就得到了如下的代码：

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%8C%EF%BC%8908.jpg)

这样编译器就能知道那块代码是不会被执行到的。

这样不仅节省了调用Test 函数的开销，它还节省了编译任何不会被执行的代码。Go编译器能够自动在多个文件或者包（package）之间实现函数内联。如果某些代码调用了来自标准库的可内联函数，Go编译器同样可以将这些函数内联进来。


> 英文原文：https://dave.cheney.net/2014/06/07/five-things-that-make-go-fast
> 
> 本文转自：http://xiecode.cn/post/cn_01_five_things_that_make_go_fast_2/
 