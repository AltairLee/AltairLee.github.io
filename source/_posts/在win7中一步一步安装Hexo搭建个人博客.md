---
title: 在win7中一步一步安装Hexo搭建个人博客
date: 2016-04-06 14:08:14
tags: Hexo
categories: Hexo
photo: http://7xsp5x.com2.z0.glb.clouddn.com/hexo.png
---
# 1、搭建前介绍：
hexo中文官网：<https://hexo.io/zh-cn/>。

<!-- more -->

Hexo 是一个快速、简洁且高效的静态博客框架。而且它支持Markdown语法，我们可以很方便的使用Markdown编辑器来书写博文。

# 2、搭建前准备：
1. 申请个人独立域名（可选）：
2. 申请GitHub账号：<https://github.com/>.
3. 安装Git：<https://git-scm.com/>。安装完成之后在Git Base中执行以下命令：
```
git --version
```
如果出现类似于以下提示，则表示安装成功
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/git.png)
4. 安装Node.js：<http://nodejs.org/>。安装完成后，同样在Git Base中执行以下命令：
```
npm -v
```
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/npm.png)

# 3、hexo的安装：
Node.js和Git安装完成后，就可以正式安装Hexo了。在电脑任意位置右键，点击`Git Base Here`使用下面的命令安装Hexo:
```
npm install -g hexo-cli
```

**注意：运行命令过程中，只要没有报错误（ERROR）就没有问题，警告（WARN）可以忽略**

在电脑上新建目录，用于存放博客的相关数据，比如c:\HexoBlog，然后进入该文件夹右键，点击`Git Base Here`，执行以下两个命令：
```
hexo init   # 初始化目录，会自动生成一些基础文件
npm install # 安装hexo必要的组件
```
`hexo init`命令执行成功后，看到类似一下提示就是成功了。
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/dajian1.png)

`npm install`命令执行，在hexo3.0之前还是有一些输出的，但是3.0之后，我执行的时候并没有输出，只输出了一些警告，但是事实证明是没有问题的。
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/dajian2.png)

执行完以上命令以后，可以看到HexoBlog文件夹中，创建了以下目录：

```
	.
	├── scaffolds/
	├── scripts/
	├── source/
	|   ├── _drafts
	|   └── _posts
	├── themes/
	├── _config.yml
	├── package.json
```

依次简单介绍一下各个目录：
* `scaffolds/`：模版文件。当你创建一篇新的文章时，hexo会依据模版文件进行创建。
* `scripts/`：放脚本的文件夹。
* `source/`：这个文件夹就是放文章的地方了，除了文章还有一些主要的资源，比如文章里的图片，文件等等东西。这个文件夹最好定期做一个备份，丢了它，整个站点就废了。
* `themes/`：主题文件夹。网上下载或者克隆的主题都存放在这。
* `package.json`：应用数据。从它可以看出hexo版本信息，以及它所默认或者说依赖的一些组件。
* `_config.yml`：站点配置文件。非常重要的配置文件，很多全局的配置都在里面。

到这里为止，我们就可以预览一下系统了。执行下面两个命令:
```
hexo generate  #生成静态文件，可以简写为：hexo g
hexo server    #启动本地服务进行测试，简写为：hexo s
```
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/dajian4.png)

如上图所示，系统默认会运行在 http://localhost:4000 

如果4000被占用的话，访问这个地址是没有反应的，我电脑的4000端口就是被福昕阅读器给占用了，所以我需要指定一个其他端口。

```
hexo server -p 4005
```

这个命令可以使系统运行在4005端口上，我们使用 http://localhost:4005 访问系统就可以了。

更彻底方便的一种方法就是去修改hexo默认的端口号：

Hexo 3.0之前的版本，端口号可能存放在`站点配置文件` `_config.yml`中，不过在3.0之后，端口号就在博客目录下`node_modules\hexo-server\index.js`里面了。

```
hexo.config.server = assign({
  port: 4005,
  log: false,
  ip: '0.0.0.0',
  compress: false,
  header: true
}, hexo.config.server);
```

下面就是hexo搭建出来的博客的默认界面：

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/dajian5.png)

# 4、站点配置文件_config.yml

