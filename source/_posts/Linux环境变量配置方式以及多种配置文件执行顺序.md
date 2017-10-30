---
title: Linux环境变量配置方式以及多种配置文件执行顺序
date: 2017-02-10 10:03:02
tags: Linux
categories: Linux
---

每个用户都有自己专属的运行环境，这个环境是由一组变量所定义，这些变量称之为环境变量。用户可以修改环境变量以满足自己的要求。

设置环境变量：`$export NAME="HELLOWORLD"`  （临时变量，本次登录有效，重启失效）

显示环境变量：`$echo $NAME` （如 `echo $PATH`）

`env`命令查看当前用户所有环境变量

 
如果要想把环境变量保存于系统，以便下次开机还能生效就必须配置到以下文件中：`~/.bashrc`、`~/.bash_profile`、`~/.profile`、`/etc/profile`、`/etc/bash.bashrc`，那么他们之间有什么样的区别呢？

<!-- more -->

首先理解一下两个概念：
1. login shell：用户通过终端登录凭借用户名和密码登录控制台的动作是login shell，也就是说最终会调用login命令的操作都可称之为login shell。

2. non-login shell：用户在图形界面启动一个terminal，或者执行/bin/bash，/usr/bin/bash都属于non-login shell。

对于login shell读取文件的顺序是：

    1. /etc/profile
    2. ~/.bash_profile
    3. ~/.bash_login
    4. ~/.profile

/etc/profile 是必须要执行的，然后后面3个，按照顺序谁存在就执行谁，然后后面的就不会再执行。

其逻辑可用代码表示为：
```
execute /etc/profile  
IF ~/.bash_profile exists THEN  
    execute ~/.bash_profile  
ELSE  
    IF ~/.bash_login exist THEN  
        execute ~/.bash_login  
    ELSE  
        IF ~/.profile exist THEN  
            execute ~/.profile  
        END IF  
    END IF  
END IF  
```

退出交互控制台，执行的文件是：

```
IF ~/.bash_logout exists THEN  
    execute ~/.bash_logout  
END IF  
```

对于～/.bashrc，是在non login shell 启动时执行，也就意味着在图形界面每开启一次terminal，就会读取一次该文件
``` 
IF ~/.bashrc exists THEN  
    execute ~/.bashrc  
END IF  
```

在很多RedHat发行版中和Ubuntu发行版中，如果.bashrc存在于home目录，它将从.bash_profile或.profile中运行，。可能是有以下代码
```
# Run .bashrc if it exists
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
```

了解他们的执行顺序后，就知道环境变量该怎么放了。笔者将Java的环境变量都配置于~/.profile中。
 
另：/etc/environment是整个系统的环境，而/etc/profile是所有用户的环境，前者启动系统后就会去读取该文件，后者只有在用户登录的时候才去读取