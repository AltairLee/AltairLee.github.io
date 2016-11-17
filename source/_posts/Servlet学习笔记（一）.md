---
title: Servlet学习笔记（一）
date: 2016-04-28 11:53:46
tags: Servlet
categories: Java
---
# 1、Servlet基础

## 1.1、什么是Servlet？

sun公司提出的一种用户拓展web服务器功能的组件。所谓组件，指的是符合某种规范，并且提供了部分功能的软件模块。

## 1.2、什么是Servlet容器？

<!-- more -->

容器是一种程序，提供组件的运行环境并且管理组件的生命周期。组件必须依赖于相应的容器才能运行，但并不依赖于特定的容器（只要组件和容器符合相同的规范即可）。

## 1.3、如何开发一个Servlet？

* 写一个java类，实现Servlet接口或者继承HttpServlet抽象类。
* 编译
* 打包

```
	appname(应用名)
		|-- WEB-INF
			|-- classes(class文件)
			|-- lib(可选，放置jar包)
			|-- web.xml(描述文件)
```

* 部署：将第三步生成的整个文件夹拷贝靠容器特定的文件夹下面。
* 运行：启动容器，在浏览器地址栏输入：http://ip:port/appname/servlet-url

## 1.4、什么是http协议？（了解）

它是由w3c指定的一种网络通信协议，它定义了浏览器与web服务器之间数据
传输的方式及数据的格式。

它的特点的“一次请求，一次连接”

## 1.5、请求数据包和响应数据包的结构？（了解）
1. 请求数据包：由浏览器发送给服务器
请求行：请求方式、请求资源路径、协议的类型和版本。
若干消息头：一般的键值对，用来发送一些外围属性。
实体内容：只有当请求方式是post时，浏览器才会将请求参数放在实体内容里面，如果是get方式，会将参数放在URL中。
2. 响应数据包

# 2、servlet核心
## 2.1、get请求与post请求
1. 哪些是get请求：
（1）直接在浏览器地址栏输入地址。
（2）点击链接
（3）表单默认的提交方式（没有设置method="post"）

2. get请求的特点：
请求参数都会放在请求资源路径里面，因为请求行的大小是有限制的，所以get方式不适合发送大量的请求参数给服务器。请求参数会显示在地址栏，不安全。

3. 哪些的post请求：
当设置表单的method="post" 时。

4. post请求的特点：
请求参数会放在请求数据包的实体内容中，从理论上讲请求参数的大小没有限制。post方式适合发送大量的请求参数给服务器。请求参数不会显示在浏览器地址栏，相对安全（此时数据并没有加密）。

## 2.2、表单处理

1. 如何获取表单中的参数值
String request.getParameter(String paraName); 如果paraName不正确，返回null。
String[] request.getParameterValues(String  paraName);用来获取多个参数值。

2. 如何获取中文参数避免乱码
保证表单所在的页面按照我们设定的编码格式来打开。
在服务器端，使用request.setCharacterEncoding(String code)来设定解码格式。

## 2.3、转发与重定向

1. 什么是重定向？
服务器向浏览器发送一个状态码302及一个消息头location（location的值是一个地址，称为重定向地址），浏览器会立即向重定向地址发送请求。

2. 如何重定向？
```
response.sendRedirect(String url);
```
3. 重定向需要注意的问题：
（1）重定向之前，不要调用out.close()，out.flush()
（2）重定向之前，服务器会先将response中缓存的数据清空。

4. 重定向的特点：
（1）重定向的地址是任意的。
（2）重定向之后，浏览器的地址栏会发生改变，变成了重定向地址。

5. 什么是转发？
一个web组件（servlet/jsp）将未完成的处理通过容器转交给另外一个web组件继续完成。最常见的转发是一个servlet获取数据后，转发给一个jsp，由这个jsp依据数据生成相应的界面。

6. 如何转发？
```java
request.serAttribute(String name , Object obj);
RequestDispatcher rd = request.getRequestDispatcher(String url);
rd.forward(requeset , response);
```
7. 转发需要注意的问题：
（1）转发之前，不能够调用out.close,out.flush方法。
（2）转发之前，容器会将response缓存的数据清空。

8. 转发的特点：
（1）转发的地址必须的同一个应用内部的某个组件。
（2）转发之后，浏览器地址栏的地址不变。
（3）转发所涉及的各个组件共享同一个request和response对象。

