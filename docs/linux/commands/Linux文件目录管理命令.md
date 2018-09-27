---
title: Linux 文件目录管理命令
date: 2018/02/27
categories:
  - linux
tags:
  - linux
  - command
---

# Linux 文件目录管理命令

> 关键词：`cd`, `ls`, `pwd`, `mkdir`, `rmdir`, `tree`, `cp`, `mv`, `rm`

<!-- TOC depthFrom:2 depthTo:2 -->

- [切换目录 - cd](#切换目录---cd)
- [显示目录信息 - ls](#显示目录信息---ls)
- [显示当前目录的绝对路径 - pwd](#显示当前目录的绝对路径---pwd)
- [创建目录 - mkdir](#创建目录---mkdir)
- [删除空目录 - rmdir](#删除空目录---rmdir)
- [树状显示目录的内容 - tree](#树状显示目录的内容---tree)
- [复制文件或目录 - cp](#复制文件或目录---cp)
- [移动文件或目录 - mv](#移动文件或目录---mv)
- [删除文件或目录 - rm](#删除文件或目录---rm)

<!-- /TOC -->

## 切换目录 - cd

> cd 命令用来切换工作目录。
>
> 参考：http://man.linuxde.net/cd

示例：

```sh
cd          # 切换到用户主目录
cd ~        # 切换到用户主目录
cd -        # 切换到上一个工作目录
cd ..       # 切换到上级目录
cd ../..    # 切换到上两级目录
```

## 显示目录信息 - ls

> ls 命令用来显示目录信息。
>
> 参考：http://man.linuxde.net/ls

示例：

```sh
ls        # 列出当前目录可见文件
ls -l     # 列出当前目录可见文件详细信息
ls -la    # 列出所有文件（包括隐藏）的详细信息
ls -lh    # 列出详细信息并以可读大小显示文件大小
ls -lt    # 按时间列出文件和文件夹详细信息
ls -ltr   # 按修改时间列出文件和文件夹详细信息
ls --color=auto     # 列出文件并标记颜色分类
```

## 显示当前目录的绝对路径 - pwd

> pwd 命令用来显示当前目录的绝对路径。
>
> 参考：http://man.linuxde.net/pwd

## 创建目录 - mkdir

> mkdir 命令用来创建目录。
>
> 参考：http://man.linuxde.net/mkdir

示例：

```sh
# 在当前目录中创建 zp 和 zp 的子目录 test
mkdir -p zp/test

# 在当前目录中创建 zp 和 zp 的子目录 test；权限设置为文件主可读、写、执行，同组用户可读和执行，其他用户无权访问
mkdir -p -m 750 zp/test
```

## 删除空目录 - rmdir

> rmdir 命令用来删除空目录。
>
> 参考：http://man.linuxde.net/rmdir

示例：

```sh
# 删除子目录 test 和其父目录 zp
rmdir -p zp/test
```

## 树状显示目录的内容 - tree

> tree 命令以树状显示目录的内。
>
> 参考：http://man.linuxde.net/tree

示例：

```sh
# 列出目录 /private 第一级文件名
tree /private -L 1
/private/
├── etc
├── tftpboot
├── tmp
└── var

# 忽略文件夹
tree -I node_modules            # 忽略当前目录文件夹 node_modules
tree -P node_modules            # 列出当前目录文件夹 node_modules 的目录结构
tree -P node_modules -L 2       # 显示目录 node_modules 两层的目录树结构
tree -L 2 > /home/www/tree.txt  # 当前目录结果存到 tree.txt 文件中

# 忽略多个文件夹
tree -I 'node_modules|icon|font' -L 2
```

## 复制文件或目录 - cp

> cp 命令用来将一个或多个源文件或者目录复制到指定的目的文件或目录。它可以将单个源文件复制成一个指定文件名的具体的文件或一个已经存在的目录下。cp 命令还支持同时复制多个文件，当一次复制多个文件时，目标文件参数必须是一个已经存在的目录，否则将出现错误。
>
> 参考：http://man.linuxde.net/cp

示例：

### 参数

- 源文件：制定源文件列表。默认情况下，cp 命令不能复制目录，如果要复制目录，则必须使用`-R`选项；
- 目标文件：指定目标文件。当“源文件”为多个文件时，要求“目标文件”为指定的目录。

示例：

```sh
# 将文件 file 复制到目录 /usr/men/tmp 下，并改名为 file1
cp file /usr/men/tmp/file1

# 将目录 /usr/men下的所有文件及其子目录复制到目录 /usr/zh 中
cp -r /usr/men /usr/zh

# 强行将 /usr/men下的所有文件复制到目录 /usr/zh 中，无论是否有文件重复
cp -rf /usr/men/* /usr/zh

# 将目录 /usr/men 中的以 m 打头的所有 .c 文件复制到目录 /usr/zh 中
cp -i /usr/men m*.c /usr/zh
```

## 移动文件或目录 - mv

> mv 命令用来对文件或目录重新命名，或者将文件从一个目录移到另一个目录中。source 表示源文件或目录，target 表示目标文件或目录。如果将一个文件移到一个已经存在的目标文件中，则目标文件的内容将被覆盖。
>
> 参考：http://man.linuxde.net/mv

示例：

```sh
mv file1.txt /home/office/                      # 移动单个文件
mv file2.txt file3.txt file4.txt /home/office/  # 移动多个文件
mv *.txt /home/office/                          # 移动所有 txt 文件
mv dir1/ /home/office/                          # 移动目录
mv /usr/men/* .                                 # 将指定目录中的所有文件移到当前目录中

mv file1.txt file2.txt          # 重命名文件
mv dir1/ dir2/                  # 重命名目录
mv -v *.txt /home/office        # 打印移动信息
mv -i file1.txt /home/office    # 提示是否覆盖文件

mv -uv *.txt /home/office       # 源文件比目标文件新时才执行更新
mv -vn *.txt /home/office       # 不要覆盖任何已存在的文件
mv -f *.txt /home/office        # 无条件覆盖已经存在的文件
mv -bv *.txt /home/office       # 复制时创建备份
```

## 删除文件或目录 - rm

> rm 命令可以删除一个目录中的一个或多个文件或目录，也可以将某个目录及其下属的所有文件及其子目录均删除掉。对于链接文件，只是删除整个链接文件，而原有文件保持不变。
>
> 参考：http://man.linuxde.net/rm

```sh
rm test.txt               # 删除文件
rm -i test.txt test2.txt  # 交互式删除文件
rm -r *                   # 删除当前目录下的所有文件和目录
rm -r testdir             # 删除目录下的所有文件和目录
rm -rf testdir            # 强制删除目录下的所有文件和目录
rm -v testdir             # 显示当前删除操作的详情
```
