---
title: Ubuntu14.04下安装docker和docker-compose
date: 2017-02-01 22:22:25
tags: Docker
categories: Docker
---

# 1.使用docker官方存储库安装。

安装之前首先使用`uname -r`检查系统内核版本，需要是64位且必须大于3.10。如果不满足，需要升级系统内核。

## 1.官方推荐首先安装`curl`及相关程序

    $ sudo apt-get update
    $ sudo apt-get install curl linux-image-extra-$(uname -r) linux-image-extra-virtual

<!-- more -->

## 2.安装https和ca证书

    $ sudo apt-get install apt-transport-https ca-certificates
    
## 3.添加官方密钥

    $ curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -

## 4.验证密钥

    $ apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D
    
## 5.增加官方存储库

    $ sudo apt-get install software-properties-common  #增加add-apt-repository命令，已有可忽略。
    $ sudo add-apt-repository "deb https://apt.dockerproject.org/repo/ ubuntu-$(lsb_release -cs) main" # 这里是官方源，当然你也可以找其他较快的源

## 6.更新源

    $ sudo apt-get update

## 7.安装docker

    $ sudo apt-get -y install docker-engine
## 8.安装版本测试

安装完成后可以使用`sudo docker -v`来查看安装的版本。

# 2.使用ubuntu系统自带源安装。
这种方式安装的docker版本不一定的最新的，版本依赖于系统源中的docker版本，不过基本上也够用了。好处是可以自己修改源，速度较快。

    $ sudo apt-get update 
    $ sudo apt-get install -y docker.io 
    $ sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker 




# 3.docker compose安装

安装完docker以后，可以继续安装docker-compose。这里的安装方式就与上一篇文章[在win10中安装](http://www.lzblog.cn/2017/01/16/win10%E4%B8%8B%E5%88%A9%E7%94%A8DockerToolbox-1-12-2%E5%AE%89%E8%A3%85Docker%E5%92%8CDocker-compose/ "在win10中安装docker...")过程一样了

## 1.方法一：

    $ curl -L "https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    $ chmod +x /usr/local/bin/docker-compose

## 2.方法二：

如果你的电脑上安装了pip，也可以使用以下方法安装：

    $ sudo pip install -U docker-compose
    $ sudo chmod +x /usr/local/bin/docker-compose

## 3.测试安装

安装完成后，可以使用`docker-compose --version`来检测是否安装成功。