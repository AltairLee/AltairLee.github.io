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

# 2.使用阿里提供的自动安装命令。
方便快捷，简单粗暴
	
	$ curl -sSL http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -



# 3.使用Docker加速器
针对Docker客户端版本大于1.10的用户

您可以通过修改daemon配置文件/etc/docker/daemon.json来使用加速器：

	sudo mkdir -p /etc/docker
	sudo tee /etc/docker/daemon.json <<-'EOF'
	{
	  "registry-mirrors": ["https://5gynqgtw.mirror.aliyuncs.com"]
	}
	EOF
	sudo systemctl daemon-reload
	sudo systemctl restart docker

# 4.docker compose安装

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

# 5.修改用户权限

将当前用户（lizhen），添加到用户组docker中

	sudo usermod -aG docker lizhen

注销重新登录即可。