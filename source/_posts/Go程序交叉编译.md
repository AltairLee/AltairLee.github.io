---
title: Go程序交叉编译
date: 2017-04-03 20:23:38
tags: Go
categories: Go
---

Go支持交叉编译， 即在一个平台上生成另一个平台的可执行程序（不包含cgo相关的东东）。

命令如下（目标平台为64位Ubuntu系统）：

    SET CGO_ENABLED=0   #禁用cgo
    SET GOOS=linux      #目标平台的操作系统（darwin、freebsd、linux、windows）
    SET GOARCH=amd64    #目标平台的体系架构（386、amd64、arm）
    go build main.go    #执行编译

