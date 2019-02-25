# Linux 典型运维应用

> :bulb: 如果没有特殊说明，本文的案例都是针对 Centos 发行版本。

## 网络操作

### 无法访问外网域名

（1）在 hosts 中添加本机实际 IP 和本机实际域名的映射

```bash
echo "192.168.0.1 hostname" >> /etc/hosts
```

如果不知道本机域名，使用 `hostname` 命令查一下；如果不知道本机实际 IP，使用 `ifconfig` 查一下。

（2）配置信赖的 DNS 服务器

执行 `vi /etc/resolv.conf` ，添加以下内容：

```bash
nameserver 114.114.114.114
nameserver 8.8.8.8
```

> 114.114.114.114 是国内老牌 DNS
>
> 8.8.8.8 是 Google DNS
>
> 👉 参考：[公共 DNS 哪家强](https://www.zhihu.com/question/32229915)

（3）测试一下能否 ping 通 www.baidu.com

### 开启、关闭防火墙

```bash
# 开启防火墙 22 端口
iptables -I INPUT -p tcp --dport 22 -j accept

# 彻底关闭防火墙
sudo systemctl status firewalld.service
sudo systemctl stop firewalld.service
sudo systemctl disable firewalld.service
```

## 系统维护

### 使用 NTP 进行时间同步

（1）先安装时钟同步工具 ntp

```
yum -y install ntp
```

ntp 的配置文件路径为： `/etc/ntp.conf`

（2）启动 NTP 服务

```bash
systemctl start ntpd.service
```

（3）放开防火墙 123 端口

NTP 服务的端口是 123,使用的是 udp 协议，所以 NTP 服务器的防火墙必须对外开放 udp 123 这个端口。

```
/sbin/iptables -A INPUT -p UDP -i eth0 -s 192.168.0.0/24 --dport 123 -j ACCEPT
```

（4）执行时间同步

```
/usr/sbin/ntpdate ntp.sjtu.edu.cn
```

ntp.sjtu.edu.cn 是上海交通大学 ntp 服务器。

（5）自动定时同步时间

执行如下命令，就可以在每天凌晨 3 点同步系统时间：

```
echo "* 3 * * * /usr/sbin/ntpdate ntp.sjtu.edu.cn" >> /etc/crontab
systemctl restart crond.service
```

> :point_right: 参考：https://www.cnblogs.com/quchunhui/p/7658853.html

## 配置

### 设置 Linux 启动模式

1. 停机(记得不要把 initdefault 配置为 0，因为这样会使 Linux 不能启动)
2. 单用户模式，就像 Win9X 下的安全模式
3. 多用户，但是没有 NFS
4. 完全多用户模式，准则的运行级
5. 通常不用，在一些特殊情况下可以用它来做一些事情
6. X11，即进到 X-Window 系统
7. 重新启动 (记得不要把 initdefault 配置为 6，因为这样会使 Linux 不断地重新启动)

设置方法：

```sh
$ sed -i 's/id:5:initdefault:/id:3:initdefault:/' /etc/inittab
```
