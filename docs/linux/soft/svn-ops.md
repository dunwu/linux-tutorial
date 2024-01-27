# Svn 运维

> Svn 是 Subversion 的简称，是一个开放源代码的版本控制系统，它采用了分支管理系统。
>
> 本文目的在于记录 svn 的安装、配置、使用。

## 安装

### 安装 svn

```bash
$ yum install -y subversion
```

### 创建 svn 仓库

```bash
$ mkdir -p /share/svn
$ svnadmin create /share/svn
$ ls /share/svn
conf  db  format  hooks  locks  README.txt
```

在 conf 目录下有三个重要的配置文件

- `authz` - 是权限控制文件
- `passwd` - 是帐号密码文件
- `svnserve.conf` - 是 SVN 服务配置文件

## 配置

### 配置 svnserve.conf

```bash
$ vim /share/svn/conf/svnserve.conf
```

打开下面的 5 个注释

```ini
anon-access = read      #匿名用户可读
auth-access = write     #授权用户可写
password-db = passwd    #使用哪个文件作为账号文件
authz-db = authz        #使用哪个文件作为权限文件
realm = /share/svn      # 认证空间名，版本库所在目录
```

### 配置 passwd

```bash
$ vim /share/svn/conf/passwd
```

添加新用户的用户名/密码如下：

```ini
[users]
user1 = 123456
user2 = 123456
user3 = 123456
```

### 配置 authz

```bash
$ vim /share/svn/conf/authz
```

指定用户的访问权限（`r` 为读权限；`w` 为写权限）：

```ini
[/]
user1 = rw
user2 = rw
user3 = rw
*=
```

## 服务器管理

### 启动关闭 svn

```bash
$ svnserve -d -r /share/svn # 启动 svn
$ killall svnserve # 关闭 svn
```

### 开机自启动 svn 方法

安装好 svn 服务后，默认是没有随系统启动自动启动的，而一般我们有要求 svn 服务稳定持续的提供服务。所以，有必要配置开机自启动 svn 服务。

#### Centos7 以前

编辑 `/etc/rc.d/rc.local` 文件：

```bash
$ vi /etc/rc.d/rc.local
```

输入以下内容：

```bash
# 开机自动启动 svn，默认端口是 3690
$ /usr/bin/svnserve -d -r /share/svn --listen-port 3690
```

注意：

我们在用终端操作的时候，可以直接使用以下命令启动 SVN：`svnserve -d -r /share/svn`，但是在 `/etc/rc.d/rc.local` 文件中必须写上完整的路径！

如果不知道 svnserve 命令安装在哪儿，可以使用 whereis svnserve 查找。

#### Centos7

CentOS 7 中的 `/etc/rc.d/rc.local` 是没有执行权限的，系统建议创建 `systemd service` 启动服务。

找到 svn 的 service 配置文件 `/etc/sysconfig/svnserve` 编辑配置文件

```bash
$ vi /etc/sysconfig/svnserve
```

将 `OPTIONS="-r /var/svn"` 改为 svn 版本库存放的目录，:wq 保存退出。

执行 `systemctl enable svnserve.service`

重启服务器后，执行 `ps -ef | grep svn` 应该可以看到 svn 服务的进程已经启动。

- 启动一个服务 - systemctl start svnserve.service
- 关闭一个服务 - systemctl stop svnserve.service
- 重启一个服务 - systemctl restart svnserve.service
- 显示一个服务的状态 - systemctl status svnserve.service
- 在开机时启用一个服务 - systemctl enable svnserve.service
- 在开机时禁用一个服务 - systemctl disable svnserve.service

## 客户端使用

进入 [svn 官方下载地址](https://tortoisesvn.net/downloads.html)，选择合适的版本，下载并安装。

新建一个目录，然后打开鼠标右键菜单，选择 **SVN Checkout**。

在新的窗口，输入地址 `svn://<你的 IP>` 即可，不出意外输入用户名和密码就能连接成功了（这里的用户、密码必须在 passwd 配置文件的清单中）。默认端口 3690，如果你修改了端口，那么要记得加上端口号。如下图所示：

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20190129175443.png)

## 参考资料

- https://www.cnblogs.com/liuxianan/p/linux_install_svn_server.html
- https://blog.csdn.net/testcs_dn/article/details/45395645
- https://www.cnblogs.com/moxiaoan/p/5683743.html
- https://blog.csdn.net/realghost/article/details/52396648
