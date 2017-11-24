---
title: Go第三方包管理工具govendor介绍
date: 2017-05-03 16:34:19
tags: Go
categories: Go
---

注意：使用govendor的前提是：Go 1.5开始支持govendor，如果使用1.5版本的话要设置`set GO15VENDOREXPERIMENT=1`，如果1.5以上版本就不需要这个设置。

golang对外部依赖包没有一个很好的方式，所有的依赖包都放置在GOPATH下，如果多个项目依赖同一个包但是不同版本的话，就会有引用问题，这种情况就会很麻烦，像在Java项目中，某个项目所有依赖的jar包都放在项目内部，不同项目各自使用自己的jar包，不会有多个项目引用一个包的情况，也就不会发生冲突。govendor就是在Golang项目中解决这个问题的。

项目地址：
[kardianos/govendor·GitHub](https://github.com/kardianos/govendor)

<!--more-->

# 1.安装：

    go get -u github.com/kardianos/govendor

下载完成后，执行`govendor`查看：

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/Go%E7%AC%AC%E4%B8%89%E6%96%B9%E5%8C%85%E7%AE%A1%E7%90%86%E5%B7%A5%E5%85%B7govendor%E4%BB%8B%E7%BB%8D01.png)


# 2. 使用方法：

进入项目根目录，执行`govendor init`，会在跟目录下生成一个vendor文件夹。该文件夹用来存放govendor管理的第三方包，其中vendor.json用来记录依赖的版本等信息。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/Go%E7%AC%AC%E4%B8%89%E6%96%B9%E5%8C%85%E7%AE%A1%E7%90%86%E5%B7%A5%E5%85%B7govendor%E4%BB%8B%E7%BB%8D02.png)

如果该项目已经引用了GOPATH里的第三方包，可以执行`govendor add +external`，该命令可以将该项目依赖的包从GOPATH移动到govendor目录下。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/Go%E7%AC%AC%E4%B8%89%E6%96%B9%E5%8C%85%E7%AE%A1%E7%90%86%E5%B7%A5%E5%85%B7govendor%E4%BB%8B%E7%BB%8D03.png)

如果项目需要新引入一个第三方包，可以直接执行`govendor get ***package`，该命令可以直接将第三方包下载至govendor目录内。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/Go%E7%AC%AC%E4%B8%89%E6%96%B9%E5%8C%85%E7%AE%A1%E7%90%86%E5%B7%A5%E5%85%B7govendor%E4%BB%8B%E7%BB%8D04.png)

如果需要删除一个govendor中依赖，可以执行`govendor remove ***package`。


更详细的内容可以查看官方文档。
