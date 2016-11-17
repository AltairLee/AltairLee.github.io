---
title: Servlet学习笔记（二）
date: 2016-04-28 15:46:55
tags: Servlet
categories: Java
---
# 4、数据访问
## 4.1、如何使用jdbc访问数据库?

1)、JDBC连接Oracle数据库：
<!-- more -->
```java
public static void test() 
throws SQLException, ClassNotFoundException
	{
		// 1、注册驱动（三种方式）
// DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		// System.getProperty("jdbc.driver", "oracle.jdbc.driver.OracleDriver");
// 推荐方式 ，编译不依赖于jar包
		Class.forName("oracle.jdbc.driver.OracleDriver");		  
		String url = "jdbc:oracle:thin@localhost:1521:boson1";
		String user = "scott";
		String password = "tiger";
		String sql = "select * from emp_lizhen";
		// 2、建立连接
		Connection conn = DriverManager.getConnection(url, user, password);
		// 3、创建语句
		PreparedStatement st = conn.prepareStatement(sql);
		// 4、执行语句
		ResultSet rs = st.executeQuery();
		// 5、处理结果
		while (rs.next())
		{
			System.out.println(rs.getObject("empno"));
		}
		// 6、释放资源
		rs.close();
		st.close();
		conn.close();
	}
```
2）、JDBC连接MySql数据库
使用mysql与oracle唯一不同就是连接是不同，不同的驱动，不同的获取连接的方式。
```java
Class.forName("com.mysql.jdbc.Driver");
//获取连接，并设置编码方式
conn = DriverManager.getConnection(
		"jdbc:mysql://localhost:3306/jsd1209db" +
		"?useUnicode=true&characterEncoding=utf8"
		, "root"
		, "");
```
**注意：**

操作数据库时尽量使用preparedStatement，可以有效的方式sql注入。

## 4.2、MVC
MVC(Model-View-Controller 模型-视图-控制器)软件架构思想。
* Model（模型层）专注于业务逻辑（即数据的存储、处理等）
* View（视图层）专注于数据在客户端的显示
* Control（控制层）用于连接Model层和View层。

## 4.3、DAO
DAO(Data Access Object，数据访问对象)。DAO属于MVC设计模式中的Model层的数据层操作。

DAO主要有下面几部分组成：
* DatabaseConnection：专门负责数据库的连接和关闭操作。
* VO：即实体类，每一个实体类对应一个数据库中的表，实体类中的属性对应表中的字段。
* DAO：主要为实体类定义各种主要操作，对数据库进行增、删、改、查等原子性操作。
* Impl：DAO接口的真实实现类，完成具体的操作，但是不负责数据库的打开和关闭。
* Proxy：代理实现类，主要完成数据库的连接和关闭，并且调用真实实现类对象的操作。
* Factory：工厂类，通过工厂类取得DAO实例化对象。

DAO设计模式中，最重要的就是设计DAO接口，接口的设计必须对业务进行了解，熟悉每一张表在整个系统中应该具有什么功能。

# 5、过滤器与监听器
## 5.1、什么是过滤器?
servlet规范中定义的一种特殊的组件，用来拦截容器的调用过程。

## 5.2、如何写一个过滤器?
1. 写一个java类，实现Filter接口
2. 在doFilter方法里面，实现拦截处理的逻辑
3. 配置过滤器(web.xml)

## 5.3、过滤器的优先级由什么来决定?
<filter-mapping>配置的先后顺序决定了过滤器执行的先后顺序。

## 5.4、如何给过滤器配置初始化参数?
1. 在web.xml文件当中，使用<init-param>配置相应的参数。
2. 使用`String FilterConfig.getInitParameter(String paraName);`

## 5.5、过滤器的优点
1. 将多个组件相同或者类似的处理逻辑集中写在过滤器里面，方便代码的维护。
2. 实现代码的“可插拔性”：增加或者减少某个模块，不会影响到整个程序的正常执行。

## 5.6、写一个过滤器CommentFilter，检查评论的字符个数（长度不超过20个）
```java

```

## 5.7、什么是监听器?
servlet规范当中定义的一种特殊的组件，用来监听容器产生的两大类事件并进行处理事件包括：
1. 生命周期相关事件：容器创建或者销毁ServletContext(servlet上下文), request，session市产生的事件。
2. 绑定相关事件：对request，session，servlet上下文调用了setAttribute，removeAttribute时产生的事件。

