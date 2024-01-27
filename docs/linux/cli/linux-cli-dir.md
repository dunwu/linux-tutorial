# Linux 文件目录管理

> 关键词：`cd`, `ls`, `pwd`, `mkdir`, `rmdir`, `tree`, `touch`, `ln`, `rename`, `stat`, `file`, `chmod`, `chown`, `locate`, `find`, `cp`, `scp`, `mv`, `rm`

## 1. Linux 文件目录工作机制

### 1.1. Linux 目录结构

linux 目录结构是树形结构，其根目录是 `/` 。一张思维导图说明各个目录的作用：

![img](https://raw.githubusercontent.com/dunwu/images/master/cs/os/linux/linux-folders.png)

### 1.2. Linux 文件属性

Linux 系统是一种典型的多用户系统，不同的用户处于不同的地位，拥有不同的权限。为了保护系统的安全性，Linux 系统对不同的用户访问同一文件（包括目录文件）的权限做了不同的规定。
在 Linux 中我们可以使用 ll 或者 ls –l 命令来显示一个文件的属性以及文件所属的用户和组，如：

```bash
$ ls -l
total 64
dr-xr-xr-x 2 root root 4096 Dec 14 2012 bin
dr-xr-xr-x 4 root root 4096 Apr 19 2012 boot
```

实例中，bin 文件的第一个属性用 `d` 表示。`d` 在 Linux 中代表该文件是一个目录文件。
在 Linux 中第一个字符代表这个文件是目录、文件或链接文件等等。

- 当为 `d` 则是目录
- 当为 `-` 则是文件；
- 若是 `l` 则表示为链接文档(link file)；
- 若是 `b` 则表示为装置文件里面的可供储存的接口设备(可随机存取装置)；
- 若是 `c` 则表示为装置文件里面的串行端口设备，例如键盘、鼠标(一次性读取装置)。

接下来的字符中，以三个为一组，且均为『rwx』 的三个参数的组合。其中，`r` 代表可读(read)、`w` 代表可写(write)、`x` 代表可执行(execute)。 要注意的是，这三个权限的位置不会改变，如果没有权限，就会出现减号 `-` 而已。

每个文件的属性由左边第一部分的 10 个字符来确定（如下图）。

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20180920180927171909.png)

从左至右用 0-9 这些数字来表示。

- 第 0 位确定文件类型
- 第 1-3 位确定属主（该文件的拥有者）拥有该文件的权限。
- 第 4-6 位确定属组（拥有者的同组用户）拥有该文件的权限。
- 第 7-9 位确定其他用户拥有该文件的权限。
- 第 1、4、7 位表示读权限，如果用"r"字符表示，则有读权限，如果用"-"字符表示，则没有读权限。
- 第 2、5、8 位表示写权限，如果用"w"字符表示，则有写权限，如果用"-"字符表示没有写权限。
- 第 3、6、9 位表示可执行权限，如果用"x"字符表示，则有执行权限，如果用"-"字符表示，则没有执行权限。

#### 1.2.1. Linux 文件属主和属组

```bash
$ ls -l
total 64
dr-xr-xr-x   2 root root 4096 Dec 14  2012 bin
dr-xr-xr-x   4 root root 4096 Apr 19  2012 boot
```

- 对于文件来说，它都有一个特定的拥有者，也就是对该文件具有所有权的用户。
- 同时，在 Linux 系统中，用户是按组分类的，一个用户属于一个或多个组。
- 文件拥有者以外的用户又可以分为文件拥有者的同组用户和其他用户。
- 因此，Linux 系统按文件拥有者、文件拥有者同组用户和其他用户来规定了不同的文件访问权限。
- 在以上实例中，bin 文件是一个目录文件，属主和属组都为 root，属主有可读、可写、可执行的权限；与属主同组的其他用户有可读和可执行的权限；其他用户也有可读和可执行的权限。

## 2. Linux 文件目录管理要点

### 2.1. 目录管理

