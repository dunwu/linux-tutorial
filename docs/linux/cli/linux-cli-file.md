# Linux 文件内容查看编辑

> 关键词：`cat`, `head`, `tail`, `more`, `less`, `sed`, `vi`, `grep`

## 1. Linux 文件内容查看编辑要点

- 连接文件并打印到标准输出设备 - 使用 [cat](#cat)
- 显示指定文件的开头若干行 - 使用 [head](#head)
- 显示指定文件的末尾若干行，常用于实时打印日志文件内容 - 使用 [tail](#tail)
- 显示文件内容，每次显示一屏 - 使用 [more](#more)
- 显示文件内容，每次显示一屏 - 使用 [less](#less)
- 自动编辑一个或多个文件；简化对文件的反复操作；编写转换程序等 - 使用 [sed](#sed)
- 文本编辑器 - 使用 [vi](#vi)
- 使用正则表达式搜索文本，并把匹配的行打印出来 - 使用 [grep](#grep)

## 2. 命令常见用法

### 2.1. cat

> cat 命令用于连接文件并打印到标准输出设备上。
>
> 参考：http://man.linuxde.net/cat

示例：

```bash
cat m1              # 在屏幕上显示文件 ml 的内容
cat m1 m2           # 同时显示文件 ml 和 m2 的内容
cat m1 m2 > file    # 将文件 ml 和 m2 合并后放入文件 file 中
```

### 2.2. head

> head 命令用于显示文件的开头内容。在默认情况下，head 命令显示文件的头部 10 行内容。
>
> 参考：http://man.linuxde.net/head

### 2.3. tail

> tail 命令用于显示文件的尾部内容。在默认情况下，tail 命令显示文件的尾部 10 行内容。如果给定的文件不止一个，则在显示的每个文件前面加一个文件名标题。如果没有指定文件或者文件名为“-”，则读取标准输入。
>
> 参考：http://man.linuxde.net/tail

示例：

```bash
tail file           # 显示文件file的最后10行
tail -n +20 file    # 显示文件file的内容，从第20行至文件末尾
tail -c 10 file     # 显示文件file的最后10个字符
```

### 2.4. more

> more 命令是一个基于 vi 编辑器文本过滤器，它以全屏幕的方式按页显示文本文件的内容，支持 vi 中的关键字定位操作。more 名单中内置了若干快捷键，常用的有 H（获得帮助信息），Enter（向下翻滚一行），空格（向下滚动一屏），Q（退出命令）。
>
> 该命令一次显示一屏文本，满屏后停下来，并且在屏幕的底部出现一个提示信息，给出至今己显示的该文件的百分比：--More--（XX%）可以用下列不同的方法对提示做出回答：
>
> - 按 Space 键：显示文本的下一屏内容。
> - 按 Enier 键：只显示文本的下一行内容。
> - 按斜线符|：接着输入一个模式，可以在文本中寻找下一个相匹配的模式。
> - 按 H 键：显示帮助屏，该屏上有相关的帮助信息。
> - 按 B 键：显示上一屏内容。
> - 按 Q 键：退出 rnore 命令。
>
> 参考：http://man.linuxde.net/more

示例：

```bash
# 显示文件 file 的内容，但在显示之前先清屏，并且在屏幕的最下方显示完核的百分比。
more -dc file

# 显示文件 file 的内容，每 10 行显示一次，而且在显示之前先清屏。
more -c -10 file
```

### 2.5. less

less 命令的作用与 more 十分相似，都可以用来浏览文字档案的内容，不同的是 less 命令允许用户向前或向后浏览文件，而 more 命令只能向前浏览。用 less 命令显示文件时，用 PageUp 键向上翻页，用 PageDown 键向下翻页。要退出 less 程序，应按 Q 键。

示例：

```bash
less /var/log/shadowsocks.log
```

### 2.6. sed

> sed 是一种流编辑器，它是文本处理工具，能够完美的配合正则表达式使用，功能不同凡响。处理时，把当前处理的行存储在临时缓冲区中，称为“模式空间”（pattern space），接着用 sed 命令处理缓冲区中的内容，处理完成后，把缓冲区的内容送往屏幕。接着处理下一行，这样不断重复，直到文件末尾。文件内容并没有改变，除非你使用重定向存储输出。Sed 主要用来自动编辑一个或多个文件；简化对文件的反复操作；编写转换程序等。
>
> 参考：http://man.linuxde.net/sed

示例：

```bash
# 替换文本中的字符串
sed 's/book/books/' file

# -n 选项 和 p 命令 一起使用表示只打印那些发生替换的行
sed -n 's/test/TEST/p' file

# 直接编辑文件选项 -i ，会匹配 file 文件中每一行的第一个 book 替换为 books
sed -i 's/book/books/g' file

# 使用后缀 /g 标记会替换每一行中的所有匹配
sed 's/book/books/g' file

# 删除空白行
sed '/^$/d' file

# 删除文件的第2行
sed '2d' file

# 删除文件的第2行到末尾所有行
sed '2,$d' file

# 删除文件最后一行
sed '$d' file

# 删除文件中所有开头是test的行
sed '/^test/'d file
```

### 2.7. vi

> vi 命令是 UNIX 操作系统和类 UNIX 操作系统中最通用的全屏幕纯文本编辑器。Linux 中的 vi 编辑器叫 vim，它是 vi 的增强版（vi Improved），与 vi 编辑器完全兼容，而且实现了很多增强功能。
>
> 参考：http://man.linuxde.net/vi
>
> 引申阅读：[Vim 入门指南](https://github.com/dunwu/OS/blob/master/docs/vim.md)

### 2.8. grep

> grep（global search regular expression(RE) and print out the line，全面搜索正则表达式并把行打印出来）是一种强大的文本搜索工具，它能使用正则表达式搜索文本，并把匹配的行打印出来。
>
> 参考：http://man.linuxde.net/grep

示例：

```bash
# 在多级目录中对文本递归搜索(程序员搜代码的最爱）:
$ grep "class" . -R -n

# 忽略匹配样式中的字符大小写
$ echo "hello world" | grep -i "HELLO"

# 匹配多个模式:
$ grep -e "class" -e "vitural" file

# 只在目录中所有的.php和.html文件中递归搜索字符"main()"
$ grep "main()" . -r --include *.{php,html}

# 在搜索结果中排除所有README文件
$ grep "main()" . -r --exclude "README"

# 在搜索结果中排除filelist文件列表里的文件
$ grep "main()" . -r --exclude-from filelist
```

## 3. 参考资料

- [Linux 命令大全](http://man.linuxde.net/)
