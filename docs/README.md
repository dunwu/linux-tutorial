---
home: true
heroImage: /images/dunwu-logo-200.png
heroText: LINUX-TUTORIAL
tagline: 📚 linux-tutorial 是一个 Linux 教程。
actionLink: /
footer: CC-BY-SA-4.0 Licensed | Copyright © 2018-Now Dunwu
---

# Linux 教程

> 📚 **linux-tutorial** 是一个 Linux 教程。
>
> 🔁 项目同步维护在 [github](https://github.com/dunwu/linux-tutorial) | [gitee](https://gitee.com/turnon/linux-tutorial)
>
> 📖 [电子书](https://dunwu.github.io/linux-tutorial/) | [电子书（国内）](http://turnon.gitee.io/linux-tutorial/)

## 📖 内容

### Linux 命令

> 学习 Linux 的第一步：当然是从 [Linux 命令](linux/cli/README.md) 入手了。

- [查看 Linux 命令帮助信息](linux/cli/linux-cli-help.md) - 关键词：`help`, `whatis`, `info`, `which`, `whereis`, `man`
- [Linux 文件目录管理](linux/cli/linux-cli-dir.md) - 关键词：`cd`, `ls`, `pwd`, `mkdir`, `rmdir`, `tree`, `touch`, `ln`, `rename`, `stat`, `file`, `chmod`, `chown`, `locate`, `find`, `cp`, `mv`, `rm`
- [Linux 文件内容查看命令](linux/cli/linux-cli-file.md) - 关键词：`cat`, `head`, `tail`, `more`, `less`, `sed`, `vi`, `grep`
- [Linux 文件压缩和解压](linux/cli/linux-cli-file-compress.md) - 关键词：`tar`, `gzip`, `zip`, `unzip`
- [Linux 用户管理](linux/cli/linux-cli-user.md) - 关键词：`groupadd`, `groupdel`, `groupmod`, `useradd`, `userdel`, `usermod`, `passwd`, `su`, `sudo`
- [Linux 系统管理](linux/cli/linux-cli-system.md) - 关键词：`reboot`, `exit`, `shutdown`, `date`, `mount`, `umount`, `ps`, `kill`, `systemctl`, `service`, `crontab`
- [Linux 网络管理](linux/cli/linux-cli-net.md) - 关键词：关键词：`curl`, `wget`, `telnet`, `ip`, `hostname`, `ifconfig`, `route`, `ssh`, `ssh-keygen`, `firewalld`, `iptables`, `host`, `nslookup`, `nc`/`netcat`, `ping`, `traceroute`, `netstat`
- [Linux 硬件管理](linux/cli/linux-cli-hardware.md) - 关键词：`df`, `du`, `top`, `free`, `iotop`
- [Linux 软件管理](linux/cli/linux-cli-software.md) - 关键词：`rpm`, `yum`, `apt-get`

### Linux 运维

> Linux 系统的常见运维工作。

- [网络运维](linux/ops/network-ops.md)
- [Samba](linux/ops/samba.md)
- [NTP](linux/ops/ntp.md)
- [Firewalld](linux/ops/firewalld.md)
- [Crontab](linux/ops/crontab.md)
- [Systemd](linux/ops/systemd.md)
- [Vim](linux/ops/vim.md)
- [Iptables](linux/ops/iptables.md)
- [oh-my-zsh](linux/ops/zsh.md)

### 软件运维

> 部署在 Linux 系统上的软件运维。
>
> 配套安装脚本：⌨ [软件运维配置脚本集合](https://github.com/dunwu/linux-tutorial/tree/master/codes/linux/soft)

- 开发环境
  - [JDK 安装](linux/soft/jdk-install.md)
  - [Maven 安装](linux/soft/maven-install.md)
  - [Nodejs 安装](linux/soft/nodejs-install.md)
- 开发工具
  - [Nexus 运维](linux/soft/nexus-ops.md)
  - [Gitlab 运维](linux/soft/kafka-install.md)
  - [Jenkins 运维](linux/soft/jenkins.md)
  - [Svn 运维](linux/soft/svn-ops.md)
  - [YApi 运维](linux/soft/yapi-ops.md)
- 中间件服务
  - [Elastic 运维](linux/soft/elastic)
  - [Kafka 运维](linux/soft/kafka-install.md)
  - [RocketMQ 运维](linux/soft/rocketmq-install.md)
  - [Zookeeper 运维](https://github.com/dunwu/javatech/blob/master/docs/technology/monitor/zookeeper-ops.md)
  - [Nacos 运维](linux/soft/nacos-install.md)
- 服务器
  - [Nginx 教程](https://github.com/dunwu/nginx-tutorial) 📚
  - [Tomcat 运维](linux/soft/tomcat-install.md)
- [数据库](https://github.com/dunwu/db-tutorial) 📚
  - [Mysql 运维](https://github.com/dunwu/db-tutorial/blob/master/docs/sql/mysql/mysql-ops.md)
  - [Redis 运维](https://github.com/dunwu/db-tutorial/blob/master/docs/nosql/redis/redis-ops.md)

### Docker

- [Docker 快速入门](docker/docker-quickstart.md)
- [Dockerfile 最佳实践](docker/docker-dockerfile.md)
- [Docker Cheat Sheet](docker/docker-cheat-sheet.md)
- [Kubernetes 应用指南](docker/kubernetes.md)

### 其他

- [一篇文章让你彻底掌握 Python](https://github.com/dunwu/blog/blob/master/source/_posts/coding/python.md)
- [一篇文章让你彻底掌握 Shell](https://github.com/dunwu/blog/blob/master/source/_posts/coding/shell.md)
- [Git 从入门到精通](https://github.com/dunwu/blog/blob/master/source/_posts/tools/git.md)

## ⌨ 脚本

### Shell 脚本大全

**Shell 脚本大全** 精心收集、整理了 Linux 环境下的常见 Shell 脚本操作片段。

源码：[**Shell 脚本大全**](https://github.com/dunwu/linux-tutorial/tree/master/codes/shell)

### CentOS 运维脚本集合

本人作为一名 Java 后端，苦于经常在 CentOS 环境上开荒虚拟机。为提高效率，写了一套 Shell 脚本，提供如下功能：安装常用 lib 库、命令工具、设置 DNS、NTP、配置国内 yum 源、一键安装常用软件等。

源码：[**CentOS 常规操作运维脚本集合**](https://github.com/dunwu/linux-tutorial/tree/master/codes/linux)

## 🚪 传送门

◾ 🏠 [LINUX-TUTORIAL 首页](https://github.com/dunwu/linux-tutorial) ◾ 🎯 [我的博客](https://github.com/dunwu/blog) ◾