## 5.8、如何写一个监听器?
1. 写一个java类，实现相应的监听器接口。
2. 在监听器接口声明的方法里，实现相应的处理逻辑。
3. 配置监听器(在web.xml)

## 5.9、servletContext(application)
1. 什么是ServletContext?
容器在启动的时候，会为每一个web应用创建唯一的一个符合ServletContext接口的对象，该对象也称之为servlet上下文。该对象会一直存在，除非容器关闭或者对应的应用被卸载。
2. 如何获得servlet上下文?
（1）GenericServlet.getServletContext();
（2）HttpSession.getServletContext();
（3）ServletConfig.getServletContext();
（4）FilterConfig.getServletContext();
3. 作用:
（1）绑订数据
`setAttribute,getAttribute,removeAttribute`
（2）访问全局的初始化参数:
在web.xml文件中，使用<context-param>配置全局的初始化参数，该参数可以被所有的servlet,filter访问。
`String getInitParameter(String name);`
（3）依据一个逻辑路径(path)获得实际部署时的物理路径。
`String getRealPath(String path);`

# 6、扩展
## 6.1、smartupload上传文件组件：

一种较为简单的文件上传组件包，smartupload.jar可以轻松突破上传文件的类型限制，也可以轻松取得上传文件的名称、后缀、大小等。

smartupload组件提供方www.jspsmart.com网站已关闭，但由于smartupload较为好用，所以，至今还有开发者继续使用。在一般的web开发中，使用smartupload较为明智，在struts中才会用较为麻烦的fileupload。

## 6.2、fileupload上传文件组件：
1. 设置表单的enctype属性如下：
`<form action="" method="post" enctype="multipart/form-data">`
2. 在服务器端，不能够使用request.getParameter方法来获得数据。需要调用request.getInputStream来获得InputStream,通过分析这个流来获得表单中的数据。一般都是通过一些工具来帮我们来分析这个流。比如： commons-fileupload.jar。使用时需要将相关的jar文件拷贝到WEB-INF\lib下。接下来，使用这些工具中的类来分析就可以了。

jsp代码：
```jsp
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
  <head>
    <title>My JSP 'fileupload.jsp' starting page</title>
  </head>
  <body style="font-size:30px;">
   <form action="fileprocess" method="post" enctype="multipart/form-data">
  		username:<input name="username"/><br>
  		photo:<input type="file" name="file1"/><br>
  		<input type="submit" value="确定">
  	</form>
  </body>
</html>
```
servlet代码：
```java
public class FileUpLodaServlet extends HttpServlet
{
	@Override
	protected void service(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException
	{
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload sfu = new ServletFileUpload(factory);
		try
		{
			List<FileItem> items = sfu.parseRequest(request);
			for (int i = 0; i < items.size(); i++)
			{
				FileItem curr = items.get(i);
				if (curr.isFormField())
				{
					String value = curr.getString();
					System.out.println(value);
				} else
				{
					String path = getServletContext().getRealPath("upload");
					System.out.println(path);
					String fileName = curr.getName();
					File file = new File(path + "\\" + fileName);
					curr.write(file);
				}
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}
```

# 7、典型案例
## 7.1、验证码
```java
public class IdentifyServlet extends HttpServlet {
	/* 随机字符字典、不包括'0','O','1''I','2''Z'等难分辨的字符 */
	public static final char[] CHARS = { '3', '4', '5', '6', '7', '8', '9',
			'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N',
			'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', };
	public static Random random = new Random();

	/* 随机获取6位字符串 */
	public static String getRandomString() {
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < 6; i++) {
			buffer.append(CHARS[random.nextInt(CHARS.length)]);
		}
		return buffer.toString();
	}

	/* 随机获取颜色 */
	public static Color getRandomColor() {
		return new Color(random.nextInt(255), random.nextInt(255), random
				.nextInt(255));
	}

	/* 获取某颜色的反色 */
	public static Color getReverseColor(Color c) {
		return new Color(255 - c.getRed(), 255 - c.getGreen(), 255 - c
				.getBlue());
	}

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("image/jpeg");// 设置输出类型
		String randomString = getRandomString();// 获取字符串
		Color randomColor = getRandomColor();// 获取颜色
		Color reverseColor = getReverseColor(randomColor);// 获取反色
		/* 放到session中,以便其他的servlet获取字符串，进行验证 */
		request.getSession(true).setAttribute("randomString", randomString);
		int width = 100;
		int height = 30;
		/* 创建一张彩色图片 */
		BufferedImage bi = new BufferedImage(width, height,
				BufferedImage.TYPE_INT_RGB);
		/* 获取绘图对象 */
		Graphics2D g = bi.createGraphics();
		/* 设置各种属性 */
		g.setFont(new Font(Font.SANS_SERIF, Font.BOLD, 16));
		g.setColor(randomColor);
		g.fillRect(0, 0, width, height);
		g.setColor(reverseColor);
		g.drawString(randomString, 18, 20);
		/* 设置不大于100个噪音点 */
		for (int i = 0, n = random.nextInt(100); i < n; i++) {
			g.drawRect(random.nextInt(width), random.nextInt(height), 1, 1);
		}
		/* 输出流 */
		ServletOutputStream out = response.getOutputStream();
		/* 转换成JPEG格式 */
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
		/* 对图片进行编码 */
		encoder.encode(bi);
		out.flush();
		out.close();
	}
}
```

