---
title: Linux 进程管理命令
date: 2018/02/28
categories:
  - linux
tags:
  - linux
  - command
---

# Linux 进程管理命令

> 关键词：`ps`, `kill`, `systemctl`, `service`, `crontab`

<!-- TOC depthFrom:2 depthTo:2 -->

- [ps](#ps)
- [kill](#kill)
- [systemctl](#systemctl)
- [service](#service)
- [crontab](#crontab)

<!-- /TOC -->

## ps

> ps 命令用于报告当前系统的进程状态。可以搭配 kill 指令随时中断、删除不必要的程序。ps 命令是最基本同时也是非常强大的进程查看命令，使用该命令可以确定有哪些进程正在运行和运行的状态、进程是否结束、进程有没有僵死、哪些进程占用了过多的资源等等，总之大部分信息都是可以通过执行该命令得到的。
>
> 参考：http://man.linuxde.net/ps

示例：

```sh
# 按内存资源的使用量对进程进行排序
ps aux | sort -rnk 4

# 按 CPU 资源的使用量对进程进行排序
ps aux | sort -nk 3
```

## kill

> kill 命令用来删除执行中的程序或工作。kill 可将指定的信息送至程序。预设的信息为 SIGTERM(15),可将指定程序终止。若仍无法终止该程序，可使用 SIGKILL(9) 信息尝试强制删除程序。程序或工作的编号可利用 ps 指令或 job 指令查看。
>
> 参考：http://man.linuxde.net/kill

示例：

```sh
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

## systemctl

> systemctl 命令是系统服务管理器指令，它实际上将 service 和 chkconfig 这两个命令组合到一起。
>
> 参考：http://man.linuxde.net/systemctl

示例：

```sh
# 1.启动 nfs 服务
systemctl start nfs-server.service

# 2.设置开机自启动
systemctl enable nfs-server.service

# 3.停止开机自启动
systemctl disable nfs-server.service

# 4.查看服务当前状态
systemctl status nfs-server.service

# 5.重新启动某服务
systemctl restart nfs-server.service

# 6.查看所有已启动的服务
systemctl list -units --type=service

# 7. 开启防火墙 22 端口
iptables -I INPUT -p tcp --dport 22 -j accept

# 8. 彻底关闭防火墙
sudo systemctl status firewalld.service
sudo systemctl stop firewalld.service
sudo systemctl disable firewalld.service
```

## service

> service 命令是 Redhat Linux 兼容的发行版中用来控制系统服务的实用工具，它以启动、停止、重新启动和关闭系统服务，还可以显示所有系统服务的当前状态。
>
> 参考：http://man.linuxde.net/service

示例：

```sh
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

## crontab

> crontab 命令被用来提交和管理用户的需要周期性执行的任务，与 windows 下的计划任务类似，当安装完成操作系统后，默认会安装此服务工具，并且会自动启动 crond 进程，crond 进程每分钟会定期检查是否有要执行的任务，如果有要执行的任务，则自动执行该任务。
>
> 参考：http://man.linuxde.net/crontab

示例：



```sh
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

# 每月 1、10、22 日的 4 : 45 重启 smb
45 4 1,10,22 * * /etc/init.d/smb restart

# 每周六、周日的 1:10 重启 smb
10 1 * * 6,0 /etc/init.d/smb restart

# 每天 18 : 00 至 23 : 00 之间每隔 30 分钟重启 smb
0,30 18-23 * * * /etc/init.d/smb restart

# 每星期六的晚上 11:00 pm 重启 smb
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