- 切换目录 - 使用 [cd](#cd)
- 查看目录信息 - 使用 [ls](#ls)
- 显示当前目录的绝对路径 - 使用 [pwd](#pwd)
- 树状显示目录的内容 - 使用 [tree](#tree)
- 创建目录 - 使用 [mkdir](#mkdir)
- 删除目录 - 使用 [rmdir](#rmdir)

### 2.2. 文件管理

- 创建空文件 - 使用 [touch](#touch)
- 为文件创建连接 - 使用 [ln](#ln)
- 批量重命名 - 使用 [rename](#rename)
- 显示文件的详细信息 - 使用 [stat](#stat)
- 探测文件类型 - 使用 [file](#file)
- 设置文件或目录的权限 - 使用 [chmod](#chmod)
- 设置文件或目录的拥有者或所属群组 - 使用 [chown](#chown)
- 查找文件或目录 - 使用 [locate](#locate)
- 在指定目录下查找文件 - 使用 [find](#find)
- 查找命令的绝对路径 - 使用 [which](#which)
- 查找命令的程序、源代码等相关文件 - 使用 [whereis](#whereis)

### 2.3. 文件和目录通用管理

- 复制文件或目录 - 使用 [cp](#cp)
- 复制文件或目录到远程服务器 - 使用 [scp](#scp)
- 移动文件或目录 - 使用 [mv](#mv)
- 删除文件或目录 - 使用 [rm](#rm)

## 3. 命令常见用法

### 3.1. cd

> cd 命令用来切换工作目录。
>
> 参考：http://man.linuxde.net/cd

示例：

```bash
cd          # 切换到用户主目录
cd ~        # 切换到用户主目录
cd -        # 切换到上一个工作目录
cd ..       # 切换到上级目录
cd ../..    # 切换到上两级目录
```

### 3.2. ls

> ls 命令用来显示目录信息。
>
> 参考：http://man.linuxde.net/ls

示例：

```bash
ls        # 列出当前目录可见文件
ls -l     # 列出当前目录可见文件详细信息
ls -la    # 列出所有文件（包括隐藏）的详细信息
ls -lh    # 列出详细信息并以可读大小显示文件大小
ls -lt    # 按时间列出文件和文件夹详细信息
ls -ltr   # 按修改时间列出文件和文件夹详细信息
ls --color=auto     # 列出文件并标记颜色分类
```

### 3.3. pwd

> pwd 命令用来显示当前目录的绝对路径。
>
> 参考：http://man.linuxde.net/pwd

### 3.4. mkdir

> mkdir 命令用来创建目录。
>
> 参考：http://man.linuxde.net/mkdir

示例：

```bash
# 在当前目录中创建 zp 和 zp 的子目录 test
mkdir -p zp/test

# 在当前目录中创建 zp 和 zp 的子目录 test；权限设置为文件主可读、写、执行，同组用户可读和执行，其他用户无权访问
mkdir -p -m 750 zp/test
```

### 3.5. rmdir

> rmdir 命令用来删除空目录。
>
> 参考：http://man.linuxde.net/rmdir

示例：

```bash
# 删除子目录 test 和其父目录 zp
rmdir -p zp/test
```

### 3.6. tree

> tree 命令以树状显示目录的内。
>
> 参考：http://man.linuxde.net/tree

示例：

```bash
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

### 3.7. touch

> touch 命令有两个功能：一是用于把已存在文件的时间标签更新为系统当前的时间（默认方式），它们的数据将原封不动地保留下来；二是用来创建空文件。
>
> 参考：http://man.linuxde.net/touch

示例：

```
touch ex2
```

### 3.8. ln

> ln 命令用来为文件创建连接，连接类型分为硬连接和符号连接两种，默认的连接类型是硬连接。如果要创建符号连接必须使用"-s"选项。
>
> 🔔 注意：符号链接文件不是一个独立的文件，它的许多属性依赖于源文件，所以给符号链接文件设置存取权限是没有意义的。
>
> 参考：http://man.linuxde.net/ln

示例：

```bash
# 将目录 /usr/mengqc/mub1 下的文件 m2.c 链接到目录 /usr/liu 下的文件 a2.c
cd /usr/mengqc
ln /mub1/m2.c /usr/liu/a2.c

# 在目录 /usr/liu 下建立一个符号链接文件 abc，使它指向目录 /usr/mengqc/mub1
# 执行该命令后，/usr/mengqc/mub1 代表的路径将存放在名为 /usr/liu/abc 的文件中
ln -s /usr/mengqc/mub1 /usr/liu/abc
```

### 3.9. rename

> rename 命令用字符串替换的方式批量重命名。
>
> 参考：http://man.linuxde.net/rename

示例：

```bash
# 将 main1.c 重命名为 main.c
rename main1.c main.c main1.c

rename "s/AA/aa/" *             # 把文件名中的 AA 替换成 aa
rename "s//.html//.php/" *      # 把 .html 后缀的改成 .php 后缀
rename "s/$//.txt/" *           # 把所有的文件名都以 txt 结尾
rename "s//.txt//" *            # 把所有以 .txt 结尾的文件名的.txt 删掉
```

### 3.10. stat

> stat 命令用于显示文件的状态信息。stat 命令的输出信息比 ls 命令的输出信息要更详细。
>
> 参考：http://man.linuxde.net/stat

示例：

```bash
stat myfile
```

### 3.11. file

> file 命令用来探测给定文件的类型。file 命令对文件的检查分为文件系统、魔法幻数检查和语言检查 3 个过程。
>
> 参考：http://man.linuxde.net/file

示例：

```bash
file install.log          # 显示文件类型
file -b install.log       # 不显示文件名称
file -i install.log       # 显示 MIME 类型
file -L /var/spool/mail   # 显示符号链接的文件类型
```

### 3.12. chmod

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

```bash
chmod u+x,g+w f01　　# 为文件f01设置自己可以执行，组员可以写入的权限
chmod u=rwx,g=rw,o=r f01
chmod 764 f01
chmod a+x f01　　    # 对文件f01的u,g,o都设置可执行属性

# 将/home/wwwroot/里的所有文件和文件夹设置为755权限
chmod -R  755 /home/wwwroot/*
```

### 3.13. chown

> chown 命令改变某个文件或目录的所有者和所属的组，该命令可以向某个用户授权，使该用户变成指定文件的所有者或者改变文件所属的组。用户可以是用户或者是用户 D，用户组可以是组名或组 id。文件名可以使由空格分开的文件列表，在文件名中可以包含通配符。
>
> 只有文件拥有者和超级用户才可以便用该命令。
>
> 参考：http://man.linuxde.net/chown

示例：

```bash
# 将目录/usr/meng及其下面的所有文件、子目录的文件主改成 liu
chown -R liu /usr/meng
```

### 3.14. locate

> locate 命令和 slocate 命令都用来查找文件或目录。
>
> locate 命令其实是 find -name 的另一种写法，但是要比后者快得多，原因在于它不搜索具体目录，而是搜索一个数据库/var/lib/locatedb，这个数据库中含有本地所有文件信息。Linux 系统自动创建这个数据库，并且每天自动更新一次，所以使用 locate 命令查不到最新变动过的文件。为了避免这种情况，可以在使用 locate 之前，先使用 updatedb 命令，手动更新数据库。
>
> 参考：http://man.linuxde.net/locate_slocate

示例：

```bash
locate pwd      # 查找和 pwd 相关的所有文件
locate /etc/sh  # 搜索 etc 目录下所有以 sh 开头的文件
```

### 3.15. find

> find 命令用来在指定目录下查找文件。任何位于参数之前的字符串都将被视为欲查找的目录名。如果使用该命令时，不设置任何参数，则 find 命令将在当前目录下查找子目录与文件。并且将查找到的子目录和文件全部进行显示。
>
> 参考：http://man.linuxde.net/find

```bash
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

### 3.16. cp

> cp 命令用来将一个或多个源文件或者目录复制到指定的目的文件或目录。它可以将单个源文件复制成一个指定文件名的具体的文件或一个已经存在的目录下。cp 命令还支持同时复制多个文件，当一次复制多个文件时，目标文件参数必须是一个已经存在的目录，否则将出现错误。
>
> 参考：http://man.linuxde.net/cp

示例：

#### 3.16.1. 参数

- 源文件：制定源文件列表。默认情况下，cp 命令不能复制目录，如果要复制目录，则必须使用`-R`选项；
- 目标文件：指定目标文件。当“源文件”为多个文件时，要求“目标文件”为指定的目录。

示例：

```bash
# 将文件 file 复制到目录 /usr/men/tmp 下，并改名为 file1
cp file /usr/men/tmp/file1

# 将目录 /usr/men下的所有文件及其子目录复制到目录 /usr/zh 中
cp -r /usr/men /usr/zh

# 强行将 /usr/men下的所有文件复制到目录 /usr/zh 中，无论是否有文件重复
cp -rf /usr/men/* /usr/zh

# 将目录 /usr/men 中的以 m 打头的所有 .c 文件复制到目录 /usr/zh 中
cp -i /usr/men m*.c /usr/zh
```

### 3.17. scp

> scp 命令用于在 Linux 下进行远程拷贝文件的命令，和它类似的命令有 cp，不过 cp 只是在本机进行拷贝不能跨服务器，而且 scp 传输是加密的。可能会稍微影响一下速度。当你服务器硬盘变为只读 read only system 时，用 scp 可以帮你把文件移出来。另外，scp 还非常不占资源，不会提高多少系统负荷，在这一点上，rsync 就远远不及它了。虽然 rsync 比 scp 会快一点，但当小文件众多的情况下，rsync 会导致硬盘 I/O 非常高，而 scp 基本不影响系统正常使用。

示例：

```bash
# 拷贝文件到远程服务器的指定目录
scp <file> <user>@<ip>:<url>
scp test.txt root@192.168.0.1:/opt

# 拷贝目录到远程服务器的指定目录
scp -r <folder> <user>@<ip>:<url>
scp -r test root@192.168.0.1:/opt
```

#### 3.17.1. 免密码传输

（1）生成 ssh 公私钥对

```
ssh-keygen -t rsa
```

（2）将服务器 A 的 `\~/.ssh/id_rsa.pub` 文件内容复制到服务器 B 的 `\~/.ssh/authorized_keys` 文件中。

```bash
# 服务器 A 上执行以下命令
scp ~/.ssh/id_rsa.pub root@192.168.0.2:~/.ssh/id_rsa.pub.tmp

# 服务器 B 上执行以下命令
cat ~/.ssh/id_rsa.pub.tmp >> ~/.ssh/authorized_keys
rm ~/.ssh/id_rsa.pub.tmp
```

### 3.18. mv

> mv 命令用来对文件或目录重新命名，或者将文件从一个目录移到另一个目录中。source 表示源文件或目录，target 表示目标文件或目录。如果将一个文件移到一个已经存在的目标文件中，则目标文件的内容将被覆盖。
>
> 参考：http://man.linuxde.net/mv

示例：

```bash
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

### 3.19. rm

> rm 命令可以删除一个目录中的一个或多个文件或目录，也可以将某个目录及其下属的所有文件及其子目录均删除掉。对于链接文件，只是删除整个链接文件，而原有文件保持不变。
>
> 参考：http://man.linuxde.net/rm

```bash
rm test.txt               # 删除文件
rm -i test.txt test2.txt  # 交互式删除文件
rm -r *                   # 删除当前目录下的所有文件和目录
rm -r testdir             # 删除目录下的所有文件和目录
rm -rf testdir            # 强制删除目录下的所有文件和目录
rm -v testdir             # 显示当前删除操作的详情
```
