---
title: '使用七牛云存储做图床，为hexo存储引用图片'
date: 2016-04-06 19:22:19
tags: 
- 七牛图床
- Hexo
categories: Hexo
photo: http://7xsp5x.com2.z0.glb.clouddn.com/%E4%B8%83%E7%89%9B%E4%BA%91%E5%AD%98%E5%82%A8.png
---
首先要注册七牛账号：<https://portal.qiniu.com/signup?code=3leo07ov0tsnm>。
<!--- more --->

注册完成后登陆，新建存储空间：
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/qiniu1.png)

为存储空间定义一个名字，保存即可：
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/qiniu2.png)

打开存储空间，选择内容管理，点击上传文件，上传你所需要用到的图片：
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/qiniu3.png)

上传完成后，在存储空间文件列表中点击某一文件的右侧按钮，可以看到如下图：
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/qiniu4.png)

这里的外链地址就是我们所需要的东西。

在浏览器中直接访问该地址，可以看到我们上传的图片：
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/qiniu6.png)

我们在文章中写入以下引用图片的代码，就可以在博客中引用改图片了：
```
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/test.png)
```
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/test.png)