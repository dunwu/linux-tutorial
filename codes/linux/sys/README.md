# 脚本使用说明

> 建议按照顺序执行本文脚本。

<!-- TOC depthFrom:2 depthTo:3 -->

- [替换 yum repo 源](#替换-yum-repo-源)
- [安装基本工具（可选）](#安装基本工具可选)
- [安装常见 lib](#安装常见-lib)
- [关闭防火墙](#关闭防火墙)
- [设置 DNS](#设置-dns)
- [设置 ntp](#设置-ntp)

<!-- /TOC -->

## 替换 yum repo 源

由于 CentOS 默认 yum 源，访问速度很慢，所以推荐使用国内镜像。

使用方法：执行以下任意命令即可执行脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/sys/yum/change-yum-repo.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/sys/yum/change-yum-repo.sh | bash
```

## 安装基本工具（可选）

工具清单（可以根据需要，在 install-tools.sh 中把不需要的工具注掉）：

```
# 核心工具：df、du、chkconfig
# 网络工具：ifconfig、netstat、route、iptables
# IP工具：ip、ss、ping、tracepath、traceroute
# DNS工具：dig、host、nslookup、whois
# 端口工具：lsof、nc、telnet
# 下载工具：curl、wget
# 编辑工具：emacs、vim
# 流量工具：iftop、nethogs
# 抓包工具：tcpdump
# 压缩工具：unzip、zip
# 版本控制工具：git、subversion
```

使用方法：执行以下任意命令即可执行脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/sys/install-tools.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/sys/install-tools.sh | bash
```

## 安装常见 lib

lib 清单（可以根据需要，在 install-libs.sh 中把不需要的工具注掉）：

```
# gcc gcc-c++ kernel-devel libtool
# openssl openssl-devel
# zlib zlib-devel
# pcre
```

使用方法：执行以下任意命令即可执行脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/sys/install-libs.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/sys/install-libs.sh | bash
```

## 关闭防火墙

使用方法：执行以下任意命令即可执行脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/sys/stop-firewall.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/sys/stop-firewall.sh | bash
```

## 设置 DNS

使用方法：执行以下任意命令即可执行脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/sys/set-dns.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/sys/set-dns.sh | bash
```

## 设置 ntp

使用方法：执行以下任意命令即可执行脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/sys/set-ntp.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/sys/set-ntp.sh | bash
```