**注意：配置文件中，所有键值的冒号后面留一个空格，如language: zh-Hans**
* Site配置
这部分需要根据自己的情况进行修改，如果实在不明白可以修改后预览看一下。
```
# Site
title: Hexo #站点名字，也就是html的title，会显示在浏览器标签上。
subtitle: #站点副标题，会显示在首页上，可以不填。
description: #站点描述，可以不填。
author: John Doe #作者
language: zh-Hans #语言
timezone: #站点时区，默认是电脑时间
```
* URL配置
这部分我只修改了url，其他的使用默认的。
```
# URL
url: http://yoursite.com  #站点网址
root: /  #站点根目录
permalink: :year/:month/:day/:title/ #文章的永久网址链接，指的什么意思？比如我一篇叫『love』的文章是在2012年1月1日写的，那么它对应的链接就是http://yoururl/2012/01/01/love/.
permalink_defaults:  #如果网址是次级目录，比如：http://example.com/blog，那么就要设置url为http://example.com/blog，并且root要设置为/blog/。
```
* 目录配置 
这部分一般情况下不需要更改，使用默认值即可。
```
source_dir: source #source目录，默认值为source
public_dir: public #public目录，静态网站生成的地方，默认值为public
tag_dir: tags #tag目录
archive_dir: archives #Archive目录
category_dir: categories #分类目录
code_dir: downloads/code #代码目录
i18n_dir: :lang # i18n目录
skip_render: #不想被渲染的路径
```
* 写作配置
这部分也基本不变，有需要的可以细看每个配置项的含义进行修改。
```
# Writing
new_post_name: :title.md # 新建文章默认文件名，默认值为 :title.md，比如你执行命令hexo new hello，就会默认在_post目录下创建一个hello.md的文件。
default_layout: post #默认布局
titlecase: false # Transform title into titlecase
external_link: true # Open external links in new tab
filename_case: 0
render_drafts: false #是否渲染_drafts目录下的文章，默认为false
post_asset_folder: #false 是否启用Asset Folder
relative_link: false
future: true #是否显示未来日期文章，默认为true
highlight:  #代码块设置
  enable: true
  line_number: true
  auto_detect: false
  tab_replace:

```
* 分类标签配置
```
# Category & Tag
default_category: uncategorized #默认分类，默认为无分类，当然你可以设置一个默认分类。
category_map: #分类，不明白其作用
tag_map: #标签，不明白其作用
```
* 日期时间格式配置
```
# Date / Time format
date_format: YYYY-MM-DD
time_format: HH:mm:ss
```
* 分页配置
```
# Pagination
per_page: 10 #分类页面，一页显示多少篇文章，0为不分页，默认值为10
pagination_dir: page #分页目录，默认值为page
```

* 主题配置
克隆或者下载新主题后，放在themes文件夹中，这里修改主题名。主题的克隆后面会讲解。
```
# Extensions
theme: landscape #主题名，在你的themes中有的主题
```
* 部署配置
这里会根据GitHub仓库修改，后边会有讲解
```
# Deployment
deploy:
  type:
```

# 5、修改主题：
Hexo一大特色就是可以自定义主题，而且网上可以找到很好好看的主题：

主题下载：<https://hexo.io/themes/>

这里给大家推荐两个：

yelee：<https://github.com/MOxFIVE/hexo-theme-yelee>

nexT:<https://github.com/iissnan/hexo-theme-next>

这两个是我比较喜欢的两个主题，nexT就是本博客所使用的主题。


克隆主题的方法，在博客的根目录下打开Git Bash：
```
git clone https://github.com/iissnan/hexo-theme-next.git themes/next
```
执行完成后，可以看到themes目录下多了一个next文件夹，这个就是主题nexT主题的存放位置。

我们还要讲`站点配置文件`中的`主题配置`修改为：

```
theme: next
```

依次执行以下命令，再次预览系统。

```
hexo clean
hexo g
hexo s
```
http://localhost:4001/2016/04/07/
博客样式就自动变更如下图：
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/nextnew.png)

这只是简单的引用了nexT主题，还要进行很多调整才能达到自己想要的效果。对于nexT主题的修改，大家可以参考我的另一篇文章：[Hexo站点、NexT主题修改全记录](http://www.lzblog.cn/2016/04/07/Hexo%E7%AB%99%E7%82%B9%E3%80%81NexT%E4%B8%BB%E9%A2%98%E4%BF%AE%E6%94%B9%E5%85%A8%E8%AE%B0%E5%BD%95/)。

# 6、将本地博客放到Github
## 6.1、创建 Github pages 

登录你的GitHub账号，点击网站右上角的加号，在下拉中点击`new repository`，新建一个资源仓库。
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/dajian10.png)

