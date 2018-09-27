---
title: samba 使用详解
date: 2018/03/01
categories:
- linux
tags:
- linux
- windows
---

<!-- TOC -->

- [samba](#samba)
  - [安装](#%E5%AE%89%E8%A3%85)
  - [配置](#%E9%85%8D%E7%BD%AE)
    - [默认配置](#%E9%BB%98%E8%AE%A4%E9%85%8D%E7%BD%AE)
    - [配置说明](#%E9%85%8D%E7%BD%AE%E8%AF%B4%E6%98%8E)
      - [全局参数 [global]](#%E5%85%A8%E5%B1%80%E5%8F%82%E6%95%B0-global)
      - [共享参数 [共享名]](#%E5%85%B1%E4%BA%AB%E5%8F%82%E6%95%B0-%E5%85%B1%E4%BA%AB%E5%90%8D)
    - [配置samba服务](#%E9%85%8D%E7%BD%AEsamba%E6%9C%8D%E5%8A%A1)
      - [服务规划](#%E6%9C%8D%E5%8A%A1%E8%A7%84%E5%88%92)
      - [创建文件夹和用户](#%E5%88%9B%E5%BB%BA%E6%96%87%E4%BB%B6%E5%A4%B9%E5%92%8C%E7%94%A8%E6%88%B7)
      - [启动 samba 服务](#%E5%90%AF%E5%8A%A8-samba-%E6%9C%8D%E5%8A%A1)
  - [FAQ](#faq)
  - [资料](#%E8%B5%84%E6%96%99)

<!-- /TOC -->

# samba 使用详解

samba 使得在 Linux 和 Windows 系统中进行文件共享、打印机共享更容易实现。

## 安装

**查看是否已安装：**

* CentOS：`rpm -qa | grep samba`
* Ubuntu：`dpkg -l | grep samba`

**安装：**

* CentOS 6：`yum install -y samba samba-client samba-common`

* Ubuntu：`sudo apt-get install -y samba samba-client`

## 配置

### 默认配置

samba 服务的配置文件是 `/etc/samba/smb.conf`，如果没有则 samba 无法启动。

你可以从 [这里](https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD) 获取到默认配置文件：

```
cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
wget "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD" -O /etc/samba/smb.conf
```

smb.conf 内容如下：

```
[global]
        workgroup = SAMBA
        security = user

        passdb backend = tdbsam

        printing = cups
        printcap name = cups
        load printers = yes
        cups options = raw

[homes]
        comment = Home Directories
        valid users = %S, %D%w%S
        browseable = No
        read only = No
        inherit acls = Yes

[printers]
        comment = All Printers
        path = /var/tmp
        printable = Yes
        create mask = 0600
        browseable = No

[print$]
        comment = Printer Drivers
        path = /var/lib/samba/drivers
        write list = root
        create mask = 0664
        directory mask = 0775
```

### 配置说明

#### 全局参数 [global]

```
[global]

config file = /usr/local/samba/lib/smb.conf.%m
说明：config file可以让你使用另一个配置文件来覆盖缺省的配置文件。如果文件 不存在，则该项无效。这个参数很有用，可以使得samba配置更灵活，可以让一台samba服务器模拟多台不同配置的服务器。比如，你想让PC1（主机名）这台电脑在访问Samba Server时使用它自己的配置文件，那么先在/etc/samba/host/下为PC1配置一个名为smb.conf.pc1的文件，然后在smb.conf中加入：config file=/etc/samba/host/smb.conf.%m。这样当PC1请求连接Samba Server时，smb.conf.%m就被替换成smb.conf.pc1。这样，对于PC1来说，它所使用的Samba服务就是由smb.conf.pc1定义的，而其他机器访问Samba Server则还是应用smb.conf。

workgroup = WORKGROUP
说明：设定 Samba Server 所要加入的工作组或者域。

server string = Samba Server Version %v
说明：设定 Samba Server 的注释，可以是任何字符串，也可以不填。宏%v表示显示Samba的版本号。

netbios name = smbserver
说明：设置Samba Server的NetBIOS名称。如果不填，则默认会使用该服务器的DNS名称的第一部分。netbios name和workgroup名字不要设置成一样了。

interfaces = lo eth0 192.168.12.2/24 192.168.13.2/24
说明：设置Samba Server监听哪些网卡，可以写网卡名，也可以写该网卡的IP地址。

hosts allow = 127.192.168.1 192.168.10.1
说明：表示允许连接到Samba Server的客户端，多个参数以空格隔开。可以用一个IP表示，也可以用一个网段表示。hosts deny 与hosts allow 刚好相反。
例如：
# 表示容许来自172.17.2.*.*的主机连接，但排除172.17.2.50
hosts allow=172.17.2.EXCEPT172.17.2.50
# 表示容许来自172.17.2.0/255.255.0.0子网中的所有主机连接
hosts allow=172.17.2.0/255.255.0.0
# 表示容许来自M1和M2两台计算机连接
hosts allow=M1，M2
# 表示容许来自SC域的所有计算机连接
hosts allow=@SC
max connections = 0
说明：max connections用来指定连接Samba Server的最大连接数目。如果超出连接数目，则新的连接请求将被拒绝。0表示不限制。

deadtime = 0
说明：deadtime用来设置断掉一个没有打开任何文件的连接的时间。单位是分钟，0代表Samba Server不自动切断任何连接。

time server = yes/no
说明：time server用来设置让nmdb成为windows客户端的时间服务器。

log file = /var/log/samba/log.%m
说明：设置Samba Server日志文件的存储位置以及日志文件名称。在文件名后加个宏%m（主机名），表示对每台访问Samba Server的机器都单独记录一个日志文件。如果pc1、pc2访问过Samba Server，就会在/var/log/samba目录下留下log.pc1和log.pc2两个日志文件。

max log size = 50
说明：设置Samba Server日志文件的最大容量，单位为kB，0代表不限制。

security = user
说明：设置用户访问Samba Server的验证方式，一共有四种验证方式。
1. share：用户访问Samba Server不需要提供用户名和口令, 安全性能较低。
2. user：Samba Server共享目录只能被授权的用户访问,由Samba Server负责检查账号和密码的正确性。账号和密码要在本Samba Server中建立。
3. server：依靠其他Windows NT/2000或Samba Server来验证用户的账号和密码,是一种代理验证。此种安全模式下,系统管理员可以把所有的Windows用户和口令集中到一个NT系统上,使用Windows NT进行Samba认证, 远程服务器可以自动认证全部用户和口令,如果认证失败,Samba将使用用户级安全模式作为替代的方式。
4. domain：域安全级别,使用主域控制器(PDC)来完成认证。

passdb backend = tdbsam
说明：passdb backend就是用户后台的意思。目前有三种后台：smbpasswd、tdbsam和ldapsam。sam应该是security account manager（安全账户管理）的简写。

smbpasswd：该方式是使用smb自己的工具smbpasswd来给系统用户（真实
用户或者虚拟用户）设置一个Samba密码，客户端就用这个密码来访问Samba的资源。
1. smbpasswd文件默认在/etc/samba目录下，不过有时候要手工建立该文件。
2. tdbsam：该方式则是使用一个数据库文件来建立用户数据库。数据库文件叫passdb.tdb，默认在/etc/samba目录下。passdb.tdb用户数据库可以使用smbpasswd –a来建立Samba用户，不过要建立的Samba用户必须先是系统用户。我们也可以使用pdbedit命令来建立Samba账户。pdbedit命令的参数很多，我们列出几个主要的。
  pdbedit –a username：新建Samba账户。
  pdbedit –x username：删除Samba账户。
  pdbedit –L：列出Samba用户列表，读取passdb.tdb数据库文件。
  pdbedit –Lv：列出Samba用户列表的详细信息。
  pdbedit –c “[D]” –u username：暂停该Samba用户的账号。
  pdbedit –c “[]” –u username：恢复该Samba用户的账号。
3. ldapsam：该方式则是基于LDAP的账户管理方式来验证用户。首先要建立LDAP服务，然后设置“passdb backend = ldapsam:ldap://LDAP Server”

encrypt passwords = yes/no
说明：是否将认证密码加密。因为现在windows操作系统都是使用加密密码，所以一般要开启此项。不过配置文件默认已开启。

smb passwd file = /etc/samba/smbpasswd
说明：用来定义samba用户的密码文件。smbpasswd文件如果没有那就要手工新建。

username map = /etc/samba/smbusers
说明：用来定义用户名映射，比如可以将root换成administrator、admin等。不过要事先在smbusers文件中定义好。比如：root = administrator admin，这样就可以用administrator或admin这两个用户来代替root登陆Samba Server，更贴近windows用户的习惯。

guest account = nobody
说明：用来设置guest用户名。

socket options = TCP_NODELAY SO_RCVBUF=8192 SO_SNDBUF=8192
说明：用来设置服务器和客户端之间会话的Socket选项，可以优化传输速度。

domain master = yes/no
说明：设置Samba服务器是否要成为网域主浏览器，网域主浏览器可以管理跨子网域的浏览服务。

local master = yes/no
说明：local master用来指定Samba Server是否试图成为本地网域主浏览器。如果设为no，则永远不会成为本地网域主浏览器。但是即使设置为yes，也不等于该Samba Server就能成为主浏览器，还需要参加选举。

preferred master = yes/no
说明：设置Samba Server一开机就强迫进行主浏览器选举，可以提高Samba Server成为本地网域主浏览器的机会。如果该参数指定为yes时，最好把domain master也指定为yes。使用该参数时要注意：如果在本Samba Server所在的子网有其他的机器（不论是windows NT还是其他Samba Server）也指定为首要主浏览器时，那么这些机器将会因为争夺主浏览器而在网络上大发广播，影响网络性能。如果同一个区域内有多台Samba Server，将上面三个参数设定在一台即可。

os level = 200
说明：设置samba服务器的os level。该参数决定Samba Server是否有机会成为本地网域的主浏览器。os level从0到255，winNT的os level是32，win95/98的os level是1。Windows 2000的os level是64。如果设置为0，则意味着Samba Server将失去浏览选择。如果想让Samba Server成为PDC，那么将它的os level值设大些。

domain logons = yes/no
说明：设置Samba Server是否要做为本地域控制器。主域控制器和备份域控制器都需要开启此项。

logon . = %u.bat
说明：当使用者用windows客户端登陆，那么Samba将提供一个登陆档。如果设置成%u.bat，那么就要为每个用户提供一个登陆档。如果人比较多，那就比较麻烦。可以设置成一个具体的文件名，比如start.bat，那么用户登陆后都会去执行start.bat，而不用为每个用户设定一个登陆档了。这个文件要放置在[netlogon]的path设置的目录路径下。

wins support = yes/no
说明：设置samba服务器是否提供wins服务。

wins server = wins服务器IP地址
说明：设置Samba Server是否使用别的wins服务器提供wins服务。

wins proxy = yes/no
说明：设置Samba Server是否开启wins代理服务。

dns proxy = yes/no
说明：设置Samba Server是否开启dns代理服务。

load printers = yes/no
说明：设置是否在启动Samba时就共享打印机。

printcap name = cups
说明：设置共享打印机的配置文件。

printing = cups
说明：设置Samba共享打印机的类型。现在支持的打印系统有：bsd, sysv, plp, lprng, aix, hpux, qnx
```

#### 共享参数 [共享名]

```
[共享名]
 
comment = 任意字符串
说明：comment是对该共享的描述，可以是任意字符串。
 
path = 共享目录路径
说明：path用来指定共享目录的路径。可以用%u、%m这样的宏来代替路径里的unix用户和客户机的Netbios名，用宏表示主要用于[homes]共享域。例如：如果我们不打算用home段做为客户的共享，而是在/home/share/下为每个Linux用户以他的用户名建个目录，作为他的共享目录，这样path就可以写成：path = /home/share/%u; 。用户在连接到这共享时具体的路径会被他的用户名代替，要注意这个用户名路径一定要存在，否则，客户机在访问时会找不到网络路径。同样，如果我们不是以用户来划分目录，而是以客户机来划分目录，为网络上每台可以访问samba的机器都各自建个以它的netbios名的路径，作为不同机器的共享资源，就可以这样写：path = /home/share/%m 。
 
browseable = yes/no
说明：browseable用来指定该共享是否可以浏览。
 
writable = yes/no
说明：writable用来指定该共享路径是否可写。
 
available = yes/no
说明：available用来指定该共享资源是否可用。
 
admin users = 该共享的管理者
说明：admin users用来指定该共享的管理员（对该共享具有完全控制权限）。在samba 3.0中，如果用户验证方式设置成“security=share”时，此项无效。
例如：admin users =bobyuan，jane（多个用户中间用逗号隔开）。
 
valid users = 允许访问该共享的用户
说明：valid users用来指定允许访问该共享资源的用户。
例如：valid users = bobyuan，@bob，@tech（多个用户或者组中间用逗号隔开，如果要加入一个组就用“@+组名”表示。）
 
invalid users = 禁止访问该共享的用户
说明：invalid users用来指定不允许访问该共享资源的用户。
例如：invalid users = root，@bob（多个用户或者组中间用逗号隔开。）
 
write list = 允许写入该共享的用户
说明：write list用来指定可以在该共享下写入文件的用户。
例如：write list = bobyuan，@bob
 
public = yes/no
说明：public用来指定该共享是否允许guest账户访问。
 
guest ok = yes/no
说明：意义同“public”。
 
几个特殊共享：
[homes]
comment = Home Directories
browseable = no
writable = yes
valid users = %S
; valid users = MYDOMAIN\%S
 
[printers]
comment = All Printers
path = /var/spool/samba
browseable = no
guest ok = no
writable = no
printable = yes
 
[netlogon]
comment = Network Logon Service
path = /var/lib/samba/netlogon
guest ok = yes
writable = no
share modes = no
 
[Profiles]
path = /var/lib/samba/profiles
browseable = no
guest ok = yes
```

### 配置samba服务

#### 服务规划

系统分区时，单独划分一个/storage的分区，分区下有logger和shared两个文件夹;
logger文件夹/storage/logger下对应的管理员账号为logadmin，用户账号为loguser;
shared文件夹/storage/shared下对应的管理员账号为admin，用户账户号为shared;

#### 创建文件夹和用户

创建文件夹

```
# 创建文件夹
[root@Linuxidc-Server storage]# cd /storage
[root@Linuxidc-Server storage]# mkdir logger  shared
[root@Linuxidc-Server storage]# ls
total 0
drwxr-xr-x. 2 root root 6 Aug  3 10:12 logger
drwxr-xr-x. 2 root root 6 Aug  3 10:12 shared
```

创建用户

```
# 创建用户
[root@Linuxidc-Server storage]# useradd -s /sbin/nologin logadmin
[root@Linuxidc-Server storage]# useradd -s /sbin/nologin admin
[root@Linuxidc-Server storage]# useradd -g admin -s /sbin/nologin shared
[root@Linuxidc-Server storage]# cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
nobody:x:99:99:Nobody:/:/sbin/nologin
systemd-bus-proxy:x:999:998:systemd Bus Proxy:/:/sbin/nologin
systemd-network:x:192:192:systemd Network Management:/:/sbin/nologin
dbus:x:81:81:System message bus:/:/sbin/nologin
polkitd:x:998:997:User for polkitd:/:/sbin/nologin
tss:x:59:59:Account used by the trousers package to sandbox the tcsd daemon:/dev/null:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
postfix:x:89:89::/var/spool/postfix:/sbin/nologin
tcpdump:x:72:72::/:/sbin/nologin
logadmin:x:1000:1000::/home/logadmin:/sbin/nologin
loguser:x:1001:1000::/home/loguser:/sbin/nologin
admin:x:1002:1002::/home/admin:/sbin/nologin
shared:x:1003:1002::/home/shared:/sbin/nologin
```

建立samba用户

```
[root@Linuxidc-Server storage]# smbpasswd -a logadmin
New SMB password:
Retype new SMB password:
Added user logadmin.
[root@Linuxidc-Server storage]# smbpasswd -a loguser
New SMB password:
Retype new SMB password:
Added user loguser.
[root@Linuxidc-Server storage]# smbpasswd -a admin
New SMB password:
Retype new SMB password:
Added user admin.
[root@Linuxidc-Server storage]# smbpasswd -a shared
New SMB password:
Retype new SMB password:
Added user shared.
```

更改目录属性

```
[root@Linuxidc-Server storage]# chown logadmin.logadmin logger
[root@Linuxidc-Server storage]# chown admin.admin shared
[root@Linuxidc-Server storage]# chmod -R 777 logger
[root@Linuxidc-Server storage]# chmod -R 777 shared
```

#### 启动 samba 服务

1. 配置

以下就是一个可用的 `/etc/samba/smb.conf` 配置

```
#============================ Global Definitions ==============================

[global]
	workgroup = MYGROUP
	server string = Samba Server
	security = share
	passdb backend = tdbsam
	load printers = yes
	cups options = raw

#============================ Share Definitions ==============================

[homes]
	comment = Home Directories
	browseable = no
	writable = yes

[printers]
	comment = All Printers
	path = /var/spool/samba
	browseable = no
	guest ok = no
	writable = no
	printable = yes

[public]
	comment = public stuffs
	path = /home/public
	writable = yes
	printable = no
	browseable = yes
	read only = no
	public = yes
	guest ok = yes

```

2. 启动服务

* CentOS 6、Ubuntu 启动方式

执行以下命令：

```
sudo service samba restart # 启动 samba
```

* CentOS 7 启动方式

```
systemctl start smb.service # 启动 samba
systemctl enable smb.service # 激活
systemctl status smb.service # 查询 samba 状态（启动 samba 前后可以用查询验证）
```

* 脚本命令启动方式

```
/etc/init.d/smb restart
```

## FAQ

如果在 windows 访问 samba 路径，执行写操作时，出现 `目标文件夹访问被拒绝` 错误。

解决方法：为共享的目录分配写权限

例：将 samba 共享路径 `/home/public` 设为可读可写可执行

```
chmod -r 777 /home/public
```

## 资料

http://blog.51cto.com/yuanbin/115761
