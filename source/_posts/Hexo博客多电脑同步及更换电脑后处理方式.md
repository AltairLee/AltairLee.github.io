---
title: Hexo博客多电脑同步及更换电脑后处理方式
date: 2016-11-21 23:29:05
tags: Hexo
categories: Hexo
---

前两天换了电脑，之前做hexo博客的时候就想过这事，只是当时没太在意。试了很多方法，还好弄好了，记录下来免得以后再用到。

参考了知乎上关于不同电脑写同一个博客的问题，试验了好几次，终于成功了。一定要保存好源文件哦，否则哭都找不到地方。

<!-- more -->

由于弄了好几次，把自己的git仓库弄的乱七八糟，我决定重新建个仓库，于是将旧仓库改名作为备份，新建一个与原来仓库同名的仓库，这样可以免去很多设置，是最简单的方法。

（下面操作的前提是你已经装了git哦，还不熟悉git操作的同学，先学习下git吧*^__^* ，这可是一项基本技能哦!）

新建仓库后，只有一个master分支，我们在本地新建一个Hexo分支用来存储的们的源文件。空的分支是不能够提交的，随便新建一个文件然后提交，你的分支就在git上了。然后在git setting中将Hexo设置为默认分支。

现在我们的仓库里拥有两个基本上空的分支：
* master：部署之后的文件，由git进行维护。
* Hexo：源文件，由我们自己维护，用于备份。

接下来我们将备份源文件复制到git的目录下，只需要复制以下目录哦：
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/%E8%A6%81%E5%A4%8D%E5%88%B6%E7%9A%84%E6%96%87%E4%BB%B6%E7%9B%AE%E5%BD%95.png)

复制完成后，在根目录下右键Git Bash Here执行以下几个命令：

	npm install -g hexo-cli
	npm install
	npm install hexo -server --save
	npm install hexo-deployer-git --save

耐心等待它执行完成，完成之后再依次执行以下命令：

	hexo clean
	hexo g
	hexo s

然后在浏览器访问http://localhost:4000 ，看看你的能在本地访问了吗，可以访问基本上就没问题了。（这里需要注意，4000端口有可能被占用，如何修改，请参照我的另一篇博客中的方法：[在win7中一步一步安装Hexo搭建个人博客](http://www.lzblog.cn/2016/04/06/%E5%9C%A8win7%E4%B8%AD%E4%B8%80%E6%AD%A5%E4%B8%80%E6%AD%A5%E5%AE%89%E8%A3%85Hexo%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2/ "在win7中一步一步安装Hexo搭建个人博客") 。

执行完以上操作之后，我们就可以先将Hexo分支下的文件提交到git上做为备份存储了。由于文件很多，git对批量文件的提交支持不是太好，我们可以使用GitHub For Windows来批量处理，如何安装这个软件呢，参照我的另一篇博客：[利用OneClickDownloader安装GitHub Desktop For Windows](http://www.lzblog.cn/2016/11/04/%E5%88%A9%E7%94%A8OneClickDownloader%E5%AE%89%E8%A3%85GitHub-Desktop-For-Windows/ "利用OneClickDownloader安装GitHub Desktop For Windows") 。当然也可以在命令行去提交，只不过我看着不爽，又恰好安装的这个软件。

提交完成之后，在我们git远程仓库里，Hexo分支已经有我们的源文件了，master分支还是空的。

我们需要在本地执行`hexo d`，完成后，git远程仓库的master分支就有了git自动部署的，你的源文件编译之后的文件了，现在去访问你的博客地址吧，看看是不是能访问了！

需要注意的一点：每次写博客之后，都要提交到Hexo分支上，这样增加电脑或者更换电脑后才能更快速的重新搭建。

以上操作就是我重新搭建博客的过程。如果再换电脑是不是还要这样呢？当然不是了，下面就说一下更换电脑应该怎么做呢？

其实如果你真正理解上边每一步操作的含义的话，你自己也能够想到该如何去做。

在新电脑我们为我们的博客创建一个目录：BlogNew。在该目录下右键执行GitBashHere。然后克隆你远程仓库的文件：`git clone https://github.com/xxx/xxx.github.io.git`。

克隆完成后，执行`cd xxx.github.io`，进入你的博客根目录。

然后依次执行以下命令：

	npm install -g hexo-cli
	npm install
	npm install hexo -server --save
	npm install hexo-deployer-git --save

这样一个新的本地博客就安装完成了哦。

按照你日常更新博客的方法试一下吧！

写在最后：不同电脑操作同一个博客的时候，执行`hexo d`有时会花费较多的时间，尤其是初次部署，耐心等待deploy完成就好了。

如果有什么问题可以随时联系我哦，联系方法见本博客**[关于我](http://www.lzblog.cn/about/)**中。




