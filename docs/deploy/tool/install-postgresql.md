# PostgreSQL 安装

![](http://oyz7npk35.bkt.clouddn.com/images/20180920181010182614.png)

## PostgreSQL 安装方法

> 本文仅以运行在 Centos 环境下举例。

进入[官方下载页面](https://www.postgresql.org/download/)，根据操作系统选择合适版本。

官方下载页面要求用户选择相应版本，然后动态的给出安装提示，如下图所示：

![](http://oyz7npk35.bkt.clouddn.com/images/20180920181010174348.png)

前 3 步要求用户选择，后 4 步是根据选择动态提示的安装步骤

（1）选择 PostgreSQL 版本

（2）选择平台

（3）选择架构

（4）安装 PostgreSQL 的 rpm 仓库（为了识别下载源）

```sh
yum install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm
```

（5）安装客户端

```sh
yum install postgresql10
```

（6）安装服务端（可选的）

```sh
yum install postgresql10-server
```

（7）设置开机启动（可选的）

```sh
/usr/pgsql-10/bin/postgresql-10-setup initdb
systemctl enable postgresql-10
systemctl start postgresql-10
```

## 使用方法

在初次安装完成后，PostgreSQL 默认已经进行了如下的操作：创建了一个名为 postgres 的数据库用户和一个名为 postgres 的数据库，同时还创建了一个名为 postgres 的 Linux 系统用户。实际上，这里创建的 postgres 数据库用户拥有超级管理员身份，可以访问我们后面所创建的所有数据库，同时可以进行创建新数据库用户和修改用户密码等操作。

输入 `sudo -u postgres psql`，即可登录 PostgreSQL 控制台。

在控制台中可以执行 SQL 指令（语法和一般的 RDBMS 类似）。

### 常用的控制台命令

```
\password           设置密码
\q                  退出
\h                  查看SQL命令的解释，比如\h select
\?                  查看psql命令列表
\l                  列出所有数据库
\c [database_name]  连接其他数据库
\d                  列出当前数据库的所有表格
\d [table_name]     列出某一张表格的结构
\x                  对数据做展开操作
\du                 列出所有用户
```

### 备份和恢复

```sh
$ pg_dump --format=t -d db_name -U user_name -h 127.0.0.1 -O -W  > dump.sql
$ psql -h 127.0.0.1 -U user_name db_name < dump.sql
```

## 参考资料

https://www.postgresql.org/download/
https://blog.csdn.net/mimicoa/article/details/79090930/
http://www.ruanyifeng.com/blog/2013/12/getting_started_with_postgresql.html