---
title: （转）Go语言高效的五个特性（五）：Goroutine的栈管理
date: 2017-06-25 18:44:48
tags: Go
categories: Go
---
# Goroutine的栈管理

在上一篇文章里，我们已经讨论了goroutine减少了对上百个并发运行的线程的管理开销。这里我们要在讨论下goroutine的另外一个方面，它的栈管理。

下面是一个进程的内存布局图。这个图里我们关心的是堆和栈的位置。

<!--more-->

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%94%EF%BC%8901.jpg)

通常在进程的寻址空间里，堆是在内存的底部，从程序的可执行指令存储空间（text）开始向上衍生。栈则位于虚拟地址空间的顶部，并向下衍生。

如果堆和栈衍生后相互覆盖的话，那结果是灾难性的。操作系统通常会在堆和栈之间设置一块不可写的内存区域。如果堆和栈衍生到一起的话，程序就会退出。这块内存区域叫做保护页（guard page）。它限制了进程的栈的大小。这个限制通常在几M的量级。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%94%EF%BC%8902.jpg)

我们前面讲到过线程是共享寻址空间的。但是每个线程，它又必须要有它自己的栈。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%94%EF%BC%8903.jpg)

因为很难预测一个线程需要多大的栈空间，很多的内存空间都被预留给了线程的栈和保护页以期望预留的栈空间足够大，这样保护页不会被触及到。这样做的缺点就是随着程序里线程数的增加，可用的寻址空间也相应地减少了。

我们已经讨论过Go的运行环境会把大量的goroutine在少数的线程上调度。那么这些goroutine的栈是怎么管理的呢？

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%94%EF%BC%8904.jpg)

Go语言没有使用保护页机制。Go的编译器会在每个函数调用的时候插入一段代码来检查是否有足够的栈空间来运行被调用的函数。如果空间不足，Go的运行环境就会分配更多的栈空间。因为有了这个检查机制，一个goroutine的初始栈可以很小。这样Go程序员就可以把goroutine作为相对廉价的资源来使用。

下图显示了Go 1.2里是如何管理栈的。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%94%EF%BC%8905.jpg)

当G调用H的时候，没有足够的栈空间来让H运行，这时候Go运行环境就会从堆里分配一个新的栈内存块去让H运行。在H返回到G之前，新分配的内存块被释放回堆。这种管理栈的方法一般都工作得很好。但对有些代码，特别是递归调用，它会造成程序不停地分配和释放新的内存空间。举个例子，在一个程序里，函数G会在一个循环里调用很多次H函数。每次调用都会分配一块新的内存空间。这就是**热分裂问题**（hot split problem）

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%94%EF%BC%8906.jpg)

为了解决这个问题，Go 1.3采用了新的栈管理方法。

如果goroutine的栈太小了，它会去分配一块新的更大的栈，而不是分配和释法额外的内存空间。老的栈里的内容被复制到新的栈里，goroutine会在新的栈上继续执行。在第一次调用H函数之后，将会有足够大的栈空间，这样以后的栈空间大小检查都不会有问题了。这就解决了热分裂问题。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%94%EF%BC%8907.jpg)

变量，内联，逃逸分析，Goroutines，和栈的分块／复制管理就是今天我要讨论的5个特性。当然Go语言高效不仅仅是因为这5个特性。这就像大家有千奇百怪的理由来学习Go语言一样，这些理由也绝不止3个。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%BA%94%EF%BC%8908.jpg)

这些特性个个都很有效，他们之间还相互依赖。比如，如果没有了可衍生的栈，运行环境将多个goroutine复用到线程上面就不会很有效。内联在把多个小函数合并成大函数的时候也避免了栈大小的检查开销。逃逸分析用栈代替堆来存储局部变量，这样也减少来垃圾回收机制的压力。逃逸分析还提升了缓存的性能（cache locality）。没有可衍生的栈，逃逸分析又会对栈造成很大的压力。

> 英文原文：https://dave.cheney.net/2014/06/07/five-things-that-make-go-fast
> 
> 本文转自：http://xiecode.cn/post/cn_01_five_things_that_make_go_fast_5/