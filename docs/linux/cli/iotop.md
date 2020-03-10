# iotop

用来监视磁盘 I/O 使用状况的工具

## 补充说明

**iotop 命令** 是一个用来监视磁盘 I/O 使用状况的 top 类工具。iotop 具有与 top 相似的 UI，其中包括 PID、用户、I/O、进程等相关信息。Linux 下的 IO 统计工具如 iostat，nmon 等大多数是只能统计到 per 设备的读写情况，如果你想知道每个进程是如何使用 IO 的就比较麻烦，使用 iotop 命令可以很方便的查看。

iotop 使用 Python 语言编写而成，要求 Python2.5（及以上版本）和 Linux kernel2.6.20（及以上版本）。iotop 提供有源代码及 rpm 包，可从其官方主页下载。

### 安装

**Ubuntu**

```shell
apt-get install iotop
```

**CentOS**

```shell
yum install iotop
```

**编译安装**

```shell
wget http://guichaz.free.fr/iotop/files/iotop-0.4.4.tar.gz
tar zxf iotop-0.4.4.tar.gz
python setup.py build
python setup.py install
```

### 语法

```shell
iotop（选项）
```

### 选项

```shell
-o：只显示有io操作的进程
-b：批量显示，无交互，主要用作记录到文件。
-n NUM：显示NUM次，主要用于非交互式模式。
-d SEC：间隔SEC秒显示一次。
-p PID：监控的进程pid。
-u USER：监控的进程用户。
```

**iotop 常用快捷键：**

1.  左右箭头：改变排序方式，默认是按 IO 排序。
2.  r：改变排序顺序。
3.  o：只显示有 IO 输出的进程。
4.  p：进程/线程的显示方式的切换。
5.  a：显示累积使用量。
6.  q：退出。

### 实例

直接执行 iotop 就可以看到效果了：

```shell
Total DISK read:       0.00 B/s | Total DISK write:       0.00 B/s
  TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO>    command
    1 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % init [3]
    2 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [kthreadd]
    3 rt/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [migration/0]
    4 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [ksoftirqd/0]
    5 rt/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [watchdog/0]
    6 rt/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [migration/1]
    7 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [ksoftirqd/1]
    8 rt/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [watchdog/1]
    9 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [events/0]
   10 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [events/1]
   11 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [khelper]
2572 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.00 % [bluetooth]
```
