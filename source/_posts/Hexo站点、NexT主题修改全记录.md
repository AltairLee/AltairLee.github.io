---
title: Hexo站点、NexT主题修改全记录
date: 2016-04-07 09:46:55
tags: 
- NexT 
- Hexo
categories: Hexo
---

# NexT主题三种样式：

打开`主题配置文件`，找到`Schemes`属性，这三类就是NexT主题的三种样式，可以切换试一下

```
# Schemes
#scheme: Muse
#scheme: Mist
scheme: Pisces
```
<!-- more -->

# 菜单名字修改
打开`HexoBlog\themes\next\languages\zh-Hans.yml`，找到`menu`配置：
```
menu:
  home: 首页
  archives: 归档
  categories: 分类
  tags: 标签
  about: 关于
  search: 搜索
  commonweal: 公益404
```
如果引用的的其他语言的话，找到对应的文件修改即可。

# 菜单增加和删除
打开`主题配置文件`，找到`menu`配置：
```
menu:
  home: /
  #categories: /categories
  #about: /about
  archives: /archives
  tags: /tags
  #commonweal: /404.html
```
这里配置着显示的菜单，可以自行修改。

# 新建页面

新增菜单之后，点击主页的菜单是有问题的，会有类似于`Cannot GET /tags/`的提示，这个错误的原因是tags标签页没有配置，执行以下命令，创建一个标签页：

```
hexo new page tags
```

然后找到新建的page`HexoBlog\source\tags\index.md`，使用MarkdownPad或则文本编辑器打开，将`type`设置为`"tags"`：

```
---
title: tags
date: 2016-04-05 19:22:41
type: "tags"
comments: false
---
```

重启服务器，在点击tags标签，就可以看到标签页了，如果空，可以将默认的文章`hello world`的标签设置一下，就可以看到了。

同样的，如果要创建一个about页，执行`hexo new page about`，找到它对应的index.md，将`type`配置成`"about"`即可。about页面的内容需要自己在index中编辑。

# 增加公益404页面
在`HexoBlog\source\`文件夹下，创建404.html，其内容如下：
```
<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="content-type" content="text/html;charset=utf-8;"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="robots" content="all" />
  <meta name="robots" content="index,follow"/>
</head>
<body>

<script type="text/javascript" src="http://www.qq.com/404/search_children.js"
        charset="utf-8" homePageUrl="http://www.lzblog.cn"
        homePageName="回到我的主页">
</script>

</body>
</html>
```
# 添加RSS
在博客根目录，执行以下命令：
```
npm install hexo-generator-feed --save
```

然后在`主题配置文件`中，找到`rss`属性：
```
rss: /atom.xml
```

并添加属性：
```
feed:
  type: atom
  path: atom.xml
  limit: 20
  hub:
```
重启服务，可以看到博客中已经有了RSS标识，如果点击会提示`This XML file does not appear to have any style information associated with it. The document tree is shown below.`，还有以下XML配置，说明配置成功了。


# 评论插件（多说篇）

登录 [多说](http://duoshuo.com/) 在首页点击`我要安装`，创建过程中，在多说域名这一栏中填写的就是你的`duoshuo_shortname`，如下图：
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/duoshuo.png)

创建完成后，在`站点配置文件`中找到或者新增属性：
```
duoshuo_shortname: mytestblog
```

# 百度统计插件

登录 [百度统计](http://tongji.baidu.com/) ,找到网站中心，新增网站，填写自己网站的域名，完成后，找到代码获取页面。复制hm.js?后面的代码，这个代码就是你的百度统计脚本id：
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/baidu.png)

然后在`站点配置文件`中，找到或者新增属性baidu_analytics，值为你的百度统计脚本id：
```
baidu_analytics: 3*****************************f
```
# 最近访客插件（多说篇）

引用多说评论插件以后，直接在要显示访客登记的页面添加以下代码：
```
<div class="ds-recent-visitors" data-num-items="28" data-avatar-size="42" id="ds-recent-visitors"></div>
```
我是只在about页面显示最近访客，所以把上边代码复制到about页面的index.md中即可。
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/about.png)

访客的默认css样式是竖着的，可以自己修改。我是在网上找的别人的css，在多说后台管理-->设置-->基本设置-->自定义CSS，进行修改。

```
#ds-reset .ds-avatar img,
#ds-recent-visitors .ds-avatar img {
	width: 54px;
	height: 54px;     /*设置图像的长和宽，这里要根据自己的评论框情况更改*/
	border-radius: 27px;     /*设置图像圆角效果,在这里我直接设置了超过width/2的像素，即为圆形了*/
	-webkit-border-radius: 27px;     /*圆角效果：兼容webkit浏览器*/
	-moz-border-radius: 27px;
	box-shadow: inset 0 -1px 0 #3333sf;     /*设置图像阴影效果*/
	-webkit-box-shadow: inset 0 -1px 0 #3333sf;
	-webkit-transition: 0.4s;
	-webkit-transition: -webkit-transform 0.4s ease-out;
	transition: transform 0.4s ease-out;     /*变化时间设置为0.4秒(变化动作即为下面的图像旋转360读）*/
	-moz-transition: -moz-transform 0.4s ease-out;
}

