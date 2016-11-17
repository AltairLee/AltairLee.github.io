---
title: Markdown编辑语法说明
date: 2016-04-06 11:21:24
tags: 
- markdown
- Hexo
categories: Hexo
---
# 1. 标题设置：
在标题前添加#，#的个数标识这标题的阶数。
```
# 一级标题
## 二级标题
### 三级标题
#### 四级标题
##### 五级标题
###### 六级标题
```
注意：#与标题之间有空格
<!-- more -->
# 2. 引用
在某一段落第一行加上>，表示引用的文字
```
>This is a blockquote with two paragraphs...
```
>This is a blockquote with two paragraphs. Lorem ipsum dolor sit amet,
consectetuer adipiscing elit. Aliquam hendrerit mi posuere lectus.
Vestibulum enim wisi, viverra nec, fringilla in, laoreet vitae, risus.

# 3. 列表：
```
* 哈哈
* 呵呵
* 嘿嘿
1. 啊
2. 哎
```

* 哈哈
* 呵呵
* 嘿嘿
1. 啊
2. 哎

# 4. 分割线
```
---
***
```
---
***

# 5. 插入链接：
连接文字使用[]来标记。
```
[Git官网](https://git-scm.com/)或者<https://git-scm.com/>
```
[Git官网](https://git-scm.com/)或者<https://git-scm.com/>

# 6. 强调
```
*强调*  (示例：斜体)
**加重强调**  (示例：粗体)
***特别强调***  (示例：粗斜体)
```
*强调*  (示例：斜体)
**加重强调**  (示例：粗体)
***特别强调***  (示例：粗斜体)

# 7. 代码：
使用三个反引号`(esc下边的键)将代码包裹起来
```java
	int num = 12;
```
```javascript
  var ihubo = {
    nickName  : "草依山",
    site : "http://jser.me"
  }
```

# 8. 代码块区

	或者对每一行首直接在使用tab键，自动变为代码区。

# 9. 插入本地图片：
```
普通的<img>标签：<img src="/_posts\Markdown编辑语法说明/test.png" style ="height:300px;">
```
<img src="/_posts\Markdown编辑语法说明/test.png" style ="height: 50px;">
```
![Alt text](/_posts\Markdown编辑语法说明/test.png "Optional title")
```
![Alt text](/_posts\Markdown编辑语法说明/test.png "Optional title")

# 10. 引用在线图片：
见另一篇博文：[使用七牛云存储做图床，为hexo存储引用图片](http://www.lzblog.cn/2016/04/06/%E4%BD%BF%E7%94%A8%E4%B8%83%E7%89%9B%E4%BA%91%E5%AD%98%E5%82%A8%E5%81%9A%E5%9B%BE%E5%BA%8A%EF%BC%8C%E4%B8%BAhexo%E5%AD%98%E5%82%A8%E5%BC%95%E7%94%A8%E5%9B%BE%E7%89%87/)

# 11. 加底色
```
相见欢`李煜`
无言独上西楼。
月如钩。
寂寞梧桐深院`锁清秋`。
剪不断，`理还乱`，是离愁。
别是一般滋味在心头。
```
相见欢`李煜`
无言独上西楼。
月如钩。
寂寞梧桐深院`锁清秋`。
剪不断，`理还乱`，是离愁。
别是一般滋味在心头。

# 12. table的写法
| 链接 | 结果 | 原因 |
|:-----|:---:|----------:|
|文本内容| **`是`** |同协议同域名同端口|
|文本内容| **`是`** |同协议同域名同端口|
|文本内容| **`是`** |同协议同域名同端口|


# 13. 更多
更多详细内容请移步：<http://wowubuntu.com/markdown/index.html>

# 14.hexo提供
文章中使用<!-- more -->进行截断，前边的会被当做摘要显示在主页，后边的内容，隐藏在`阅读全文`中。

