---
title: （转）Go语言高效的五个特性（一）：变量的处理和存储
date: 2017-06-07 18:14:36
tags: Go
categories: Go
---

我最近受邀在Gocon会议上做了一个演讲。Gocon是一个非常棒的，每半年一次在日本东京举行的Go会议。Gocon 2014是完全由社区举办的一整天活动。它包括了培训以及一个下午的演讲。演讲的主题主要围绕在Go语言在线上环境中的应用。
以下是我的演讲稿。原始的演讲稿强调慢而清楚的演讲，所以我做了略微的修改使得它更具可读性。

这里我要感谢Bill Kennedy，Minux Ma特别是Josh Bleecher Snyder。Josh为准备这次演讲给予了很多的帮助。

<!--more-->
---

下午好，我的名字叫David。我很高兴今天能够参加Gocon会议。我两年前就打算要参加这个会议，非常感谢会议组织者给我这个演讲的机会。我想让我的演讲以一个问题开始。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%80%EF%BC%8901.jpg)

为什么大家选择使用Go语言？

如果大家正打算学习Go语言，或者在产品里使用Go语言，他们对这个问题会有各种各样的答案。但有3个答案被提及的次数最多。这三个答案是：

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%80%EF%BC%8902.jpg)

1. 并发：Go语言对并发编程有很好的支持。这对许多使用单线程脚本语言（例如Nodejs，Ruby或者是Python）的程序员来说是非常有吸引力的。对C++或者Java的程序员来说，因为这些语言里线程的使用开销比较大，也是有吸引力的。
2. 便捷的部署：Go编译出来的程序可以被很简单地部署出去。这一点我们已经从很多Go语言的使用者这里得到认可。
3. 性能：我相信人们使用Go语言最重要的原因就是因为它很快。

我今天就来讨论下对Go语言性能有所帮助的5个特性。我还将和你们分享Go语言实现这些特性的细节。
 
# 变量的处理和存储

我要讨论的第一个特性就是Go语言是如何高效地处理和存储变量的。这里有一个Go语言变量的例子。编译以后，变量gocon 占了正好4个字节的内存。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%80%EF%BC%8904.jpg)

我们来和其他语言做个比较

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%80%EF%BC%8905.jpg)

由于Python在变量表示上的额外损耗，它存储同样的值需要6倍的内存。这些额外的开销被Python用来记录类型信息，引用计数（reference counting）等等。

我们再来看另外一个例子：

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%80%EF%BC%8906.jpg)

和Go语言相似，Java的int 类型也使用4个字节的存储空间。但是要在如List 或者Map 这样的集合里存储int 的话，编译器必须把它转换成Integer 对象。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%80%EF%BC%8907.jpg)

所以Java里的整数类型更多时候如上图所示。它需要占用16到24个字节的内存。

为什么刚才所说的很重要？现在的计算机内存很便宜而且容量也很大，为什么这点额外的开销值得关注呢？

下面这张图显示了CPU主频和内存带宽速度的比较。你可以注意到CPU主频速度和内存带宽的速度之间的差距正在一直变大。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%80%EF%BC%8908.jpg)

上图两条曲线之间的差距正是CPU花费了多少时间在等待内存数据。从60年代后期开始，CPU的设计师们已经认识到了这个问题。他们的解决方法是在CPU和主内存之间添加了缓存。缓存本质上就是一块面积更小，但是更快的内存。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%80%EF%BC%8909.jpg)

下面图中定义的是一个Location 类型，用来存储某个三维空间里物体的坐标。它是用Go语言写的，所以每个这样的Location 结构正好占用24个字节的存储空间。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%80%EF%BC%8910.jpg)

我们可以用这个类型来构建一个包含1000个location的数组，它正好占用24000字节的内存。在这个数组里，这些Location 结构是在内存中连续分布的，而不是1000个指向随机存储的Location 结构的指针。这非常重要，因为所有这1000个Location 结构在缓存里是连续存储的，并且他们占用的空间非常紧凑。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E4%BD%BFGo%E8%AF%AD%E8%A8%80%E9%AB%98%E6%95%88%E7%9A%84%E4%BA%94%E4%B8%AA%E7%89%B9%E6%80%A7%EF%BC%88%E4%B8%80%EF%BC%8911.jpg)

- Go语言让你定义非常紧凑的数据结构，避免了无谓的指针跳转。
- 紧凑的数据结构能够使缓存更加有效。
- 高效的缓存最终给我们带来了更高的效率。


> 英文原文：https://dave.cheney.net/2014/06/07/five-things-that-make-go-fast

> 本文转自：http://xiecode.cn/post/cn_01_five_things_that_make_go_fast_1/