新建过程中`Repository name`，这里格式有个要求就是一定要按照格式：`username.github.io`，比如的的用户名是testuser，那么，这个地方就要填`testuser.github.io`。写完后，点击`Create repository`

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/dajian11.png)

到此，GitHub仓库就创建完了，这里仓库主要是用来存储我们的博客源文件，相当于免费的服务器。

## 6.2、SSH设置

创建好仓库，要在本地生成SSH密钥，方便电脑上的软件提交到GitHub上。

在 Git Bash 中，输入：ssh-keygen -t rsa -C "你的邮箱地址"，然后需要三次回车。第二次和第三次回车是让你输入密码，这个密码会在你提交项目时使用，如果为空的话提交项目时则不用输入。一般没有必要设置，反正我没设。

如果看到类似于下图的，则说明生成成功：

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/dajian12.png)

生成的密钥存放在C:\Users\你的计算机用户名.ssh 下，会生成两个文件：
* 私钥：id_rsa
* 公钥：id_rsa.pub
* 
如果生成的不是这样的文件，那删除掉这两个生成的，重新执行上面的命令，让它再一次生成。

用记事本打开 id_rsa.pub，复制文件中的所有内容。访问<https://github.com/settings/ssh>，在GitHub中添加本机的SSH Key。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/dajian13.png)

## 6.3、上传博客到GitHub

要讲本地博客同步到GitHub上，还要安装两个与部署相关的插件：
```
npm install hexo -server --save
npm install hexo-deployer-git --save
```
然后在本地博客绑定GitHub仓库，编辑`站点配置文件`的`deploy`属性，根据自己用户名去修改：
```
deploy:
  type: git
  repo: git@github.com:testuser/testuser.github.io.git
  branch: master
```

编辑完`站点配置文件`之后，要重新部署本地博客：
```
hexo clean
hexo g
hexo s
```
在本地启动，检查一下是否有问题，如果没有问题的话，就可以停掉服务，提交到GitHub上了。
```
hexo deploy #部署至GitHub，可以简写为hexo d
```

第一次执行`hexo d`，会有如下图所示的提示，输入`yes`即可。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/dajian14.png)

提交成功后，会有如下提示：

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/dajian15.png)

完成后，我们访问http://testuser.github.io ，就可以看到自己的博客了。


# 7、绑定个人域名
我们可以在万网或者DNSPOD注册域名，然后需要新建一个CNAME文件（文件名是CNAME，没有拓展名），把该文件放到博客根目录“HexoBlog\source”下。CNAME里的内容的你要绑定的域名，比如我绑定的域名:

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/CNAME.png)

然后上传至GitHub，打开你的资源仓库，点击upload files。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/upload.png)

完成后，就需要设置域名解析了，可以万网或者DNSPOD上设置，找到域名解析的地方，按照以下方式录入设置，注意记录值的最后有一个“.”：

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/jiexi1.png)

设置完成，等几分钟完成解析，就可以使用你自己的域名访问博客了。

# 8、发布第一篇博客：

在博客根目录下，打开Git Bash

```
$ hexo new "My first blog"
INFO  Created: C:\HexoBlog\source\_posts\My-first-blog.md
```
启动服务，访问http://localhost:4000/ ，可以看到已经生成了一篇新文章`"My first blog"`。

按Ctrl+C 停止Server，将这篇博客提交到GitHub中，需要执行以下几个命令：
```
hexo clean  	#清理缓存数据
hexo generate 	#生成静态文件，可以简写为：hexo g
hexo server	#启动本地服务进行测试，简写为：hexo s  
hexo deploy	#部署网站，上传至服务器，简写为：hexo d
```

# 9、常见命令

```
hexo new "postName" #新建文章
hexo new page "pageName" #新建页面
hexo clean #清理缓存数据
hexo generate == hexo g #生成静态页面至public目录
hexo server == hexo s #启动本地服务
hexo deploy == hexo d #将.deploy目录部署到GitHub
hexo help  # 查看帮助
hexo version  #查看Hexo的版本
```