# 8、总结

## 8.1、四种属性传递方式：

在jsp中，属性传递方式有四种，page(指的是pageContext), request, session, servletContext（即application）。方法主要有setAttribute、getAttribute、removeAttribute。

从保存时间上看，page保存在一个页面，跳转无效(不常用)；request在一次请求连接时有效，新建连接后失效；session在一次会话中有效，用户注销后失效；如果是servletContext也就是application，会保存在服务器端,当服务器关闭或者对应的应用程序被注销，才会失效。

如果要绑定的数据以上四种方式都满足需要的话，应选择保存时间最短的，保存时间短，内存的占用量就少，相应的性能也是最高的。

## 8.2、几个内置对象:

request使用最频繁的对象，主要用于接收属性值、设置属性、设置编码等。

response用于对客户端请求进行相应。可以设置重定向：response.sendRedirect(String locationUrl)。添加cookie对象，response.addCookie(Cookie cookie)。

session在实际开发中，主要的作用就是用于用户的登录验证和注销操作。

pageContext主要用户获取其他8个内置对象（getRequest、getResponse…）在一般servlet开发中很少用，但在标签编程中非常常见。

application(servletContext)可以使用this.getServletContext代替，它的getRealPath()可以取得虚拟目录对应的真实路径，在文件操作中非常有用。application也可以获取xml文件中的配置参数application.getInitParameter("driver ");application获取的是当整个web应用配置的参数。
	
config主要作用是取得一些在web.xml文件中配置的初始化参数，使用getInitParameter(String name)方法。例如，将数据库连接驱动程序名保存在xml文件中，就可以使用String dbDriver = config.getInitParameter(	"driver");config获取的是当前servlet配置的参数。

## 8.3、客户端跳转与服务器跳转：

1. 服务器跳转的地址，必须是同一个应用中的其他组件，而客户端跳转的地址是任意的。
2. 服务器跳转浏览器地址栏不会有任何变化，而客户端跳转后，浏览器地址栏地址会变成跳转之后的页面地址。
3. 只有服务器跳转才能将request属性保存到跳转页。这是由http协议决定的，“一次请求，一次连接”，客户端跳转包括是两次请求，所以无法共享属性。
4. 服务器跳转，执行到跳转语句会立即跳转，不会执行跳转语句之后的代码，而客户端跳转会执行完整个页面，然后再进行跳转。

例如：
```jsp
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<html>
  <head>
  </head>
  <body>
  <%
  	System.out.println("====response跳转之前====");
  	response.sendRedirect("hello.jsp");
  	System.out.println("====response跳转之后====");
  %>
  </body>
</html>	
```
运行之后，控制台会输出:
```
====response跳转之前====
====response跳转之后====
```
jsp被部署为servlet之后的相关代码：
```java
	out.write("\r\n");
	out.write("<html>\r\n");
	out.write("  <head>\r\n");
	out.write("  </head>\r\n");
	out.write("  <body>\r\n");
	out.write("  ");
	System.out.println("response跳转之前");
	response.sendRedirect("hello.jsp");
	System.out.println("response跳转之后");
	out.write("\r\n");
	out.write("  </body>\r\n");
	out.write("</html>\r\n");
```
所以不管response.sendRedirect在什么位置，跳转前后的语句都会被执行。

由于这两种跳转的差异，在进行服务器跳转之前，必须关闭数据库连接，否则将再也无法关闭，如果未关闭的连接达到一定数量，会出现“数据库连接已达到最大的异常”，此时就只能重启服务器了。实际开发过程中，服务器跳转要比客户端跳转更为常见。


