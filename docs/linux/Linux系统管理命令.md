---
title: Linux 系统管理命令
date: 2018/02/27
categories:
  - linux
tags:
  - linux
  - command
---

# Linux 系统管理命令

> 关键词：`reboot`, `exit`, `shutdown`, `date`, `mount`, `umount`

<!-- TOC depthFrom:2 depthTo:2 -->

- [reboot](#reboot)
- [exit](#exit)
- [shutdown](#shutdown)
- [date](#date)
- [mount](#mount)
- [umount](#umount)

<!-- /TOC -->

## reboot

> reboot 命令用来重新启动正在运行的 Linux 操作系统。
>
> 参考：http://man.linuxde.net/reboot

示例：

```sh
reboot        # 重开机。
reboot -w     # 做个重开机的模拟（只有纪录并不会真的重开机）。
```

## exit

> exit 命令同于退出 shell，并返回给定值。在 shell 脚本中可以终止当前脚本执行。执行 exit 可使 shell 以指定的状态值退出。若不设置状态值参数，则 shell 以预设值退出。状态值 0 代表执行成功，其他值代表执行失败。
>
> 参考：http://man.linuxde.net/exit

示例：

```sh
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

## shutdown

> shutdown 命令用来系统关机命令。shutdown 指令可以关闭所有程序，并依用户的需要，进行重新开机或关机的动作。
>
> 参考：http://man.linuxde.net/shutdown

示例：

```sh
# 指定现在立即关机
shutdown -h now

# 指定 5 分钟后关机，同时送出警告信息给登入用户
shutdown +5 "System will shutdown after 5 minutes"
```

## date

> date 命令是显示或设置系统时间与日期。
>
> 参考：http://man.linuxde.net/date

示例：

```sh
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

## mount

> mount 命令用于挂载文件系统到指定的挂载点。此命令的最常用于挂载 cdrom，使我们可以访问 cdrom 中的数据，因为你将光盘插入 cdrom 中，Linux 并不会自动挂载，必须使用 Linux mount 命令来手动完成挂载。
>
> 参考：http://man.linuxde.net/mount
> https://blog.csdn.net/weishujie000/article/details/76531924

示例：

```sh
# 将 /dev/hda1 挂在 /mnt 之下
mount /dev/hda1 /mnt

# 将 /dev/hda1 用唯读模式挂在 /mnt 之下
mount -o ro /dev/hda1 /mnt

# 将 /tmp/image.iso 这个光碟的 image 档使用 loop 模式挂在 /mnt/cdrom 之下
# 用这种方法可以将一般网络上可以找到的 Linux ISO 在不烧录成光碟的情况下检视其内容
mount -o loop /tmp/image.iso /mnt/cdrom
```

## umount

> umount 命令用于卸载已经挂载的文件系统。利用设备名或挂载点都能 umount 文件系统，不过最好还是通过挂载点卸载，以免使用绑定挂载（一个设备，多个挂载点）时产生混乱。
>
> 参考：http://man.linuxde.net/umount

示例：

```sh
# 通过设备名卸载
umount -v /dev/sda1
/dev/sda1 umounted

# 通过挂载点卸载
umount -v /mnt/mymount/
/tmp/diskboot.img umounted
```
