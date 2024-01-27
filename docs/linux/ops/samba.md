# Samba 应用

> samba 是在 Linux 和 UNIX 系统上实现 SMB 协议的一个免费软件。
>
> samba 提供了在不同计算机（即使操作系统不同）上共享服务的能力。
>
> 关键词：`samba`, `selinux`

## 1. 安装配置 samba

本文将以一个完整的示例来展示如何配置 samba 来实现 Linux 和 Windows 的文件共享。

目标：假设希望共享 Linux 服务器上的 /share/fs 目录。

### 1.1. 查看是否已经安装 samba

- CentOS：`rpm -qa | grep samba`
- Ubuntu：`dpkg -l | grep samba`

### 1.2. 安装 samba 工具

- CentOS：`yum install -y samba samba-client samba-common`
- Ubuntu：`sudo apt-get install -y samba samba-client`

### 1.3. 配置 samba

samba 服务的配置文件是 `/etc/samba/smb.conf`，如果没有则 samba 无法启动。

执行以下命令，编辑配置文件：

```bash
vim /etc/samba/smb.conf
```

修改配置如下：

```ini
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
        write list = @printadmin root
        force group = @printadmin
        create mask = 0664
        directory mask = 0775

[fs]
        comment = share folder
        path = /share/fs
        browseable = yes
        writable = yes
        read only = no
        guest ok = yes
        create mask = 0777
        directory mask = 0777
        public = yes
        valid users = root
```

> 说明：
>
> - 我在这里添加了一个 **[fs]** 标签，这就是共享区域的配置。
> - 这里设置 `path` 属性为 `/share/fs`，意味着准备共享 `/share/fs` 目录，需要根据实际需要设置路径。`/share/fs` 目录的权限要设置为 **777**：`chmod 777 /share/fs`。
> - `browseable`、`writable` 等属性就比较容易理解了，即配置共享目录的访问权限。
> - `valid users` 属性指定允许访问的用户，需要注意的是指定的用户必须是 Linux 机器上实际存在的用户。

### 1.4. 创建 samba 用户

创建的 samba 用户必须是 Linux 机器上实际存在的用户。

```bash
$ sudo smbpasswd -a root
New SMB password:
Retype new SMB password:
Added user root.
```

根据提示输入 samba 用户的密码。当 samba 服务成功安装、启动后，通过 Windows 系统访问机器共享目录时，就要输入这里配置的用户名、密码。

- 查看 samba 服务器中已拥有哪些用户 - `pdbedit -L`
- 删除 samba 服务中的某个用户 - `smbpasswd -x 用户名`

### 1.5. 启动 samba 服务

CentOS 6

```bash
$ sudo service samba restart  # 重启 samba
$ sudo service smb restart    # 重启 samba
```

CentOS 7

```bash
$ sudo systemctl start smb.service     # 启动 samba
$ sudo systemctl restart smb.service   # 重启 samba
$ sudo systemctl enable smb.service    # 设置开机自动启动
$ sudo systemctl status smb.service    # 查询 samba 状态
```

Ubuntu 16.04.3

```
$ sudo service smbd restart
```

### 1.6. 为 samba 添加防火墙规则

```
$ sudo firewall-cmd --permanent --zone=public --add-service=samba
$ sudo firewall-cmd --reload
```

### 1.7. 测试 samba 服务

```
$ smbclient //localhost/fs -U root
```

输入 samba 用户的密码，如果成功，就会进入 `smb: \>`。

### 1.8. 访问 samba 服务共享的目录

Windows：

访问：`\\<你的ip>\<你的共享路径>` ：

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20180920180928161334.png)

Mac：

与 Windows 类似，直接在 Finder 中访问 `smb://<你的ip>/<你的共享路径>` 即可。

## 2. 配置详解

### 2.1. samba 默认配置

你可以从 [这里](https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD) 获取到默认配置文件：

```
$ cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
$ wget "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD" -O /etc/samba/smb.conf
```

smb.conf 默认内容如下：

```ini
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

### 2.2. 全局参数 [global]

```ini
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

### 2.3. 共享参数 [共享名]

```ini
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

## 3. 常见问题

### 3.1. 你可能没有权限访问网络资源

问题现象：

- 出现 **NT_STATUS_ACCESS_DENIED** 错误
- Windows 下成功登陆 samba 后，点击共享目录仍然提示——你可能没有权限访问网络资源。

解决步骤：

1. 检查是否配置了防火墙规则

```bash
# 一种方法是强行关闭防火墙
$ sudo service iptables stop

# 另一种方法是配置防火墙规则
$ sudo firewall-cmd --permanent --zone=public --add-service=samba
$ sudo firewall-cmd --reload
```

2. 关闭 selinux

```bash
# 将 /etc/selinux/config 文件中的 SELINUX 设为 disabled
$ sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

# 重启生效
$ reboot
```

### 3.2. window 下对 samba 的清理操作

1. windows 清除访问 samba 局域网密码缓存
   - 在 dos 窗口中输入 `control userpasswords2` 或者 `control keymgr.dll`，然后【高级】/【密码管理】，删掉保存的该机器密码。
2. windows 清除连接的 linux 的 samba 服务缓存
   1. 打开 win 的命令行。
   2. 输入 net use，就会打印出当前缓存的连接上列表。
   3. 根据列表，一个个删除连接： net use 远程连接名称 /del；或者一次性全部删除：`net use * /del`。

## 4. 参考资料

- http://blog.51cto.com/yuanbin/115761
- https://www.jianshu.com/p/750be209a6f0
- https://github.com/judasn/Linux-Tutorial/blob/master/markdown-file/Samba.md
- https://blog.csdn.net/lan120576664/article/details/50396511
