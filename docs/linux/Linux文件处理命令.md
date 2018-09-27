---
title: Linux 文件处理命令
date: 2018/02/27
categories:
  - linux
tags:
  - linux
  - command
---

# Linux 文件处理命令

> 关键词：`touch`, `ln`, `rename`

<!-- TOC depthFrom:2 depthTo:2 -->

- [创建空文件 - touch](#创建空文件---touch)
- [为文件创建连接 - ln](#为文件创建连接---ln)
- [批量重命名 - rename](#批量重命名---rename)

<!-- /TOC -->

## 创建空文件 - touch

> touch 命令有两个功能：一是用于把已存在文件的时间标签更新为系统当前的时间（默认方式），它们的数据将原封不动地保留下来；二是用来创建空文件。
>
> 参考：http://man.linuxde.net/touch

示例：

```
touch ex2
```

## 为文件创建连接 - ln

> ln 命令用来为文件创建连接，连接类型分为硬连接和符号连接两种，默认的连接类型是硬连接。如果要创建符号连接必须使用"-s"选项。
>
> 注意：符号链接文件不是一个独立的文件，它的许多属性依赖于源文件，所以给符号链接文件设置存取权限是没有意义的。
>
> 参考：http://man.linuxde.net/ln

示例：

```sh
# 将目录 /usr/mengqc/mub1 下的文件 m2.c 链接到目录 /usr/liu 下的文件 a2.c
cd /usr/mengqc
ln /mub1/m2.c /usr/liu/a2.c

# 在目录 /usr/liu 下建立一个符号链接文件 abc，使它指向目录 /usr/mengqc/mub1
# 执行该命令后，/usr/mengqc/mub1 代表的路径将存放在名为 /usr/liu/abc 的文件中
ln -s /usr/mengqc/mub1 /usr/liu/abc
```

## 批量重命名 - rename

> rename 命令用字符串替换的方式批量重命名。
>
> 参考：http://man.linuxde.net/rename

示例：

```sh
# 将 main1.c 重命名为 main.c
rename main1.c main.c main1.c

rename "s/AA/aa/" *             # 把文件名中的 AA 替换成 aa
rename "s//.html//.php/" *      # 把 .html 后缀的改成 .php 后缀
rename "s/$//.txt/" *           # 把所有的文件名都以 txt 结尾
rename "s//.txt//" *            # 把所有以 .txt 结尾的文件名的.txt 删掉
```
