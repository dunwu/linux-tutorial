# Linux 教程

## :bulb: 指南

学习之前，先看一下入门三问：

> 什么是 Linux？
>
> Linux 是一套免费使用和自由传播的类 Unix 操作系统，是一个基于 POSIX 和 UNIX 的多用户、多任务、支持多线程和多 CPU 的操作系统。它能运行主要的 UNIX 工具软件、应用程序和网络协议。它支持 32 位和 64 位硬件。Linux 继承了 Unix 以网络为核心的设计思想，是一个性能稳定的多用户网络操作系统。

> 为什么学习 Linux？
>
> Linux 常用于网站服务器或嵌入式应用。世界上大部分网站都部署在 Linux 服务器上，作为一名 web 开发人员，

如何学习 Linux？

## :memo: 知识点

### [Linux 命令](cli)

> 根据应用场景，将常见 Linux 命令分门别类的一一介绍。
>
> 如果想快速学习，推荐参考这篇文章：[命令行的艺术（转载）](cli/命令行的艺术.md)

1. [查看 Linux 命令帮助信息](cli/01.查看Linux命令帮助信息.md) - 关键词：`help`, `whatis`, `info`, `which`, `whereis`, `man`
2. [Linux 文件目录管理](cli/02.Linux文件目录管理.md) - 关键词：`cd`, `ls`, `pwd`, `mkdir`, `rmdir`, `tree`, `touch`, `ln`, `rename`, `stat`, `file`, `chmod`, `chown`, `locate`, `find`, `cp`, `mv`, `rm`
3. [Linux 文件内容查看命令](cli/03.Linux文件内容查看编辑.md) - 关键词：`cat`, `head`, `tail`, `more`, `less`, `sed`, `vi`, `grep`
4. [Linux 文件压缩和解压](cli/04.Linux文件压缩和解压.md) - 关键词：`tar`, `gzip`, `zip`, `unzip`
5. [Linux 用户管理](cli/05.Linux用户管理.md) - 关键词：`groupadd`, `groupdel`, `groupmod`, `useradd`, `userdel`, `usermod`, `passwd`, `su`, `sudo`
6. [Linux 系统管理](cli/06.Linux系统管理.md) - 关键词：`reboot`, `exit`, `shutdown`, `date`, `mount`, `umount`, `ps`, `kill`, `systemctl`, `service`, `crontab`
7. [Linux 网络管理](cli/07.Linux网络管理.md) - 关键词：关键词：`curl`, `wget`, `telnet`, `ip`, `hostname`, `ifconfig`, `route`, `ssh`, `ssh-keygen`, `firewalld`, `iptables`, `host`, `nslookup`, `nc`/`netcat`, `ping`, `traceroute`, `netstat`
8. [Linux 硬件管理](cli/08.Linux硬件管理.md) - 关键词：`df`, `du`, `top`, `free`, `iotop`
9. [Linux 软件管理](cli/09.Linux软件管理.md) - 关键词：`rpm`, `yum`, `apt-get`

### [工具](tool)

- [Git](tool/git)
- [Vim](tool/vim.md)

### [Linux 运维](ops)

#### Linux 服务器运维

- [Linux 典型运维应用](ops/linux典型运维应用.md)
- [samba 使用详解](ops/samba使用详解.md)

#### 应用、服务、工具运维和调优

- 研发环境
  - [JDK](ops/service/jdk.md)
  - [Nodejs](ops/service/nodejs.md)
  - [Tomcat](ops/service/tomcat.md)
  - [Zookeeper](ops/service/zookeeper.md)
- 研发工具
  - [Nexus](ops/service/nexus.md)
  - [Jenkins](ops/service/jenkins.md) - 持续集成和持续交付平台。
  - [Elastic](ops/service/elastic) - 常被称为 `ELK` ，是 Java 世界最流行的分布式日志解决方案 。 `ELK` 是 Elastic 公司旗下三款产品 [ElasticSearch](https://www.elastic.co/products/elasticsearch) 、[Logstash](https://www.elastic.co/products/logstash) 、[Kibana](https://www.elastic.co/products/kibana) 的首字母组合。
  - [Apollo](ops/service/apollo) - 分布式配置中心
- 版本控制
  - [Gitlab](ops/service/gitlab) - Git 代码管理平台。
  - [Svn](ops/service/svn.md) - Svn 是 Subversion 的简称，是一个开放源代码的版本控制系统，它采用了分支管理系统。
- 消息中间件
  - [Kafka](ops/service/kafka.md) - 应该是 Java 世界最流行的消息中间件了吧。
  - [RocketMQ](ops/service/rocketmq.md) - 阿里巴巴开源的消息中间件。
- 数据库
  - [Mysql](https://github.com/dunwu/database/blob/master/docs/mysql/install-mysql.md) - 关系型数据库
  - [PostgreSQL](https://github.com/dunwu/database/blob/master/docs/postgresql.md#安装) - 关系型数据库
  - [Mongodb](https://github.com/dunwu/database/blob/master/docs/mongodb/install-mongodb.md) - Nosql
  - [Redis](https://github.com/dunwu/database/blob/master/docs/redis/install-redis.md) - Nosql

## :books: 学习资源

### Linux 资源汇总

- [awesome-linux](https://github.com/aleksandar-todorovic/awesome-linux) - Linux 资源汇总
- [awesome-linux-software](https://github.com/LewisVo/Awesome-Linux-Software) - Linux 软件汇总

### Linux 教程

- [鸟哥的私房菜](http://cn.linux.vbird.org/) - 久负盛名的 Linux 教程
- [菜鸟教程-Linux](http://www.runoob.com/linux/linux-tutorial.html) - 入门级 Linux 教程
- [Linux 工具快速教程](https://github.com/me115/linuxtools_rst)

### Linux 帮助手册

- [命令行的艺术](https://github.com/jlevy/the-art-of-command-line/blob/master/README-zh.md) - Linux 命令 cheat sheet
- [Linux 命令大全](http://man.linuxde.net/) - Linux 命令在线帮助手册
- [linux-command](https://github.com/jaywcjlove/linux-command) - Linux 命令在线帮助手册
- [linux-tutorial](https://github.com/judasn/Linux-Tutorial) - Linux 环境下各种软件安装部署

## :door: 传送门

| [linux-tutorial](https://github.com/dunwu/linux-tutorial) | [blog](https://github.com/dunwu/blog) |
