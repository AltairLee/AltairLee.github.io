---
title: NexT主题优化，增加阅读量信息
date: 2016-04-10 12:07:46
tags: 
- Hexo
- NexT
- CLeanCloud
- 不蒜子

categories: Hexo
---
# 1、在博客首页和文章页面显示阅读次数

注册并登陆[LeanCloud](https://leancloud.cn/login.html)，点击右上角用户，选择`控制台`，然后新建应用：
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/LeanCloud2.png)
<!-- more -->
创建完成后，我们在控制台就可以看到刚刚创建的应用，在应用中创建一个名为`Counter`的class
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/LeanCloud3.png)

然后找到设置-->应用Key：
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/LeanCloud4.png)

复制appid和appkey到`主题配置文件`中的`leancloud_visitors`属性中，将enable修改为true：
```
leancloud_visitors:
  enable: true
  app_id: DSUpqwXpCRk0yaVH0umWiadJ-gzGzoHsz
  app_key: b5jihkHKg0hUcy7gQ4rJz6dD

```

最新版本的NexT主题已经集成了LeanCloud，所以，我们只需要把上边配置配好即可，重新预览系统，就可以看到阅读信息了：
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/LeanCloud5.png)

# 2、在网站底部，显示网站浏览次数和访客数量统计

网站的浏览次数，即pv；网站的访客数为uv。pv的计算方式是，单个用户连续点击n篇文章，记录n次访问量；uv的计算方式是，单个用户连续点击n篇文章，只记录1次访客数。你可以根据需要添加相应的统计功能。

找到`themes\next\layout\_partials\footer.swig`，将`busuanzi.js`的引用放到最前面
**安装busuanzi.js脚本**
```
<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>
<div class="copyright" >
```
同样是`themes\next\layout\_partials\footer.swig`，将以下代码，放到你希望显示的位置。

**pv:站点总访问量**
```
<span id="busuanzi_container_site_pv">
    本站总访问量<span id="busuanzi_value_site_pv"></span>次
</span>
```

**uv:访客数**
```
<span id="busuanzi_container_site_uv">
  本站访客数<span id="busuanzi_value_site_uv"></span>人次
</span>
```