#ds-reset .ds-avatar img:hover,
#ds-recent-visitors .ds-avatar img:hover {

	/*设置鼠标悬浮在头像时的CSS样式*/    box-shadow: 0 0 10px #fff;
	rgba(255, 255, 255, .6), inset 0 0 20px rgba(255, 255, 255, 1);
	-webkit-box-shadow: 0 0 10px #fff;
	rgba(255, 255, 255, .6), inset 0 0 20px rgba(255, 255, 255, 1);
	transform: rotateZ(360deg);     /*图像旋转360度*/
	-webkit-transform: rotateZ(360deg);
	-moz-transform: rotateZ(360deg);
}

#ds-thread #ds-reset .ds-textarea-wrapper textarea {
	background: url(http://ww4.sinaimg.cn/small/649a4735gw1et7gnhy5fej20zk0m8q3q.jpg) right no-repeat;
}

#ds-recent-visitors .ds-avatar {
	float: left
}
/*隐藏多说底部版权*/
#ds-thread #ds-reset .ds-powered-by {
	display: none;
}
```

效果如下图：
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/fangke.png)


# 阅读量显示（LeanCloud、不蒜子）

见：[NexT主题优化，增加阅读量信息](http://www.lzblog.cn/2016/04/12/NexT%E4%B8%BB%E9%A2%98%E4%BC%98%E5%8C%96%EF%BC%8C%E5%A2%9E%E5%8A%A0%E9%98%85%E8%AF%BB%E9%87%8F%E4%BF%A1%E6%81%AF/)

# hexo引用图片的图床（七牛云存储）

见：[使用七牛云存储做图床，为hexo存储引用图片](http://www.lzblog.cn/2016/04/06/%E4%BD%BF%E7%94%A8%E4%B8%83%E7%89%9B%E4%BA%91%E5%AD%98%E5%82%A8%E5%81%9A%E5%9B%BE%E5%BA%8A%EF%BC%8C%E4%B8%BAhexo%E5%AD%98%E5%82%A8%E5%BC%95%E7%94%A8%E5%9B%BE%E7%89%87/)

# 多标签设置

直接在文章Front-matter中按照以下格式设置：
```
tags:
    - 标签1
    - 标签2
    - 标签3
```

# 如何关闭新建页面的评论功能？

当集成了评论系统，如`多说`或者`Disqus`，所有新建的页面都将自动开启评论。若你不需要评论，请在页面的 Front-matter 里添加`comments`字段，并将值设置为`false`。如下所示：

```
title: All tags
date: 2015-12-16 17:05:24
type: "tags"
comments: false
---
```

# photo标签

在文章Front-matter引用图片，可以在首页显示该图片：
```
photo: http://phtoto.png
```

# 首行缩进

在主题下路径`next\source\css\main.styl`中最后添加如下代码：
```
p
  text-indent 2em
```

# 标签/分类数量统计不准确

- 删除站点目录下的 db.json 文件
- 在站点目录下执行命令 hexo clean
- 在站点目录下执行命令，重新生成 hexo generate

# 如何设置页面显示的文章篇数？

1. 使用 npm install --save 命令来安装需要的 Hexo 插件。
```
npm install --save hexo-generator-index
npm install --save hexo-generator-archive
npm install --save hexo-generator-tag
```
2. 等待扩展全部安装完成后，在`站点配置文章`中，设定如下选项：
```
index_generator:  # 主页显示多少篇文章
  per_page: 5

archive_generator:  # 归档页显示多少篇文章
  per_page: 20
  yearly: true  
  monthly: true

tag_generator:  # 标签页显示多少篇文章
  per_page: 10
```
per_page即文章的数量。

# 头像图片引用

在`站点配置文件`中添加属性`avatar`，如：
```
avatar: /images/avatar.png
```

# 乱码问题

编辑的所有文件，都是保存的编码都是UTF-8，所以编辑配置文件时，不要使用记事本，使用可以选择保存格式的文本编辑器，如UE、EditPlus等。

# 如何卸载Hexo？

3.0.0版本执行$ npm uninstall hexo-cli -g，之前版本执行$ npm uninstall hexo -g。

# 如何安装旧版本Hexo？

先卸载当前版本，以2.8.3为例，执行npm install hexo@2.8.3 -g，再初始化并安装依赖和插件。




