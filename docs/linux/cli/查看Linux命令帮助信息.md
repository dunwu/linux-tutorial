# 查看 Linux 命令帮助信息

> Linux 中有非常多的命令，想全部背下来是很困难的事。所以，我认为学习 Linux 的第一步，就是了解如何快速检索命令说明。
>
> 关键词：`help`, `whatis`, `info`, `which`, `whereis`, `man`


## 1. 查看 Linux 命令帮助信息的要点

- 查看 Shell 内部命令的帮助信息 - 使用 [help](#help)
- 查看命令的简要说明 - 使用 [whatis](#whatis)
- 查看命令的详细说明 - 使用 [info](#info)
- 查看命令的位置 - 使用 [which](#which)
- 定位指令的二进制程序、源代码文件和 man 手册页等相关文件的路径 - 使用 [whereis](#whereis)
- 查看命令的帮助手册（包含说明、用法等信息） - 使用 [man](#man)
- 只记得部分命令关键字 - 使用 man -k

> 注：推荐一些 Linux 命令中文手册：
>
> - [Linux 命令大全](http://man.linuxde.net/)
> - [linux-command](https://github.com/jaywcjlove/linux-command)

## 2. 命令常见用法

### 2.1. help

> help 命令用于查看 Shell 内部命令的帮助信息。而对于外部命令的帮助信息只能使用 man 或者 info 命令查看。
>
> 参考：http://man.linuxde.net/help

### 2.2. whatis

> whatis 用于查询一个命令执行什么功能。
>
> 参考：http://man.linuxde.net/whatis

示例：

```bash
# 查看 man 命令的简要说明
$ whatis man

# 查看以 loca 开拓的命令的简要说明
$ whatis -w "loca*"
```

### 2.3. info

> info 是 Linux 下 info 格式的帮助指令。
>
> 参考：http://man.linuxde.net/info

示例：

```bash
# 查看 man 命令的详细说明
$ info man
```

### 2.4. which

> which 命令用于查找并显示给定命令的绝对路径，环境变量 PATH 中保存了查找命令时需要遍历的目录。which 指令会在环境变量$PATH 设置的目录里查找符合条件的文件。也就是说，使用 which 命令，就可以看到某个系统命令是否存在，以及执行的到底是哪一个位置的命令。
>
> 参考：http://man.linuxde.net/which

示例：

```bash
which pwd # 查找命令的路径
```

说明：which 是根据使用者所配置的 PATH 变量内的目录去搜寻可运行档的！所以，不同的 PATH 配置内容所找到的命令当然不一样的！

```bash
[root@localhost ~]# which cd
cd: shell built-in command
```

cd 这个常用的命令竟然找不到啊！为什么呢？这是因为 cd 是 bash 内建的命令！但是 which 默认是找 PATH 内所规范的目录，所以当然一定找不到的！

### 2.5. whereis

> whereis 命令用来定位指令的二进制程序、源代码文件和 man 手册页等相关文件的路径。
>
> whereis 命令只能用于程序名的搜索，而且只搜索二进制文件（参数-b）、man 说明文件（参数-m）和源代码文件（参数-s）。如果省略参数，则返回所有信息。
>
> 参考：http://man.linuxde.net/whereis

示例：

```bash
whereis git # 将相关的文件都查找出来
```

### 2.6. man

> man 命令是 Linux 下的帮助指令，通过 man 指令可以查看 Linux 中的指令帮助、配置文件帮助和编程帮助等信息。
>
> 参考：http://man.linuxde.net/man

示例：

```bash
$ man date # 查看 date 命令的帮助手册
$ man 3 printf # 查看 printf 命令的帮助手册中的第 3 类
$ man -k keyword # 根据命令中部分关键字来查询命令
```

#### 2.6.1. man 要点

在 man 的帮助手册中，可以使用 page up 和 page down 来上下翻页。

man 的帮助手册中，将帮助文档分为了 9 个类别，对于有的关键字可能存在多个类别中， 我们就需要指定特定的类别来查看；（一般我们查询 bash 命令，归类在 1 类中）。

man 页面的分类(常用的是分类 1 和分类 3)：

1. 可执行程序或 shell 命令
2. 系统调用(内核提供的函数)
3. 库调用(程序库中的函数)
4. 特殊文件(通常位于 /dev)
5. 文件格式和规范，如 /etc/passwd
6. 游戏
7. 杂项(包括宏包和规范，如 man(7)，groff(7))
8. 系统管理命令(通常只针对 root 用户)
9. 内核例程 [非标准]

前面说到使用 whatis 会显示命令所在的具体的文档类别，我们学习如何使用它

```bash
$ whatis printf
printf (1) - format and print data
printf (1p) - write formatted output
printf (3) - formatted output conversion
printf (3p) - print formatted output
printf [builtins](1) - bash built-in commands, see bash(1)
```

我们看到 printf 在分类 1 和分类 3 中都有；分类 1 中的页面是命令操作及可执行文件的帮助；而 3 是常用函数库说明；如果我们想看的是 C 语言中 printf 的用法，可以指定查看分类 3 的帮助：

```bash
$ man 3 printf
```

## 3. 参考资料

https://linuxtools-rst.readthedocs.io/zh_CN/latest/base/01_use_man.html