9. 转发与重定向的区别：
（1）相同点：一个web组件在执行过程中，再去调用另外一个web组件。
（2）不同点：转发的地址必须的同一个应用内部的某个组件，而重定向是任意的。

转发之后，浏览器地址栏地址不变，而重定向，地址会变成重定向的地址。转发可以共享request，而重定向不可以。request和response对象的生存时间是一次请求与相应期间，完成之后，request和response会立即被销毁。

## 2.4、servlet的生命周期

1. 生命周期的含义：
servlet容器创建servlet对象、分配其资源、调用其方法处理请求以及销毁其实例的整个过程。

2. 声明周期的四个阶段：
**第一阶段：实例化：**
容器创建servlet对象的时机：
（1）当请求到达容器时，容器依据请求资源路径，找不到对应的servlet对象时，容器会创建一个servlet对象。
（2）容器启动时，会对配置有<load-on-starup>参数的servlet进行实例化。<load-on-starup>参数值必须是>=0的整数，值越小，优先级越高（先被创建）。
**第二阶段：初始化：**
容器会调用servlet对象的init方法。
`public void init(ServletConfig config) throws ServletException
{
	// init实现
}`
容器在调用init方法之前，会先创建一个符合ServletConfig接口要求的对象，然后将该对象作为参数传给init方法。
ServletConfig对象初始化分为两步：
（1）在web.xml文件当中配置：
`<init-param>
	<para-name>company</para-name>
	<para-value>tarena</param-value>
</init-param>`
（2）使用String ServletConfig.getinitParameter("company");
如果要实现自己的初始化逻辑，只需要override init()方法，初始化方法只会执行一次。
**第三阶段：就绪：**
可以接受容器的调用，处理请求，容器会调用service方法，然后根据请求方式调用doGet或者doPost方法。(实现service方法与实现doGet和doPost方法本质上是一样的)。
**第四阶段：销毁：**
将对象从容起中删除。容器会在删除servlet对象之前，会调用destroy方法，该方法只会调用一次。

3. 相关的几个接口与类

（1）servlet接口：
```
init(ServletConfig config);
service(ServletRequest req , ServletResponse res);
destroy();
```
（2）GenericServlet抽象类：实现Servlet接口中的部分方法—>init(),destroy()。

（3）HttpServlet抽象类：继承了GenericServlet抽象类，实现了service方法。该方法会依据请求类型调用对应的doGet,doPost方法。HttpServlet提供了doGet,doPost方法的实现，但是，都是抛出一个异常，需要开发人员去override。

## 2.5、servlet线程安全问题
1. 线程安全问题产生的原因？
（1）在默认情况下，某个servlet在容器内部只会有一个实例。
（2）当容器受到请求以后，会启动一个线程来处理请求。
如果有多个线程同时访问某个servlet实例，并且修改该servlet实例属性，就有可能发生线程安全问题。

2. 解决方法：
（1）加锁：可以使用synchronized对整个service方法或者对有线程安全问题的代码块加锁。建议尽量使用synchronized。对代码块加锁。
（2）让servelet实现了SingleThreadModel接口。容器会创建多个servlet实例，即，一个线程分配一个servlet实例。不推荐，占用过多内存。

# 3、状态管理

## 3.1、什么是状态管理?
将浏览器与web服务器之间多次交互所涉及的数据保存下来。(将状态保存在客户端或者保存在服务器端)。

## 3.2、cookie技术

1. 什么是cookie?
浏览器在访问服务器时，服务器会将少量的数据（大约4k）以set-cookie消息
头的方式发送给浏览器，浏览器会将这些数据保存下来，当浏览器再次访问服务器时，会将之前保存的这些数据以cookie消息头的方式发送给服务器。

2. 如何创建一个cookie?
（1）创建一个cookie对象：
`Cookie c = new Cookie(String name , String value);`
（2）response.addCookie(c);

3. 如何查询cookie?
Cookie[] request.getCookies();
注意：request.getCookies方法有可能返回null。

4. 获取cookie中数据
`String cookie.getName();`
`String cookie.getValues();`

5. cookie的生存时间：
`cookie.setMaxAge(int seconds);//单位是秒`
**注意：**
当second>0时，浏览器会将cookie保存在硬盘上，当超过指定的时间，浏览器会删除这个cookie。
当second<0时，（缺省值）浏览器会将cookie保存在浏览器内存中，当浏览器关闭，cookie会被删除。
当second=0时，删除cookie

6. 删除一个cookie：
比如要删除一个名为”company“的cookie
`Cookie c = new Cookie("company","");`
`c.setMaxAge(0);`
`response.addCookie(c);`

