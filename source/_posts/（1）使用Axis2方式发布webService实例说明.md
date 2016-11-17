---
title: （1）使用Axis2方式发布webService实例说明
date: 2016-04-13 11:09:24
tags: 
- WebService
- Axis2
categories: WebService
---
# 1、简单的pojo方式： #

不需要写配置文件，直接把class文件拷贝到axis2的WEB-INF目录下的poji文件夹下即可。但其局限性表现在，实现类不能有包声明，这在实际开发过程中使用较少，这里不做说明。
<!-- more -->
# 2、打jar包的方式： #

将接口实现放到axis2中。首先下载所需要的jar包，解压axis2-1.5.4-war.zip，将里面的axis2.war直接拷贝到tomcat里webapps中，启动tomcat后，会自动生成axis2文件夹。在浏览器中访问 <http://127.0.0.1:8080/axis2/> ，能看到以下界面说明axis2启动成功。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-1.png)

点击Services链接，可以看到available services只有Version，这个是Axis2自带的接口。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-2.png)

然后开始新建一个我们自己的webService。在myEclipse中新建项目：webServiceTest。

新建类com.sdjxd.SayHelloImpl.java

```java
package com.sdjxd;
/**
 * @description 简单接口方法实现
 * @author lizhen
 */
public class SayHelloImpl {
	public void sayHello() {
		System.out.println("Hello WebService");
	}
	public void sayHelloToSomeOne(String name) {
		System.out.println("Hello " + name);
	} 
}
```

在项目的src目录下建立文件夹META-INF，在META-INF中创建services.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!-- webService发布名称,命名空间 -->
<service name="myService" targetNamespace="http://ws.apache.org/ax2">
<!-- 更改schemaNamespace，也可使用默认值，客户端调用时会使用 -->
<schema schemaNamespace="http://sdjxd.com.cn"/>
<!-- webService描述 -->
<description>Web Service实例一</description>
<!-- webService的实现类 -->
<parameter name="ServiceClass">com.sdjxd.SayHelloImpl</parameter>
<messageReceivers>
<!-- 配置消息接收器，Axis2会自动选择 -->
<messageReceiver mep="http://www.w3.org/2004/08/wsdl/in-out"
	class="org.apache.axis2.rpc.receivers.RPCMessageReceiver" />
<messageReceiver mep="http://www.w3.org/2004/08/wsdl/in-only"
	class="org.apache.axis2.rpc.receivers.RPCInOnlyMessageReceiver"/>
</messageReceivers>
</service>
```

在控制台上找到当前项目的src目录。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-3.png)

输入打jar包的命令：jar cvf webServiceTest.aar. 最后面是空格+小数点。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-4.png)

执行完成后，目录下会出现webServiceTest.aar文件。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-5.png)

然后将webServiceTest.aar文件拷贝到D:\tomcat-6.0\webapps\axis2\WEB-INF\services中

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-6.png)

重新启动tomcat，访问<http://127.0.0.1:8080/axis2/> ，然后再点击Services，可以看到此时有两个Available Services，其中myService就是我们刚才定义的。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-7.png)

点击myService，可以看到生成的wsdl配置文件：其中命名空间是我们自定义的那个。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-8.png)

至此，webService的服务器端开发就完成了，由于客户端的访问方式都是相同的，这个放到最后。

# 3、不打jar包的方式：（重点） #

将axis2整合到接口所在系统中。同样如第二种方法，编写一个名为webServiceAxis2的项目。实现com.sdjxd.SayHelloImpl。

由于要将Axis2添加到项目中，所以需要在web.xml中添加如下配置：

```xml
<!--Axis2 config start-->
<servlet>
    <servlet-name>AxisServlet</servlet-name>
<servlet-class>org.apache.axis2.transport.http.AxisServlet</servlet-class>
    <load-on-startup>1</load-on-startup>
