---
title: windows7 64位安装Oracle10g 32位出错解决方法
date: 2016-04-13 10:53:28
tags:
- Oracle
categories: Oracle
---
64位win7系统下安装Oracle10g 时会提示未知错误，通过以下操作步骤可以使原来32位操作系统下使用的安装程序再安装到64位操作系统下。 

**1、**通过修改安装软件中某些文件使oracle 10g与win7兼容。 
  
<!-- more -->
1. 打开“\Oracle 10G \stage\prereq\db\refhost.xml”，向其中1添加如下代码并保存。  <OPERATING_SYSTEM> <VERSION VALUE="6.1"/> </OPERATING_SYSTEM>  
2. 打开“\Oracle 10G \install\oraparam.ini”，向其中添加如下代码并保存。
[Windows-6.1-required]#Minimum display colours for OUI to run MIN_DISPLAY_COLORS=256 #Minimum CPU speed required for OUI#CPU=300 [Windows-6.1-optional]

**2、**找到oracle安装文件中的setup应用程序，右击，打开“兼容性疑难解答”，点击“尝试建议的设置”，选择“启动程序”。   

**3、**安装oracle 10g，直到安装程序结束。 

**4、**根据以上几步的安装，oracle很可能无法正常使用。这就涉及到权限的问题。具体可通过以下措施解决：打开你已经安装好的oracle程序的路径“\oracle\product\10.2.0\db_1\BIN”，点击sqlplus.exe应用程序，右击—属性，选择兼容性，点击“以兼容模式运行这个程序”单选框，选择“window xp(service pack3)”，继续点击“以管理员身份运行此程序”单选框，最后点击应用-确定。如此，sqlplus就可以正常使用了。 

**5、**对于一些需要远程访问数据库的用户，如此配置还会遇到Net Configuration Assistant无法启动的情况，这就需要找到“\oracle\product\10.2.0\db_1\BIN”路径下的launch.exe应用程序，具体配置如上4。

**6、**综合以上的配置，oracle 10g数据库就可以正常使用了。

**7、**对于数据库开发人员来说，有时候需要借助数据库工具对数据库进行操作，比如利用plsql developer工具操作数据库。如果利用以上oracle的安装配置，可能无法正常使用plsql developer，这涉及权限的问题，可以给“plsqldev.exe”应用程序设定兼容性和权限。具体操作，如上4。