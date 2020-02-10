# Linux 软件管理

> 关键词：`rpm`, `yum`, `apt-get`

## 1. rpm

> rpm 命令是 RPM 软件包的管理工具。rpm 原本是 Red Hat Linux 发行版专门用来管理 Linux 各项套件的程序，由于它遵循 GPL 规则且功能强大方便，因而广受欢迎。逐渐受到其他发行版的采用。RPM 套件管理方式的出现，让 Linux 易于安装，升级，间接提升了 Linux 的适用度。
>
> 参考：http://man.linuxde.net/rpm

示例：

（1）安装 rpm 包

```
rpm -ivh xxx.rpm
```

（2）安装.src.rpm 软件包

这类软件包是包含了源代码的 rpm 包，在安装时需要进行编译

```bash
rpm -i xxx.src.rpm
cd /usr/src/redhat/SPECS
rpmbuild -bp xxx.specs             #一个和你的软件包同名的specs文件
cd /usr/src/redhat/BUILD/xxx/      #一个和你的软件包同名的目录
./configure                        #这一步和编译普通的源码软件一样，可以加上参数
make
make install
```

（3）卸载 rpm 软件包

使用命令 `rpm -e 包名`，包名可以包含版本号等信息，但是不可以有后缀.rpm，比如卸载软件包 proftpd-1.2.8-1，可以使用下列格式：

```bash
rpm -e proftpd-1.2.8-1
rpm -e proftpd-1.2.8
rpm -e proftpd-
rpm -e proftpd
```

不可以是下列格式：

```bash
rpm -e proftpd-1.2.8-1.i386.rpm
rpm -e proftpd-1.2.8-1.i386
rpm -e proftpd-1.2
rpm -e proftpd-1
```

有时会出现一些错误或者警告：

```
... is needed by ...
```

这说明这个软件被其他软件需要，不能随便卸载，可以用 rpm -e --nodeps 强制卸载

（4）查看与 rpm 包相关的文件和其他信息

```bash
rpm -qa # 列出所有安装过的包
```

## 2. yum

> yum 命令是在 Fedora 和 RedHat 以及 SUSE 中基于 rpm 的软件包管理器，它可以使系统管理人员交互和自动化地更细与管理 RPM 软件包，能够从指定的服务器自动下载 RPM 包并且安装，可以自动处理依赖性关系，并且一次安装所有依赖的软体包，无须繁琐地一次次下载、安装。
>
> 参考：http://man.linuxde.net/yum

示例：

部分常用的命令包括：

- 自动搜索最快镜像插件：`yum install yum-fastestmirror`
- 安装 yum 图形窗口插件：`yum install yumex`
- 查看可能批量安装的列表：`yum grouplist`

**安装**

```
yum install              #全部安装
yum install package1     #安装指定的安装包package1
yum groupinsall group1   #安装程序组group1
```

**更新和升级**

```
yum update               #全部更新
yum update package1      #更新指定程序包package1
yum check-update         #检查可更新的程序
yum upgrade package1     #升级指定程序包package1
yum groupupdate group1   #升级程序组group1
```

**查找和显示**

```
yum info package1      #显示安装包信息package1
yum list               #显示所有已经安装和可以安装的程序包
yum list package1      #显示指定程序包安装情况package1
yum groupinfo group1   #显示程序组group1信息yum search string 根据关键字string查找安装包
yum search <keyword>   #查找软件包
```

**删除程序**

```
yum remove <package_name>          #删除程序包package_name
yum groupremove group1             #删除程序组group1
yum deplist package1               #查看程序package1依赖情况
```

**清除缓存**

```
yum clean packages       #清除缓存目录下的软件包
yum clean headers        #清除缓存目录下的 headers
yum clean oldheaders     #清除缓存目录下旧的 headers
```

### 2.1. yum 源

yum 的默认源是国外的，下载速度比较慢，所以最好替换为一个国内的 yum 源。

| 推荐 yum 国内源              | 源地址                                                                                                                     |
| ---------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| <http://mirrors.163.com/>    | Centos6：http://mirrors.aliyun.com/repo/Centos-6.repo<br>Centos7：http://mirrors.aliyun.com/repo/Centos-7.repo             |
| <http://mirrors.aliyun.com/> | Centos6：http://mirrors.163.com/.help/CentOS6-Base-163.repo<br>Centos7：http://mirrors.163.com/.help/CentOS7-Base-163.repo |

> 🔔 注意：Cento5 已废弃，只能使用 http://vault.centos.org/ 替换，但由于是国外镜像，速度较慢。

替换方法，以 aliyun CentOS7 为例：

```
cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum clean all
yum makecache
```

## 3. apt-get

> apt-get 命令是 Debian Linux 发行版中的 APT 软件包管理工具。所有基于 Debian 的发行都使用这个包管理系统。deb 包可以把一个应用的文件包在一起，大体就如同 Windows 上的安装文件。
>
> 参考：http://man.linuxde.net/apt-get

示例：

使用 apt-get 命令的第一步就是引入必需的软件库，Debian 的软件库也就是所有 Debian 软件包的集合，它们存在互联网上的一些公共站点上。把它们的地址加入，apt-get 就能搜索到我们想要的软件。/etc/apt/sources.list 是存放这些地址列表的配置文件，其格式如下：

deb [web 或 ftp 地址][发行版名字] [main/contrib/non-free]
我们常用的 Ubuntu 就是一个基于 Debian 的发行，我们使用 apt-get 命令获取这个列表，以下是我整理的常用命令：

在修改 /etc/apt/sources.list 或者 /etc/apt/preferences 之后运行该命令。

```bash
# 更新 apt-get
apt-get update

# 安装一个软件包
apt-get install packagename

# 卸载一个已安装的软件包（保留配置文件）
apt-get remove packagename

# 卸载一个已安装的软件包（删除配置文件）
apt-get –purge remove packagename

# 如果需要空间的话，可以让这个命令来删除你已经删掉的软件
apt-get autoclean apt

# 把安装的软件的备份也删除，不过这样不会影响软件的使用的
apt-get clean

# 更新所有已安装的软件包
apt-get upgrade

# 将系统升级到新版本
apt-get dist-upgrade
```

## 4. 参考资料

- http://man.linuxde.net/rpm
- http://man.linuxde.net/yum
- http://man.linuxde.net/apt-get
- http://www.runoob.com/linux/linux-yum.html
