# Mysql 维护

## 安装配置

通过 rpm 包安装

centos 的 yum 源中默认是没有 mysql 的，所以我们需要先去官网下载 mysql 的 repo 源并安装。

### 安装 mysql yum 源

官方下载地址：https://dev.mysql.com/downloads/repo/yum/

（1）下载 yum 源

```bash
$ wget https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
```

（2）安装 yum repo 文件并更新 yum 缓存

```bash
$ rpm -ivh mysql80-community-release-el7-1.noarch.rpm
```

执行结果：

会在 /etc/yum.repos.d/ 目录下生成两个 repo 文件

```bash
$ ls | grep mysql
mysql-community.repo
mysql-community-source.repo
```

更新 yum：

```bash
$ yum clean all
$ yum makecache
```

（3）查看 rpm 安装状态

```bash
$ yum search mysql | grep server
mysql-community-common.i686 : MySQL database common files for server and client
mysql-community-common.x86_64 : MySQL database common files for server and
mysql-community-test.x86_64 : Test suite for the MySQL database server
                       : administering MySQL servers
mysql-community-server.x86_64 : A very fast and reliable SQL database server
```

通过 yum 安装 mysql 有几个重要目录：

```
# 数据库目录
/var/lib/mysql/
# 配置文件
/usr/share/mysql（mysql.server命令及配置文件）
# 相关命令
/usr/bin（mysqladmin mysqldump等命令）
# 启动脚本
/etc/rc.d/init.d/（启动脚本文件mysql的目录）
# 配置文件
/etc/my.cnf
```

### 安装 mysql 服务器

```bash
$ yum install mysql-community-server
```

### 启动 mysql 服务

```bash
# 启动 mysql 服务
systemctl start mysqld.service

# 查看运行状态
systemctl status mysqld.service

# 开机启动
systemctl enable mysqld
systemctl daemon-reload
```

### 初始化数据库密码

查看一下初始密码

```bash
$ grep "password" /var/log/mysqld.log
2018-09-30T03:13:41.727736Z 5 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: %:lt+srWu4k1
```

执行命令：

```bash
mysql -uroot -p<临时密码>
```

输入临时密码，进入 mysql，如果要修改密码，执行以下指令：

```bash
ALTER user 'root'@'localhost' IDENTIFIED BY '你的密码';
```

注：密码强度默认为中等，大小写字母、数字、特殊符号，只有修改成功后才能修改配置再设置更简单的密码

### 配置远程访问

```sql
mysql> CREATE USER 'root'@'%' IDENTIFIED BY '你的密码';
mysql> GRANT ALL ON *.* TO 'root'@'%';
mysql> ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '你的密码';
mysql> FLUSH PRIVILEGES;
```

### 跳过登录认证

```
vim /etc/my.cnf
```

在 [mysqld] 下面加上 skip-grant-tables

作用是登录时跳过登录认证，换句话说就是 root 什么密码都可以登录进去。

执行 `service mysqld restart`，重启 mysql

## 部署

### 主从节点部署

假设需要配置一个主从 Mysql 服务器环境

- master 节点：192.168.8.10
- slave 节点：192.168.8.11

#### 配置主从同步

（1）主节点配置

执行 `vi /etc/my.cnf` ，添加如下配置：

```ini
[mysqld]
server-id=1
log-bin=mysql-bin
```

- `server-id` - 服务器 ID 号；
- `log-bin` - 同步的日志路径及文件名，一定注意这个目录要是mysql有权限写入的；

（2）从节点配置

执行 `vi /etc/my.cnf` ，添加如下配置：

```ini
[mysqld]
server-id=2
log-bin=mysql-bin
```

（3）创建用于复制操作的用户

```sql
mysql> CREATE USER 'sync'@'192.168.8.11' IDENTIFIED WITH mysql_native_password BY '密码'; -- 创建用户
mysql> GRANT REPLICATION SLAVE ON *.* TO 'sync'@'192.168.8.11'; -- 授权
mysql> FLUSH PRIVILEGES; -- 刷新授权表信息
```

（4）查看主节点状态

