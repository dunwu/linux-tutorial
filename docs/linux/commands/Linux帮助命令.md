---
title: Linux 帮助命令
date: 2018/09/26
categories:
  - linux
tags:
  - linux
  - command
---

# Linux 帮助命令

> 关键词：`help`, `whatis`, `info`, `man`, `which`, `whereis`

<!-- TOC depthFrom:2 depthTo:2 -->

- [help](#help)
- [whatis](#whatis)
- [info](#info)
- [man](#man)
- [which](#which)
- [whereis](#whereis)

<!-- /TOC -->

## help

> help 命令用于显示 Shell 内部命令的帮助信息。而对于外部命令的帮助信息只能使用 man 或者 info 命令查看。
>
> 参考：http://man.linuxde.net/help

## whatis

> whatis 用于查询一个命令执行什么功能。
>
> 参考：http://man.linuxde.net/whatis

## info

> info 是 Linux 下 info 格式的帮助指令。
>
> 参考：http://man.linuxde.net/info

## man

> man 命令是 Linux 下的帮助指令，通过 man 指令可以查看 Linux 中的指令帮助、配置文件帮助和编程帮助等信息。
>
> 参考：http://man.linuxde.net/man

## which

> which 命令用于查找并显示给定命令的绝对路径，环境变量 PATH 中保存了查找命令时需要遍历的目录。
>
> 参考：http://man.linuxde.net/which

示例：

```sh
# which pwd
/bin/pwd
```

## whereis

> whereis 命令用来定位指令的二进制程序、源代码文件和 man 手册页等相关文件的路径。
>
> 参考：http://man.linuxde.net/whereis

示例：

```sh
# whereis git
git: /usr/bin/git /usr/share/man/man1/git.1.gz
```