</servlet>
<servlet-mapping> 
 	<servlet-name>AxisServlet</servlet-name>  
 	<url-pattern>/services/*</url-pattern>  
</servlet-mapping>
<!--Axis2  end-->
```

然后找到部署在tomcat中的axis2目录下的WEB-INF里的一下三个文件夹conf、modules、services。将他们拷贝到项目webServiceAxis2中的WEB-INF目录下。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-9.png)

将axis2中lib下的jar包全部拷贝到webServiceAxis2里的lib中。然后再services目录下建立目录：webService/META-INF，在这个目录下建立services.xml配置文件。配置方法同上。目录webService/META-INF中webService名字是任意的，这里取webService。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-10.png)

最后，将下载的项目中的axis2-web文件夹拷贝到webroot下，这个文件夹控制显示axis2的服务器列表等信息。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-11.png)

完成后，重启tomcat，访问<http://127.0.0.1:8080/webServiceAxis2/services/listServices>可以看到接口列表。访问地址<http://127.0.0.1:8080/webServiceAxis2/services/myService?wsdl>可以看到wsdl配置。

![Alt text](http://7xsp5x.com2.z0.glb.clouddn.com/webservice-ws-12.png)

# 4、客户端访问webService的方法 #

两个方法分别调用webService中的两个接口方法。

```java
package com.sdjxd;
import javax.xml.namespace.QName;
import org.apache.axis2.AxisFault;
import org.apache.axis2.addressing.EndpointReference;
import org.apache.axis2.client.Options;
import org.apache.axis2.rpc.client.RPCServiceClient;
public class ComeToSayHi {
	/**
	 * @method comeToSay
	 * @description 调用接口方法sayHello(),接口方法无参，无返回值
	 * @author lizhen
	 */
	public static String comeToSay() {
		//接口访问地址，最后要有“?wsdl”
		String url = "http://127.0.0.1:8080/webServiceAxis2/services/myService?wsdl";
		//访问接口方法
		String method = "sayHello";
		RPCServiceClient serviceClient = null;
		try {
			serviceClient = new RPCServiceClient();
			Options options = serviceClient.getOptions();
			EndpointReference targetEPR = new EndpointReference(url);
			options.setTo(targetEPR);
			//连接服务器段的超时时间
			options.setTimeOutInMilliSeconds(100000L);
			//不加的话容易出现异常。
			options.setAction(method);
			//初始化参数，无参时，不能使用null，必须使用new Object[] {}。
			//有参数，使用new Object[] {param}
			//有多个参数，不用指定参数的名称new Object[] {param1,param2,...}
			Object[] opAddEntryArgs = (Object[]) null;
			opAddEntryArgs = new Object[] {};
			//在创建QName对象时，QName类的构造方法的第一个参数表示WSDL文件的命名空间名,也就是<wsdl:definitions>元素的targetNamespace属性值
			QName opAddEntry = new QName("http://sdjxd.com.cn", method);
			//要调用的方法没有返回值，使用方法invokeRobust(QName, new Object[]{..});
			//第一个参数的类型是QName对象，表示要调用的方法名；
			//第二个参数表示要调用的WebService方法的参数值，参数类型为Object[]；
			//如果有返回值则要使用invokeBlocking(QName, new Object[]{..},new Class[]{..})
			//第三个参数表示WebService方法的返回值类型的Class对象，参数类型为Class[]。
			serviceClient.invokeRobust(opAddEntry,opAddEntryArgs);
			//清空缓存，否则容易出错。
			serviceClient.cleanupTransport();
			return "Hi";
		} catch (AxisFault e) {
			e.printStackTrace();
		}
		return "Hi";
	}
	/**
	 * @method comeToSayHelloToSomeone
	 * @description 调用接口方法sayHelloToSomeone(),接口方法有参，有返回值
	 * @author lizhen
	 */
	public static String comeToSayHelloToSomeone() {
		String url = "http://127.0.0.1:8080/webServiceAxis2/services/myService?wsdl";
		String method = "sayHelloToSomeone";
		String str = "li";
		String result = "";
		RPCServiceClient serviceClient;
		try {
			serviceClient = new RPCServiceClient();
			Options options = serviceClient.getOptions();
			EndpointReference targetEPR = new EndpointReference(url);
			options.setTimeOutInMilliSeconds(100000L);
			options.setAction(method);
			options.setTo(targetEPR);
			QName opAddEntry = new QName("http://sdjxd.com.cn", method);
			Object[] opAddEntryArgs = new Object[] {str};
			Class[] classes = new Class[] { String.class };
			//webService方法有参数，使用invokeBlocking方法调用
			result = (String) serviceClient.invokeBlocking(opAddEntry,opAddEntryArgs, classes)[0];
		} catch (AxisFault e) {
			e.printStackTrace();
		}
		return result;
	}
	public static void main(String[] args) {
		String a = comeToSay();
		String b = comeToSayHelloToSomeone();
		System.out.print(a + "-----" + b);
	}
}
```