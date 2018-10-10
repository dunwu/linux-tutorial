# Mysql 安装

<!-- TOC depthFrom:2 depthTo:3 -->

- [安装配置](#安装配置)
    - [安装 mysql yum 源](#安装-mysql-yum-源)
    - [安装 mysql 服务器](#安装-mysql-服务器)
    - [启动 mysql 服务](#启动-mysql-服务)
    - [初始化数据库密码](#初始化数据库密码)
    - [配置远程访问](#配置远程访问)
    - [跳过登录认证](#跳过登录认证)
- [参考资料](#参考资料)

<!-- /TOC -->

## 安装配置

通过 rpm 包安装

centos 的 yum 源中默认是没有 mysql 的，所以我们需要先去官网下载 mysql 的 repo 源并安装。

### 安装 mysql yum 源

官方下载地址：https://dev.mysql.com/downloads/repo/yum/

（1）下载 yum 源

```sh
$ wget https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
```

（2）安装 yum repo 文件并更新 yum 缓存

```sh
$ rpm -ivh mysql80-community-release-el7-1.noarch.rpm
```

执行结果：

会在 /etc/yum.repos.d/ 目录下生成两个 repo 文件

```sh
ls | grep mysql
mysql-community.repo
mysql-community-source.repo
```

更新 yum：

```
yum clean all
yum makecache
```

（3）查看 rpm 安装状态

```sh
$ yum repolist enabled | grep mysql.*
mysql-connectors-community/x86_64 MySQL Connectors Community                  65
mysql-tools-community/x86_64      MySQL Tools Community                       69
mysql80-community/x86_64          MySQL 8.0 Community Server                  33
```

### 安装 mysql 服务器

```sh
$ yum install mysql-community-server
```

### 启动 mysql 服务

```sh
# 启动 mysql 服务
$ systemctl start mysqld.service

# 查看运行状态
$ systemctl status mysqld.service

# 开机启动
$ systemctl enable mysqld
$ systemctl daemon-reload
```

### 初始化数据库密码

查看一下初始密码

```sh
$ grep "password" /var/log/mysqld.log
2018-09-30T03:13:41.727736Z 5 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: %:lt+srWu4k1
```

执行命令：

```sh
mysql -uroot -p
```

输入临时密码，进入 mysql

```sh
ALTER user 'root'@'localhost' IDENTIFIED BY 'Tw#123456';
```

注：密码强度默认为中等，大小写字母、数字、特殊符号，只有修改成功后才能修改配置再设置更简单的密码

### 配置远程访问

```
GRANT ALL ON *.* TO 'root'@'localhost';
FLUSH PRIVILEGES;
```

### 跳过登录认证

```
vim /etc/my.cnf
```

在 [mysqld] 下面加上 skip-grant-tables

作用是登录时跳过登录认证，换句话说就是 root 什么密码都可以登录进去。

执行 `service mysqld restart`，重启 mysql

## 参考资料

https://www.cnblogs.com/xiaopotian/p/8196464.html
https://www.cnblogs.com/bigbrotherer/p/7241845.html
https://blog.csdn.net/managementandjava/article/details/80039650
http://www.manongjc.com/article/6996.html
https://www.cnblogs.com/xyabk/p/8967990.html
