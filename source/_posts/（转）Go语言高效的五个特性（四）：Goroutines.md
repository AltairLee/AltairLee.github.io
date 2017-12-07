---
title: （转）Go语言高效的五个特性（四）：Goroutines
date: 2017-06-23 19:12:23
tags: Go
categories: Go
---

# Goroutines

Go语言有goroutines。它们是Go语言里并发编程的基石。

首先，我们来了解goroutines产生的历史。在一开始，计算机只能跑一个进程。然后到了60年代，多进程或者说是分时的概念变得很流行。在一个分时系统里，操作系统必须不停地将CPU上运行的进程进行切换。这种切换必须要将当前的进程状态保存下来，并且将下一个进程的状态恢复到CPU上。这个过程叫**进程切换**（process switching）。

<!--more-->

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E5%9B%9B%EF%BC%8901.jpg)

进程切换主要有三大开销。首先内核需要把当前进程用到的所有寄存器内容保存下来，然后把下一个进程用到的寄存器内容恢复到CPU上。内核还需要将CPU上的虚拟内存地址到物理内存地址的映射清空，因为它们只对当前进程来说是有效的。最后，还有些额外的开销是操作系统的上下文切换（context switch），以及调度器对下一个使用CPU进程的选择。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E5%9B%9B%EF%BC%8902.jpg)

现代处理器里有大量的寄存器。我已经无法将它们都写在一页演讲幻灯片上。你应该大致有概念保存和恢复它们需要多少时间里。

进程切换可以在一个进程执行过程中的任何位置发生。操作系统需要保存所有这些寄存器，因为它不知道哪些寄存器是被用到的。于是就有了线程的概念。线程从概念上来说和进程是一样的，但是它们共享同一个内存寻址空间。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E5%9B%9B%EF%BC%8903.jpg)

因为线程共享了寻址空间，它们比进程更加轻量化。所以创建和切换线程更高效。

Goroutines把这个概念做了进一步延伸。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E5%9B%9B%EF%BC%8904.jpg)

Goroutines的调度是自发合作的（cooperatively），而不依赖于内核来管理它们的分时。Goroutines之间的切换只在一些事先定义好的位置发生。在这些位置上，会有一个对Go运行环境（runtime）里的调度器的函数调用。编译器知道哪些寄存器被使用到了并将它们保存下来。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E5%9B%9B%EF%BC%8905.jpg)

虽然goroutines的调度是自发合作的，但是调度是由运行环境完成的。Goroutines触发调度的位置包括：

- Channel的发送和接收操作（当这些操作发生阻塞时）。
- Go语句，但是并不保证新的goroutine会被立刻调度。
- 像文件和网络操作这样的阻塞系统调用（syscalls）。
- 在垃圾回收之后。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E5%9B%9B%EF%BC%8906.jpg)
 
上面这个例子显示了这些会发生调度的位置。

左边是一个ReadFile 函数。箭头表示线程。当它执行到os.Open 的时候，线程会被阻塞来等待文件操作。这时候调度器就会把右边的goroutine切换到这个线程上来。一直运行到读c chan 阻塞的时候，os.Open 的调用已经完成，所以调度器把线程切换回左边的file.Read 函数继续执行。然后它被阻塞在了文件的读写操作上。调度器把线程又切换回右边去运行刚才的channel操作。这个操作现在已经不被阻塞，但是现在又要被阻塞在channel发送上了。最后当文件读操完成的时候，线程切换回左边继续运行。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E5%9B%9B%EF%BC%8907.jpg)

上图显示了底层的runtime.Syscall 函数。os包里的其它函数都会用到它。当你的代码需要调用操作系统接口的时候，这个函数都会被调用。这里对entersyscall 的调用通知了Go的运行环境这个线程将要被阻塞。这样，当这个线程被阻塞的时候，运行环境会创建出一个新的线程来运行其它的goroutines。

这样的好处就是每个Go进程只需要少量的操作系统线程。Go的运行环境来负责将可运行的goroutine分配到空闲的操作系统线程上。

> 英文原文：https://dave.cheney.net/2014/06/07/five-things-that-make-go-fast
> 
> 本文转自：http://xiecode.cn/post/cn_01_five_things_that_make_go_fast_4/