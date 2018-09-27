---
title: Linux 文件权限管理命令
date: 2018/02/27
categories:
  - linux
tags:
  - linux
  - command
---

# Linux 文件权限管理命令

> 关键词：`chmod`, `chown`, `stat`, `file`

<!-- TOC depthFrom:2 depthTo:2 -->

- [设置文件或目录的权限 - chmod](#设置文件或目录的权限---chmod)
- [设置文件或目录的拥有者或所属群组 - chown](#设置文件或目录的拥有者或所属群组---chown)
- [显示文件的详细信息 - stat](#显示文件的详细信息---stat)
- [显示文件类型 - file](#显示文件类型---file)

<!-- /TOC -->

## 设置文件或目录的权限 - chmod

> chmod 命令用来变更文件或目录的权限。在 UNIX 系统家族里，文件或目录权限的控制分别以读取、写入、执行 3 种一般权限来区分，另有 3 种特殊权限可供运用。用户可以使用 chmod 指令去变更文件与目录的权限，设置方式采用文字或数字代号皆可。符号连接的权限无法变更，如果用户对符号连接修改权限，其改变会作用在被连接的原始文件。
>
> 参考：http://man.linuxde.net/chmod

知识扩展：

Linux 用 户分为：拥有者、组群(Group)、其他（other），Linux 系统中，预设的情況下，系统中所有的帐号与一般身份使用者，以及 root 的相关信 息， 都是记录在`/etc/passwd`文件中。每个人的密码则是记录在`/etc/shadow`文件下。 此外，所有的组群名称记录在`/etc/group`內！

linux 文件的用户权限的分析图

```bash
  -rw-r--r--   1 user  staff   651 Oct 12 12:53 .gitmodules
# ↑╰┬╯╰┬╯╰┬╯
# ┆ ┆  ┆  ╰┈ 0 其他人
# ┆ ┆  ╰┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈ g 属组
# ┆ ╰┈┈┈┈ u 属组
# ╰┈┈ 第一个字母 `d` 代表目录，`-` 代表普通文件
```

例：rwx 　 rw-　 r--

r=读取属性　　//值＝ 4  
w=写入属性　　//值＝ 2  
x=执行属性　　//值＝ 1

示例：

```sh
chmod u+x,g+w f01　　# 为文件f01设置自己可以执行，组员可以写入的权限
chmod u=rwx,g=rw,o=r f01
chmod 764 f01
chmod a+x f01　　    # 对文件f01的u,g,o都设置可执行属性

# 将/home/wwwroot/里的所有文件和文件夹设置为755权限
chmod -R  755 /home/wwwroot/*
```

## 设置文件或目录的拥有者或所属群组 - chown

> chown 命令改变某个文件或目录的所有者和所属的组，该命令可以向某个用户授权，使该用户变成指定文件的所有者或者改变文件所属的组。用户可以是用户或者是用户 D，用户组可以是组名或组 id。文件名可以使由空格分开的文件列表，在文件名中可以包含通配符。
>
> 只有文件拥有者和超级用户才可以便用该命令。
>
> 参考：http://man.linuxde.net/chown

示例：

```sh
# 将目录/usr/meng及其下面的所有文件、子目录的文件主改成 liu
chown -R liu /usr/meng
```

## 显示文件的详细信息 - stat

> stat 命令用于显示文件的状态信息。stat 命令的输出信息比 ls 命令的输出信息要更详细。
>
> 参考：http://man.linuxde.net/stat

示例：

```sh
stat myfile
```

## 显示文件类型 - file

> file 命令用来探测给定文件的类型。file 命令对文件的检查分为文件系统、魔法幻数检查和语言检查 3 个过程。
>
> 参考：http://man.linuxde.net/file

示例：

```sh
file install.log          # 显示文件类型
file -b install.log       # 不显示文件名称
file -i install.log       # 显示 MIME 类型
file -L /var/spool/mail   # 显示符号链接的文件类型
```