```sql
mysql> show master status;
+------------------+----------+--------------+---------------------------------------------+-------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB                            | Executed_Gtid_Set |
+------------------+----------+--------------+---------------------------------------------+-------------------+
| mysql-bin.000001 |     4202 |              | mysql,information_schema,performance_schema |                   |
+------------------+----------+--------------+---------------------------------------------+-------------------+
1 row in set (0.00 sec)
```

（5）在Slave节点上设置主节点参数

`MASTER_LOG_FILE` 和 `MASTER_LOG_POS` 参数要分别与 `show master status` 指令获得的 `File` 和 `Position` 属性值对应。

```sql
mysql> CHANGE MASTER TO
MASTER_HOST='192.168.199.149',
MASTER_USER='sync',
MASTER_PASSWORD='密码',
MASTER_LOG_FILE='binlog.000001',
MASTER_LOG_POS=4202;

```

（6）查看主从同步状态

```
mysql> show slave status\G;
```

说明：如果以下两项参数均为 YES，说明配置正确。

- `Slave_IO_Running`
- `Slave_SQL_Running`

（7）启动 slave 进程

```
mysql> start slave;
```

#### 同步主节点已有数据到从节点

主库操作：

（1）停止主库的数据更新操作

```sql
mysql> flush tables with read lock;
```

（2）新开终端，生成主数据库的备份（导出数据库）

```bash
$ mysqldump -uroot -p<密码> test > test.sql
```

（3）将备份文件传到从库

```bash
$ scp test.sql root@192.168.8.11:/root/
```

（4）主库解锁

```mysql
mysql> unlock tables;
```

 从库操作：

（1）停止从库slave

```mysql
mysql> stop slave;
```

（2）新建数据库test

```mysql
mysql> create database test default charset utf8;
```

（3）导入数据

```bash
$ mysql -uroot -ptest123 cmdb<cmdb.sql 
```

（4）查看从库已有该数据库和数据 

```mysql
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| cmdb               |
| mysql              |
| performance_schema |
| test               |
+--------------------+
```

## 运维

### 创建用户

```
CREATE USER 'username'@'host' IDENTIFIED BY 'password';
```

说明：

- username：你将创建的用户名
- host：指定该用户在哪个主机上可以登陆，如果是本地用户可用 localhost，如果想让该用户可以**从任意远程主机登陆**，可以使用通配符`%`
- password：该用户的登陆密码，密码可以为空，如果为空则该用户可以不需要密码登陆服务器

示例：

```sql
CREATE USER 'dog'@'localhost' IDENTIFIED BY '123456';
CREATE USER 'pig'@'192.168.1.101_' IDENDIFIED BY '123456';
CREATE USER 'pig'@'%' IDENTIFIED BY '123456';
CREATE USER 'pig'@'%' IDENTIFIED BY '';
CREATE USER 'pig'@'%';
```

### 授权

命令：

```sql
GRANT privileges ON databasename.tablename TO 'username'@'host'
```

说明：

- privileges：用户的操作权限，如`SELECT`，`INSERT`，`UPDATE`等，如果要授予所的权限则使用`ALL`
- databasename：数据库名
- tablename：表名，如果要授予该用户对所有数据库和表的相应操作权限则可用`*`表示，如`*.*`

示例：

```sql
GRANT SELECT, INSERT ON test.user TO 'pig'@'%';
GRANT ALL ON *.* TO 'pig'@'%';
GRANT ALL ON maindataplus.* TO 'pig'@'%';
```

注意：

用以上命令授权的用户不能给其它用户授权，如果想让该用户可以授权，用以下命令:

```sql
GRANT privileges ON databasename.tablename TO 'username'@'host' WITH GRANT OPTION;
```

### 撤销授权

命令:

```
REVOKE privilege ON databasename.tablename FROM 'username'@'host';
```

说明:

privilege, databasename, tablename：同授权部分

例子:

```
REVOKE SELECT ON *.* FROM 'pig'@'%';
```

注意:

假如你在给用户`'pig'@'%'`授权的时候是这样的（或类似的）：`GRANT SELECT ON test.user TO 'pig'@'%'`，则在使用`REVOKE SELECT ON *.* FROM 'pig'@'%';`命令并不能撤销该用户对 test 数据库中 user 表的`SELECT` 操作。相反，如果授权使用的是`GRANT SELECT ON *.* TO 'pig'@'%';`则`REVOKE SELECT ON test.user FROM 'pig'@'%';`命令也不能撤销该用户对 test 数据库中 user 表的`Select`权限。