7. 编码问题：
cookie只能保存ascii字符串，如果出现非ascii字符，需要将其转换成ascii字符的表示形式，可以使用：
`String URLEncoder.encode(String str , String code);`
`String URLDecode.decode(String str , String code);`
//创建cookie
`Cookie c = new Cookie("username",URLEncoder.encode("小飞虾","utf-8"));`
//读取cookie属性
`out.println(cookie.getName()+""+URLDecoder.decode(cookie.getValue(),"utf-8"));`
	
8. cookie的路径问题：
浏览器在访问服务器的时候，并不会将所有的cookie全部发送给服务器，而是比较服务器地址与cookie的地址是否匹配，只有符合要求的cookie才会发送给服务器。默认情况下，cookie的路径等于添加该cookie的组件的地址。
比如：/web07/jsp01/addCookie.jsp添加了一个cookie,则该cookie的路径就是 "/web07/jsp01"。
如果要访问服务器：
/web07/findCookie1.jsp     不发送cookie
/web07/jsp01/findCookie2.jsp  发送cookie
/web07/jsp01/jsp02/findCookie3.jsp  发送cookie
可以通过调用cookie.setPath(String path)方法修改cookie的路径，一般将其更改为应用的路径:cookie.setPath("/appname");
因此：如果要添加一个cookie的步骤：
```java
Cookie cookie = new Cookie("username",URLEncode.encode("张三","utf-8"));
cookie.setMaxAge(1000);
cookie.setPath("/web07");
response.addCookie(c);
```

9. cookie的缺点：
（1）cookie可以被用户禁止。
（2）cookie不安全。
（3）cookie能够保存的数据大小有限制，只能保存少量的数据（4k）
（4）cookie的个数也有限制，大约300个
（5）cookie只能保存字符串。

## 3.3、session技术

1. 什么是session?
是一种将状态保存在服务器端的状态管理技术。当浏览器访问服务器时，服务器会创建一个对象（称之为session对象，它拥有一个唯一的sessionId），接下来，服务器会将sessioId发送给浏览器（默认情况下，服务器会使用cookie机制来发送sessionId）浏览器会将sessionId保存下来，当浏览器再次访问服务器时，会将sessionId发送给服务器，服务器根据sessionId找到之前创建好的session对象。

2. 如何获得一个session对象？
（1）HttpSession s1 = request.getSession(boolean flag);
当flag=true时：
服务器检查请求当中是否含有sessionId,如果没有，则创建一个session对象;如果有，会依据sessionId查找对应的session对象，如果找到了，则返回,如果找不到（session已超时等）则会创建一个新的session对象。
当flag=false时：
服务器会检查请求当中是否含有sessionId，如果没有，则返回null;如果有，则会依据sessionId查找对应的session对象，如果找到了，则返回，如果找不到，则返回null。
（2）HttpSession s2 = request.getSession();
等价于request.getSession(true);

3. session的几个常用方法：
```java
	String session.getId();
	session.setAttirbute(String name,Object obj);
	Object session.getAttribute(String name)
	session.removeAttribute(String name)
```
4. session的超时
容器会将空闲时间过长的session对象从内存里删除掉，大部分服务器缺省时间是30分钟，可以修改服务器的缺省超时时间限制：
比如：tomcat可以修改/conf/web.xml文件
`<session-config><session-timeout>30</session-timeout></session-config>`
修改完成以后，需要重新启动服务器。
也可以只修改某个应用的web.xml。
另外，也可以调用session.setMaxInactiveInterval(int seconds); 设置某个session的生存时间。

5. 删除session
session.invalidate()可以直接删除session。

6. 当用户禁止cookie以后，如何继续使用session?(了解)
（1）解决方法：可以使用url重写机制。url重写指的是,在访问某个组件时，不直接使用其地址，而是使用服务器生成的一个包含sessionId的地址。
（2）如何进行url重写?
链接地址、表单提交地址，使用response.encodeURL(String url)处理
重定向地址，使用response.encodeRedirectURL(String url)处理

7. session的优缺点：
跟cookie相比，session相对来讲会更安全，保存的数据大小从理论上没有限制、保存的数据类型更丰富。session是一种服务器端状态管理技术，会将所有的状态保存在服务器端，所以，服务器压力会更大（服务器可以将session中的数据临时保存到数据库或者硬盘上）。有些时候，会使用session和cookie一起来解决比较复杂的状态管理问题。
