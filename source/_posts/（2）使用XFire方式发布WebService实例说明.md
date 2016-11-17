---
title: （2）使用XFire方式发布WebService实例说明
date: 2016-04-13 11:21:38
tags: 
- WebService
- XFire
categories: WebService
---
# 1、导入所需jar包 #
相对来讲，使用XFire发布webService是一种比较简单的方式。

首先，访问地址( http://xfire.codehaus.org/Download )，下载所需的jar包。当然你也可以在其他地方下载。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-20.png)
<!-- more -->

新建web项目webServiceXfire，向系统中添加之前下载的文件所包含的jar包。其中包括xfire-all-1.2.6.jar及lib文件夹中所包含的jar文件。
 
![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-21.png)

# 2、接口实现代码 #

新建接口类：

```java
package com.sdjxd;
/**
 * @description 简单接口
 * @author lizhen
 */
public interface SayHello {
	public void sayHello();
	public String sayHelloToSomeone(String name);
}
```

新建实现类：

```java
package com.sdjxd;
/**
 * @description 简单接口实现类
 * @author lizhen
 */
public class SayHelloImpl implements SayHello{
	public void sayHello() {
		System.out.println("Hello WebService");
	}
	public String sayHelloToSomeone(String name) {
		System.out.println("Hello " + name);
		return "Zhen";
	}
}
```

# 3、XFire在项目中的配置 #

在web.xml中增加XFire配置：

```xml
<!-- XFire配置 begin -->
<servlet>
    <servlet-name>XFireServlet</servlet-name>
    <servlet-class>
        org.codehaus.xfire.transport.http.XFireConfigurableServlet
    </servlet-class>
</servlet>
<servlet-mapping>
    <servlet-name>XFireServlet</servlet-name>
    <url-pattern>/servlet/XFireServlet/*</url-pattern>
</servlet-mapping>
<servlet-mapping>
    <servlet-name>XFireServlet</servlet-name>
    <url-pattern>/services/*</url-pattern>
</servlet-mapping>
<!-- XFire配置 end -->
```

在src目录下建文件夹：

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-22.png)

service.xml配置文件：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://xfire.codehaus.org/config/1.0">
<service>
    	<!-- Xfire发布webService名称 -->
    <name>XFireService</name>
    	<!-- 接口配置-->
<serviceClass>com.sdjxd.SayHello</serviceClass>
	<!-- 实现类配置 -->
    <implementationClass>com.sdjxd.SayHelloImpl</implementationClass>
</service>
</beans>
```

访问<http://127.0.0.1:8080/webServiceXfire/services>，可以看到发布的接口服务

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-23.png)

点击上图的链接wsdl可以看到配置文件

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-24.png)

# 4、客户端访问webService的方法 #

新建项目webServiceXfireClient作为客户端。导入所需的jar包，并编写客户端访问方法：

```java
package com.sdjxd;
import java.net.URL;
import org.codehaus.xfire.client.Client;
public class ComeToSayHi {
	public static String comeToSay() throws Exception{
		String str="";
		Client client = new Client(new URL("http://127.0.0.1:8080/webServiceXfire/services/XFireService?wsdl"));
		Object[] results = client.invoke("sayHelloToSomeone", new Object[] {"Li"});
		str = (String) results[0];
		return str;
	}
	public static void sayHi() throws Exception{
		String str="";
		Client client = new Client(new URL("http://127.0.0.1:8080/webServiceXfire/services/XFireService?wsdl"));
		client.invoke("sayHello", new Object[] {});
	}
	public static void main(String args[]) throws Exception {
		sayHi();
		String str = comeToSay();
		System.out.println(str);
	}
}
```

运行上述方法，可以看到控制台输出，表示接口调用成功。