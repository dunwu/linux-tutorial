---
title: Linux 文件查找和比较命令
date: 2018/02/27
categories:
  - linux
tags:
  - linux
  - command
---

# Linux 文件查找和比较命令

> 关键词：`diff`, `locate`/`slocate`, `find`, `which`, `whereis`

<!-- TOC depthFrom:2 depthTo:2 -->

- [比较文件 - diff](#比较文件---diff)
- [查找文件或目录 - locate/slocate](#查找文件或目录---locateslocate)
- [在指定目录下查找文件 - find](#在指定目录下查找文件---find)
- [查找命令的绝对路径 - which](#查找命令的绝对路径---which)
- [查找命令的程序、源代码等相关文件 - whereis](#查找命令的程序源代码等相关文件---whereis)

<!-- /TOC -->

## 比较文件 - diff

> diff 命令在最简单的情况下，比较给定的两个文件的不同。如果使用“-”代替“文件”参数，则要比较的内容将来自标准输入。diff 命令是以逐行的方式，比较文本文件的异同处。如果该命令指定进行目录的比较，则将会比较该目录中具有相同文件名的文件，而不会对其子目录文件进行任何比较操作。
>
> 参考：http://man.linuxde.net/diff

示例：

```sh
diff /usr/li test.txt     # 比较文件
```

## 查找文件或目录 - locate/slocate

> locate 命令和 slocate 命令都用来查找文件或目录。
>
> locate 命令其实是 find -name 的另一种写法，但是要比后者快得多，原因在于它不搜索具体目录，而是搜索一个数据库/var/lib/locatedb，这个数据库中含有本地所有文件信息。Linux 系统自动创建这个数据库，并且每天自动更新一次，所以使用 locate 命令查不到最新变动过的文件。为了避免这种情况，可以在使用 locate 之前，先使用 updatedb 命令，手动更新数据库。
>
> 参考：http://man.linuxde.net/locate_slocate

示例：

```sh
locate pwd      # 查找和 pwd 相关的所有文件
locate /etc/sh  # 搜索 etc 目录下所有以 sh 开头的文件
```

## 在指定目录下查找文件 - find

> find 命令用来在指定目录下查找文件。任何位于参数之前的字符串都将被视为欲查找的目录名。如果使用该命令时，不设置任何参数，则 find 命令将在当前目录下查找子目录与文件。并且将查找到的子目录和文件全部进行显示。
>
> 参考：http://man.linuxde.net/find

```sh
# 当前目录搜索所有文件，文件内容 包含 “140.206.111.111” 的内容
find . -type f -name "*" | xargs grep "140.206.111.111"

# 列出当前目录及子目录下所有文件和文件夹
find .

# 在 /home 目录下查找以 .txt 结尾的文件名
find /home -name "*.txt"
# 同上，但忽略大小写
find /home -iname "*.txt"

# 当前目录及子目录下查找所有以 .txt 和 .pdf 结尾的文件
find . -name "*.txt" -o -name "*.pdf"

# 匹配文件路径或者文件
find /usr/ -path "*local*"

# 基于正则表达式匹配文件路径
find . -regex ".*\(\.txt\|\.pdf\)$"
# 同上，但忽略大小写
find . -iregex ".*\(\.txt\|\.pdf\)$"

# 找出 /home 下不是以 .txt 结尾的文件
find /home ! -name "*.txt"
```

## 查找命令的绝对路径 - which

> which 命令用于查找并显示给定命令的绝对路径，环境变量 PATH 中保存了查找命令时需要遍历的目录。which 指令会在环境变量$PATH 设置的目录里查找符合条件的文件。也就是说，使用 which 命令，就可以看到某个系统命令是否存在，以及执行的到底是哪一个位置的命令。
>
> 参考：http://man.linuxde.net/which

示例：

```sh
which pwd # 查找命令的路径
```

说明：which 是根据使用者所配置的  PATH 变量内的目录去搜寻可运行档的！所以，不同的  PATH 配置内容所找到的命令当然不一样的！

```sh
[root@localhost ~]# which cd
cd: shell built-in command
```

cd 这个常用的命令竟然找不到啊！为什么呢？这是因为 cd 是 bash 内建的命令！ 但是 which 默认是找 PATH 内所规范的目录，所以当然一定找不到的！

## 查找命令的程序、源代码等相关文件 - whereis

> whereis 命令用来定位指令的二进制程序、源代码文件和 man 手册页等相关文件的路径。
>
> whereis 命令只能用于程序名的搜索，而且只搜索二进制文件（参数-b）、man 说明文件（参数-m）和源代码文件（参数-s）。如果省略参数，则返回所有信息。
>
> 参考：http://man.linuxde.net/whereis

示例：

```sh
whereis git # 将相关的文件都查找出来
```
