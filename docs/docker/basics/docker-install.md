# Docker 安装

> 本教程基于 `Docker 1.37`。
>
> Docker 有两种可安装版本：
>
> - [Community Edition (CE)](https://www.docker.com/community-edition/)，即 Docker 社区版，适合学习。
> - [Enterprise Edition (EE)](https://www.docker.com/enterprise-edition)，即 Docker 企业版，适合企业级开发使用。

<!-- TOC depthFrom:2 depthTo:2 -->

- [Windows 下安装 Docker](#windows-下安装-docker)
- [安装参考](#安装参考)

<!-- /TOC -->

## Windows 下安装 Docker

安装 Docker Toolbox 步骤：

（1）双击运行安装包

![](http://oyz7npk35.bkt.clouddn.com/images/20180920180926103056.png)

（2）点击需要安装的程序，建议全安装

![](http://oyz7npk35.bkt.clouddn.com/images/20180920180926103147.png)

（3）安装附加选项，建议选择前三个

![](http://oyz7npk35.bkt.clouddn.com/images/20180920180926103213.png)

（4）安装结果

![](http://oyz7npk35.bkt.clouddn.com/images/20180920180926102959.png)

### 可能遇到的问题

问题 1 - bash.exe 找不到

![](http://oyz7npk35.bkt.clouddn.com/images/20180920180926104526.png)

打开快捷方式的属性窗口，在目标栏设置如下：

```
"C:\Program Files\Git\bin\bash.exe" --login -i "D:\Tools\DockerToolbox\start.sh"
```

![](http://oyz7npk35.bkt.clouddn.com/images/20180920180926105007.png)

问题 2 - Hyper-V 冲突

![](http://oyz7npk35.bkt.clouddn.com/images/20180920180926105357.png)

## 安装参考

**Enterprise Edition (EE)**

- https://docs.docker.com/install/windows/docker-ee/
- https://docs.docker.com/install/linux/docker-ee/ubuntu/
- https://docs.docker.com/install/linux/docker-ee/rhel/
- https://docs.docker.com/install/linux/docker-ee/centos/
- https://docs.docker.com/install/linux/docker-ee/oracle/
- https://docs.docker.com/install/linux/docker-ee/suse/

**Community Edition (CE)**

- https://docs.docker.com/docker-for-mac/install/
- https://docs.docker.com/docker-for-windows/install/
- https://docs.docker.com/install/linux/docker-ce/ubuntu/
- https://docs.docker.com/install/linux/docker-ce/debian/
- https://docs.docker.com/install/linux/docker-ce/centos/
- https://docs.docker.com/install/linux/docker-ce/fedora/
- https://docs.docker.com/install/linux/docker-ce/binaries/
