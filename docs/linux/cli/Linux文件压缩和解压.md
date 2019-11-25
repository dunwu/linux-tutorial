# Linux 文件压缩和解压

> 关键词：`tar`, `gzip`, `zip`, `unzip`

## 1. Linux 文件压缩和解压要点

- 压缩和解压 tar 文件 - 使用 [tar](#tar)
- 压缩和解压 gz 文件 - 使用 [gzip](#gzip)
- 压缩和解压 zip 文件 - 分别使用 [zip](#zip)、[unzip](#unzip)

## 2. 命令常见用法

### 2.1. tar

> tar 命令可以为 linux 的文件和目录创建档案。利用 tar，可以为某一特定文件创建档案（备份文件），也可以在档案中改变文件，或者向档案中加入新的文件。tar 最初被用来在磁带上创建档案，现在，用户可以在任何设备上创建档案。利用 tar 命令，可以把一大堆的文件和目录全部打包成一个文件，这对于备份文件或将几个文件组合成为一个文件以便于网络传输是非常有用的。
>
> 参考：http://man.linuxde.net/tar

示例：

```bash
tar -cvf log.tar log2012.log            # 仅打包，不压缩
tar -zcvf log.tar.gz log2012.log        # 打包后，以 gzip 压缩
tar -jcvf log.tar.bz2 log2012.log       # 打包后，以 bzip2 压缩

tar -ztvf log.tar.gz                    # 查阅上述 tar 包内有哪些文件
tar -zxvf log.tar.gz                    # 将 tar 包解压缩
tar -zxvf log30.tar.gz log2013.log      # 只将 tar 内的部分文件解压出来
```

### 2.2. gzip

> gzip 命令用来压缩文件。gzip 是个使用广泛的压缩程序，文件经它压缩过后，其名称后面会多出“.gz”扩展名。
>
> gzip 是在 Linux 系统中经常使用的一个对文件进行压缩和解压缩的命令，既方便又好用。gzip 不仅可以用来压缩大的、较少使用的文件以节省磁盘空间，还可以和 tar 命令一起构成 Linux 操作系统中比较流行的压缩文件格式。据统计，gzip 命令对文本文件有 60%～ 70%的压缩率。减少文件大小有两个明显的好处，一是可以减少存储空间，二是通过网络传输文件时，可以减少传输的时间。
>
> 参考：http://man.linuxde.net/gzip

示例：

```bash
gzip * # 将所有文件压缩成 .gz 文件
gzip -l * # 详细显示压缩文件的信息，并不解压
gzip -dv * # 解压上例中的所有压缩文件，并列出详细的信息
gzip -r log.tar     # 压缩一个 tar 备份文件，此时压缩文件的扩展名为.tar.gz
gzip -rv test/      # 递归的压缩目录
gzip -dr test/      # 递归地解压目录
```

### 2.3. zip

> zip 命令可以用来解压缩文件，或者对文件进行打包操作。zip 是个使用广泛的压缩程序，文件经它压缩后会另外产生具有“.zip”扩展名的压缩文件。
>
> 参考：http://man.linuxde.net/zip

示例：

```bash
# 将 /home/Blinux/html/ 这个目录下所有文件和文件夹打包为当前目录下的 html.zip
zip -q -r html.zip /home/Blinux/html
```

### 2.4. unzip

> unzip 命令用于解压缩由 zip 命令压缩的“.zip”压缩包。
>
> 参考：http://man.linuxde.net/unzip

示例：

```bash
unzip test.zip              # 解压 zip 文件
unzip -n test.zip -d /tmp/  # 在指定目录下解压缩
unzip -o test.zip -d /tmp/  # 在指定目录下解压缩，如果有相同文件存在则覆盖
unzip -v test.zip           # 查看压缩文件目录，但不解压
```
