# Linux 系统管理

> 关键词：`lsb_release`, `reboot`, `exit`, `shutdown`, `date`, `mount`, `umount`, `ps`, `kill`, `systemctl`, `service`, `crontab`

## 1. Linux 系统管理要点

- 查看 Linux 系统发行版本
  - 使用 [lsb_release](#lsb_release)（此命令适用于所有的 Linux 发行版本）
  - 使用 `cat /etc/redhat-release`（此方法只适合 Redhat 系的 Linux）
- 查看 CPU 信息 - 使用 `cat /proc/cpuinfo`
- 重新启动 Linux 操作系统 - 使用 [reboot](#reboot)
- 退出 shell，并返回给定值 - 使用 [exit](#exit)
- 关闭系统 - 使用 [shutdown](#shutdown)
- 查看或设置系统时间与日期 - 使用 [date](#date)
- 挂载文件系统 - 使用 [mount](#mount)
- 取消挂载文件系统 - 使用 [umount](#umount)
- 查看系统当前进程状态 - 使用 [ps](#ps)
- 删除当前正在运行的进程 - 使用 [kill](#kill)
- 启动、停止、重启、关闭、显示系统服务（Centos7），使用 [systemctl](#systemctl)
- 启动、停止、重启、关闭、显示系统服务（Centos7 以前），使用 [service](#service)
- 管理需要周期性执行的任务，使用 [crontab](#crontab)

## 2. 命令常见用法

### 2.1. lsb_release

lsb_release 不是 bash 默认命令，如果要使用，需要先安装。

安装方法：

1. 执行 `yum provides lsb_release`，查看支持 lsb_release 命令的包。
2. 选择合适版本，执行类似这样的安装命令：`yum install -y redhat-lsb-core-4.1-27.el7.centos.1.x86_64`

### 2.2. reboot

> reboot 命令用来重新启动正在运行的 Linux 操作系统。
>
> 参考：http://man.linuxde.net/reboot

示例：

```bash
reboot        # 重开机。
reboot -w     # 做个重开机的模拟（只有纪录并不会真的重开机）。
```

### 2.3. exit

> exit 命令同于退出 shell，并返回给定值。在 shell 脚本中可以终止当前脚本执行。执行 exit 可使 shell 以指定的状态值退出。若不设置状态值参数，则 shell 以预设值退出。状态值 0 代表执行成功，其他值代表执行失败。
>
> 参考：http://man.linuxde.net/exit

示例：

```bash
# 退出当前 shell
[root@localhost ~]# exit
logout

# 在脚本中，进入脚本所在目录，否则退出
cd $(dirname $0) || exit 1

# 在脚本中，判断参数数量，不匹配就打印使用方式，退出
if [ "$#" -ne "2" ]; then
    echo "usage: $0 <area> <hours>"
    exit 2
fi

# 在脚本中，退出时删除临时文件
trap "rm -f tmpfile; echo Bye." EXIT

# 检查上一命令的退出码
./mycommand.sh
EXCODE=$?
if [ "$EXCODE" == "0" ]; then
    echo "O.K"
fi
```

### 2.4. shutdown

> shutdown 命令用来系统关机命令。shutdown 指令可以关闭所有程序，并依用户的需要，进行重新开机或关机的动作。
>
> 参考：http://man.linuxde.net/shutdown

示例：

```bash
# 指定现在立即关机
shutdown -h now

# 指定 5 分钟后关机，同时送出警告信息给登入用户
shutdown +5 "System will shutdown after 5 minutes"
```

### 2.5. date

> date 命令是显示或设置系统时间与日期。
>
> 参考：http://man.linuxde.net/date

示例：

```bash
# 格式化输出
date +"%Y-%m-%d"
2009-12-07

# 输出昨天日期
date -d "1 day ago" +"%Y-%m-%d"
2012-11-19

# 2 秒后输出
date -d "2 second" +"%Y-%m-%d %H:%M.%S"
2012-11-20 14:21.31

# 传说中的 1234567890 秒
date -d "1970-01-01 1234567890 seconds" +"%Y-%m-%d %H:%m:%S"
2009-02-13 23:02:30

# 普通转格式
date -d "2009-12-12" +"%Y/%m/%d %H:%M.%S"
2009/12/12 00:00.00

# apache 格式转换
date -d "Dec 5, 2009 12:00:37 AM" +"%Y-%m-%d %H:%M.%S"
2009-12-05 00:00.37

# 格式转换后时间游走
date -d "Dec 5, 2009 12:00:37 AM 2 year ago" +"%Y-%m-%d %H:%M.%S"
2007-12-05 00:00.37

# 加减操作
date +%Y%m%d                   # 显示前天年月日
date -d "+1 day" +%Y%m%d       # 显示前一天的日期
date -d "-1 day" +%Y%m%d       # 显示后一天的日期
date -d "-1 month" +%Y%m%d     # 显示上一月的日期
date -d "+1 month" +%Y%m%d     # 显示下一月的日期
date -d "-1 year" +%Y%m%d      # 显示前一年的日期
date -d "+1 year" +%Y%m%d      # 显示下一年的日期

# 设定时间
date -s                        # 设置当前时间，只有root权限才能设置，其他只能查看
date -s 20120523               # 设置成20120523，这样会把具体时间设置成空00:00:00
date -s 01:01:01               # 设置具体时间，不会对日期做更改
date -s "01:01:01 2012-05-23"  # 这样可以设置全部时间
date -s "01:01:01 20120523"    # 这样可以设置全部时间
date -s "2012-05-23 01:01:01"  # 这样可以设置全部时间
date -s "20120523 01:01:01"    # 这样可以设置全部时间

# 有时需要检查一组命令花费的时间
#!/bin/bash

start=$(date +%s)
nmap man.linuxde.net &> /dev/null

end=$(date +%s)
difference=$(( end - start ))
echo $difference seconds.
```

### 2.6. mount

> mount 命令用于挂载文件系统到指定的挂载点。此命令的最常用于挂载 cdrom，使我们可以访问 cdrom 中的数据，因为你将光盘插入 cdrom 中，Linux 并不会自动挂载，必须使用 Linux mount 命令来手动完成挂载。
>
> 参考：http://man.linuxde.net/mount > https://blog.csdn.net/weishujie000/article/details/76531924

示例：

```bash
# 将 /dev/hda1 挂在 /mnt 之下
mount /dev/hda1 /mnt

# 将 /dev/hda1 用唯读模式挂在 /mnt 之下
mount -o ro /dev/hda1 /mnt

# 将 /tmp/image.iso 这个光碟的 image 档使用 loop 模式挂在 /mnt/cdrom 之下
# 用这种方法可以将一般网络上可以找到的 Linux ISO 在不烧录成光碟的情况下检视其内容
mount -o loop /tmp/image.iso /mnt/cdrom
```

### 2.7. umount

> umount 命令用于卸载已经挂载的文件系统。利用设备名或挂载点都能 umount 文件系统，不过最好还是通过挂载点卸载，以免使用绑定挂载（一个设备，多个挂载点）时产生混乱。
>
> 参考：http://man.linuxde.net/umount

示例：

```bash
# 通过设备名卸载
umount -v /dev/sda1
/dev/sda1 umounted

# 通过挂载点卸载
umount -v /mnt/mymount/
/tmp/diskboot.img umounted
```

### 2.8. ps

> ps 命令用于报告当前系统的进程状态。可以搭配 kill 指令随时中断、删除不必要的程序。ps 命令是最基本同时也是非常强大的进程查看命令，使用该命令可以确定有哪些进程正在运行和运行的状态、进程是否结束、进程有没有僵死、哪些进程占用了过多的资源等等，总之大部分信息都是可以通过执行该命令得到的。
>
> 参考：http://man.linuxde.net/ps

示例：

```bash
# 按内存资源的使用量对进程进行排序
ps aux | sort -rnk 4

# 按 CPU 资源的使用量对进程进行排序
ps aux | sort -nk 3
```

### 2.9. kill

> kill 命令用来删除执行中的程序或工作。kill 可将指定的信息送至程序。预设的信息为 SIGTERM(15),可将指定程序终止。若仍无法终止该程序，可使用 SIGKILL(9) 信息尝试强制删除程序。程序或工作的编号可利用 ps 指令或 job 指令查看。
>
> 参考：http://man.linuxde.net/kill

示例：

```bash
# 列出所有信号名称
 kill -l
 1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL
 5) SIGTRAP      6) SIGABRT      7) SIGBUS       8) SIGFPE
 9) SIGKILL     10) SIGUSR1     11) SIGSEGV     12) SIGUSR2
13) SIGPIPE     14) SIGALRM     15) SIGTERM     16) SIGSTKFLT
17) SIGCHLD     18) SIGCONT     19) SIGSTOP     20) SIGTSTP
21) SIGTTIN     22) SIGTTOU     23) SIGURG      24) SIGXCPU
25) SIGXFSZ     26) SIGVTALRM   27) SIGPROF     28) SIGWINCH
29) SIGIO       30) SIGPWR      31) SIGSYS      34) SIGRTMIN
35) SIGRTMIN+1  36) SIGRTMIN+2  37) SIGRTMIN+3  38) SIGRTMIN+4
39) SIGRTMIN+5  40) SIGRTMIN+6  41) SIGRTMIN+7  42) SIGRTMIN+8
43) SIGRTMIN+9  44) SIGRTMIN+10 45) SIGRTMIN+11 46) SIGRTMIN+12
47) SIGRTMIN+13 48) SIGRTMIN+14 49) SIGRTMIN+15 50) SIGRTMAX-14
51) SIGRTMAX-13 52) SIGRTMAX-12 53) SIGRTMAX-11 54) SIGRTMAX-10
55) SIGRTMAX-9  56) SIGRTMAX-8  57) SIGRTMAX-7  58) SIGRTMAX-6
59) SIGRTMAX-5  60) SIGRTMAX-4  61) SIGRTMAX-3  62) SIGRTMAX-2
63) SIGRTMAX-1  64) SIGRTMAX

# 先用 ps 查找进程，然后用 kill 杀掉
ps -ef | grep vim
root      3268  2884  0 16:21 pts/1    00:00:00 vim install.log
root      3370  2822  0 16:21 pts/0    00:00:00 grep vim

kill 3268
kill 3268
-bash: kill: (3268) - 没有那个进程
```

### 2.10. systemctl

> systemctl 命令是系统服务管理器指令，它实际上将 service 和 chkconfig 这两个命令组合到一起。
>
> 参考：http://man.linuxde.net/systemctl

示例：

```bash
# 1.启动 nfs 服务
systemctl start nfs-server.service

# 2.设置开机自启动
systemctl enable nfs-server.service

# 3.停止开机自启动
systemctl disable nfs-server.service

# 4.查看服务当前状态
systemctl status nfs-server.service

# 5.重新启动某服务
systemctl restart nfs-server.service

# 6.查看所有已启动的服务
systemctl list-units --type=service

# 7. 开启防火墙 22 端口
iptables -I INPUT -p tcp --dport 22 -j accept

# 8. 彻底关闭防火墙
sudo systemctl status firewalld.service
sudo systemctl stop firewalld.service
sudo systemctl disable firewalld.service
```

### 2.11. service

> service 命令是 Redhat Linux 兼容的发行版中用来控制系统服务的实用工具，它以启动、停止、重新启动和关闭系统服务，还可以显示所有系统服务的当前状态。
>
> 参考：http://man.linuxde.net/service

示例：

```bash
service network status
配置设备：
lo eth0
当前的活跃设备：
lo eth0

service network restart
正在关闭接口 eth0：                                        [  确定  ]
关闭环回接口：                                             [  确定  ]
设置网络参数：                                             [  确定  ]
弹出环回接口：                                             [  确定  ]
弹出界面 eth0：                                            [  确定  ]
```

### 2.12. crontab

> crontab 命令被用来提交和管理用户的需要周期性执行的任务，与 windows 下的计划任务类似，当安装完成操作系统后，默认会安装此服务工具，并且会自动启动 crond 进程，crond 进程每分钟会定期检查是否有要执行的任务，如果有要执行的任务，则自动执行该任务。
>
> 参考：http://man.linuxde.net/crontab

示例：

```bash
# 每 1 分钟执行一次 command
* * * * * command

# 每小时的第 3 和第 15 分钟执行
3,15 * * * * command

# 在上午 8 点到 11 点的第 3 和第 15 分钟执行
3,15 8-11 * * * command

# 每隔两天的上午 8 点到 11 点的第 3 和第 15 分钟执行
3,15 8-11 */2 * * command

# 每个星期一的上午 8 点到 11 点的第 3 和第 15 分钟执行
3,15 8-11 * * 1 command

# 每晚的 21:30 重启 smb
30 21 * * * /etc/init.d/smb restart

# 每月 1、10、22 日的 4 : 45 重启 smb
45 4 1,10,22 * * /etc/init.d/smb restart

# 每周六、周日的 1:10 重启 smb
10 1 * * 6,0 /etc/init.d/smb restart

# 每天 18 : 00 至 23 : 00 之间每隔 30 分钟重启 smb
0,30 18-23 * * * /etc/init.d/smb restart

# 每星期六的晚上 11:00 pm 重启 smb
0 23 * * 6 /etc/init.d/smb restart

# 每一小时重启 smb
* */1 * * * /etc/init.d/smb restart

# 晚上 11 点到早上 7 点之间，每隔一小时重启 smb
* 23-7/1 * * * /etc/init.d/smb restart

# 每月的 4 号与每周一到周三的 11 点重启 smb
0 11 4 * mon-wed /etc/init.d/smb restart

# 一月一号的 4 点重启 smb
0 4 1 jan * /etc/init.d/smb restart

# 每小时执行`/etc/cron.hourly`目录内的脚本
01 * * * * root run-parts /etc/cron.hourly
```
