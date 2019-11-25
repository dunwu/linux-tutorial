# Linux 硬件管理

> 关键词：`df`, `du`, `top`, `free`, `iotop`

## 1. Linux 硬件管理要点

- 查看磁盘空间 - 使用 [df](#df)
- 查看文件或目录的磁盘空间 - 使用 [du](#du)
- 实时查看系统整体运行状态（如：CPU、内存） - 使用 [top](#top)
- 查看已使用和未使用的内存 - 使用 [free](#free)
- 查看磁盘 I/O 使用状况 - 使用 [iotop](#iotop)

## 2. 命令常见用法

### 2.1. df

> df 命令用于显示磁盘分区上的可使用的磁盘空间。默认显示单位为 KB。可以利用该命令来获取硬盘被占用了多少空间，目前还剩下多少空间等信息。
>
> 参考：http://man.linuxde.net/df

示例：

```bash
# 查看系统磁盘设备，默认是 KB 为单位
[root@LinServ-1 ~]# df
文件系统               1K-块        已用     可用 已用% 挂载点
/dev/sda2            146294492  28244432 110498708  21% /
/dev/sda1              1019208     62360    904240   7% /boot
tmpfs                  1032204         0   1032204   0% /dev/shm
/dev/sdb1            2884284108 218826068 2518944764   8% /data1

# 使用 -h 选项以 KB 以上的单位来显示，可读性高
[root@LinServ-1 ~]# df -h
文件系统              容量  已用 可用 已用% 挂载点
/dev/sda2             140G   27G  106G  21% /
/dev/sda1             996M   61M  884M   7% /boot
tmpfs                1009M     0 1009M   0% /dev/shm
/dev/sdb1             2.7T  209G  2.4T   8% /data1

# 查看全部文件系统
[root@LinServ-1 ~]# df -a
文件系统               1K-块        已用     可用 已用% 挂载点
/dev/sda2            146294492  28244432 110498708  21% /
proc                         0         0         0   -  /proc
sysfs                        0         0         0   -  /sys
devpts                       0         0         0   -  /dev/pts
/dev/sda1              1019208     62360    904240   7% /boot
tmpfs                  1032204         0   1032204   0% /dev/shm
/dev/sdb1            2884284108 218826068 2518944764   8% /data1
none                         0         0         0   -  /proc/sys/fs/binfmt_misc
```

### 2.2. du

> du 命令也是查看使用空间的，但是与 df 命令不同的是：du 命令是对文件和目录磁盘使用的空间的查看，还是和 df 命令有一些区别的。
>
> 参考：http://man.linuxde.net/du

示例：

```bash
# 显示目录或者文件所占空间
root@localhost [test]# du
608 ./test6
308 ./test4
4 ./scf/lib
4 ./scf/service/deploy/product
4 ./scf/service/deploy/info
12 ./scf/service/deploy
16 ./scf/service
4 ./scf/doc
4 ./scf/bin
32 ./scf
8 ./test3
1288 .

# 显示指定文件所占空间
[root@localhost test]# du log2012.log
300 log2012.log

# 查看指定目录的所占空间
[root@localhost test]# du scf
4 scf/lib
4 scf/service/deploy/product
4 scf/service/deploy/info
12 scf/service/deploy
16 scf/service
4 scf/doc
4 scf/bin
32 scf

# 显示多个文件所占空间
[root@localhost test]# du log30.tar.gz log31.tar.gz
4 log30.tar.gz
4 log31.tar.gz

# 只显示总和的大小
[root@localhost test]# du -s
1288 .

[root@localhost test]# du -s scf
32 scf
```

### 2.3. top

> top 命令可以实时动态地查看系统的整体运行情况，是一个综合了多方信息监测系统性能和运行信息的实用工具。通过 top 命令所提供的互动式界面，用热键可以管理。
>
> 参考：http://man.linuxde.net/top

### 2.4. free

> free 命令可以显示当前系统未使用的和已使用的内存数目，还可以显示被内核使用的内存缓冲区。
>
> 参考：http://man.linuxde.net/free

示例：

```bash
free -t    # 以总和的形式显示内存的使用信息
free -s 10 # 周期性的查询内存使用信息，每10s 执行一次命令

# 显示内存使用情况

free -m
             total       used       free     shared    buffers     cached
Mem:          2016       1973         42          0        163       1497
-/+ buffers/cache:        312       1703
Swap:         4094          0       4094
```

### 2.5. iotop

> iotop 命令是一个用来监视磁盘 I/O 使用状况的 top 类工具。iotop 具有与 top 相似的 UI，其中包括 PID、用户、I/O、进程等相关信息。Linux 下的 IO 统计工具如 iostat，nmon 等大多数是只能统计到 per 设备的读写情况，如果你想知道每个进程是如何使用 IO 的就比较麻烦，使用 iotop 命令可以很方便的查看。
>
> 参考：http://man.linuxde.net/iotop

示例：

```bash
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
