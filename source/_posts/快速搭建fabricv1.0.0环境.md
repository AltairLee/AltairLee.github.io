---
title: 快速搭建fabricv1.0.0环境
date: 2017-05-10 14:12:28
tags: Fabric
categories: BlockChain--Fabric
---

# 1.安装Docker及Docker-Compose

参考另一篇博客：[Ubuntu14.04下安装docker和docker-compose](http://www.lzblog.cn/2017/02/01/Ubuntu14-04%E4%B8%8B%E5%AE%89%E8%A3%85docker%E5%92%8Cdocker-compose/)

# 2.安装Go环境

参考另一篇博客：[Ubuntu和Windows搭建go环境](http://www.lzblog.cn/2017/03/07/Ubuntu%E5%92%8CWindows%E6%90%AD%E5%BB%BAgo%E7%8E%AF%E5%A2%83/)

# 3. Fabric源码下载

<!--more-->

    mkdir –p ~/go/src/github.com/hyperledger 
    cd ~/go/src/github.com/hyperledger 
    git clone https://github.com/hyperledger/fabric.git

![image](http://7xsp5x.com2.z0.glb.clouddn.com/fabric-fabric%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA01.png)

切换到v1.0.0版本

    cd ~/go/src/github.com/hyperledger/fabric
    git checkout v1.0.0

![image](http://7xsp5x.com2.z0.glb.clouddn.com/fabric-fabric%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA02.png)

# 4. Fabric Docker镜像的下载
    
    cd ~/go/src/github.com/hyperledger/fabric/examples/e2e_cli/
    source download-dockerimages.sh -c x86_64-1.0.0 -f x86_64-1.0.0

**注：** 如果提示权限不足，查看是否将当前用户添加到docker用户组中

下载过程较慢，请耐心等待，安装完成后查看docker中镜像
    
    docker images

![image](http://7xsp5x.com2.z0.glb.clouddn.com/fabric-fabric%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA03.png)

# 5.启动Fabric网络并完成ChainCode的测试

network_setup.sh提供了启动，停止，重启fabric网络的脚本。首先启动fabric网络，启动过程可能要稍微等待一会：

    ./network_setup.sh up

![image](http://7xsp5x.com2.z0.glb.clouddn.com/fabric-fabric%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA04.png)

看到以下这两个标识，fabric网络就是启动成功了

![image](http://7xsp5x.com2.z0.glb.clouddn.com/fabric-fabric%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA05.png)

**注意：** 

    1.fabric的启停操作一定要使用脚本执行，否则下次启动可能会出错。
    2.如果执行up/down失败，可以尝试使用restart启动。
    3.清理e2e_cli目录下多余的文件夹

**遇到的错误：**
![image](http://7xsp5x.com2.z0.glb.clouddn.com/fabric-fabric%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA06.png)
删除e2e_cli文件夹下的crypto-config/文件夹，重新启动，启动成功

# 6.Fabric网络初体验

fabric启动后，查看所有正在运行docker容器：

    sudo docker ps

![image](http://7xsp5x.com2.z0.glb.clouddn.com/fabric-fabric%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA07.png)

在这次安装好的example中，默认的channel名字是mychannel，链码的名字是mycc。我们进入fabric提供的客户端cli。
    
    docker exec -it cli bash

![image](http://7xsp5x.com2.z0.glb.clouddn.com/fabric-fabric%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA08.png)

运行以下命令可以查询a账户的余额：

    peer chaincode query -C mychannel -n mycc -c '{"Args":["query","a"]}'

可以看到a的余额为90
![image](http://7xsp5x.com2.z0.glb.clouddn.com/fabric-fabric%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA09.png)
查询b的余额：
![image](http://7xsp5x.com2.z0.glb.clouddn.com/fabric-fabric%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA10.png)

然后，我们试一试把a账户的余额再转10元给b账户，运行命令：
    
    peer chaincode invoke -o orderer.example.com:7050  --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem  -C mychannel -n mycc -c '{"Args":["invoke","a","b","10"]}'

提示运行成功：
![image](http://7xsp5x.com2.z0.glb.clouddn.com/fabric-fabric%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA11.png)

再次查询a的余额
![image](http://7xsp5x.com2.z0.glb.clouddn.com/fabric-fabric%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA12.png)

查询b的余额：
![image](http://7xsp5x.com2.z0.glb.clouddn.com/fabric-fabric%E7%8E%AF%E5%A2%83%E6%90%AD%E5%BB%BA13.png)

最后我们还要关闭fabric网络，首先exit退出容器，然后同样在e2e_cli目录下执行命令

    ./network_setup.sh down
    
ok，这里fabric一个简单的环境就搭建完成了，接下来可以学习fabric的更多知识了。