具体信息可以用命令`SHOW GRANTS FOR 'pig'@'%';` 查看。

### 更改用户密码

```sql
SET PASSWORD FOR 'username'@'host' = PASSWORD('newpassword');
```

如果是当前登陆用户用:

```sql
SET PASSWORD = PASSWORD("newpassword");
```

示例：

```sql
SET PASSWORD FOR 'pig'@'%' = PASSWORD("123456");
```

### 备份与恢复

Mysql 备份数据使用 mysqldump 命令。

mysqldump 将数据库中的数据备份成一个文本文件，表的结构和表中的数据将存储在生成的文本文件中。

备份：

（1）备份一个数据库

语法：

```
mysqldump -u <username> -p <database> [<table1> <table2> ...] > backup.sql
```

- username 数据库用户
- dbname 数据库名称
- table1 和 table2 参数表示需要备份的表的名称，为空则整个数据库备份；
- BackupName.sql 参数表设计备份文件的名称，文件名前面可以加上一个绝对路径。通常将数据库被分成一个后缀名为 sql 的文件

（2）备份多个数据库

```
mysqldump -u <username> -p --databases <database1> <database2> ... > backup.sql
```

（3）备份所有数据库

```
mysqldump -u <username> -p -all-databases > backup.sql
```

恢复：

Mysql 恢复数据使用 mysqldump 命令。

语法：

```
mysql -u <username> -p <database> < backup.sql
```

### 卸载

（1）查看已安装的 mysql

```bash
$ rpm -qa | grep -i mysql
perl-DBD-MySQL-4.023-6.el7.x86_64
mysql80-community-release-el7-1.noarch
mysql-community-common-8.0.12-1.el7.x86_64
mysql-community-client-8.0.12-1.el7.x86_64
mysql-community-libs-compat-8.0.12-1.el7.x86_64
mysql-community-libs-8.0.12-1.el7.x86_64
```

（2）卸载 mysql

```bash
$ yum remove mysql-community-server.x86_64
```

## 问题

### JDBC 与 Mysql 因 CST 时区协商无解导致偏差了 14 或 13 小时

**现象**

数据库中存储的 Timestamp 字段值比真实值少了 13 个小时。

**原因**

- 当 JDBC 与 MySQL 开始建立连接时，会获取服务器参数。
- 当 MySQL 的 `time_zone` 值为 `SYSTEM` 时，会取 `system_time_zone` 值作为协调时区，若得到的是 `CST` 那么 Java 会误以为这是 `CST -0500` ，因此会给出错误的时区信息（国内一般是`CST +0800`，即东八区）。

> 查看时区方法：
>
> 通过 `show variables like '%time_zone%';` 命令查看 Mysql 时区配置：
>
> ```
> mysql> show variables like '%time_zone%';
> +------------------+--------+
> | Variable_name    | Value  |
> +------------------+--------+
> | system_time_zone | CST    |
> | time_zone        | SYSTEM |
> +------------------+--------+
> ```

**解决方案**

方案一

```
mysql> set global time_zone = '+08:00';
Query OK, 0 rows affected (0.00 sec)

mysql> set time_zone = '+08:00';
Query OK, 0 rows affected (0.00 sec)
```

方案二

修改 `my.cnf` 文件，在 `[mysqld]` 节下增加 `default-time-zone = '+08:00'` ，然后重启。

## 参考资料

- https://www.cnblogs.com/xiaopotian/p/8196464.html
- https://www.cnblogs.com/bigbrotherer/p/7241845.html
- https://blog.csdn.net/managementandjava/article/details/80039650
- http://www.manongjc.com/article/6996.html
- https://www.cnblogs.com/xyabk/p/8967990.html
- [MySQL 8.0主从（Master-Slave）配置](https://blog.csdn.net/zyhlwzy/article/details/80569422)

## :door: 传送门

| [技术文档归档](https://github.com/dunwu/blog) | [数据库教程系列](https://github.com/dunwu/db-tutorial/codes) |
