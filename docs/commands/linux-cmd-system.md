## useradd 命令

> useradd 命令用于建立用户帐号。
>
> useradd 可用来建立用户帐号。帐号建好之后，再用 passwd 设定帐号的密码。使用 useradd 指令所建立的帐号，实际上是保存在 `/etc/passwd` 文本文件中。
>
> userdel 可用来删除帐号。

### 语法

```
useradd [-mMnr][-c <备注>][-d <登入目录>][-e <有效期限>][-f <缓冲天数>][-g <群组>][-G <群组>][-s <shell>][-u <uid>][用户帐号]
```

或

```
useradd -D [-b][-e <有效期限>][-f <缓冲天数>][-g <群组>][-G <群组>][-s <shell>]
```

**参数说明**：

- -c<备注> 　加上备注文字。备注文字会保存在passwd的备注栏位中。
- -d<登入目录> 　指定用户登入时的启始目录。
- -D 　变更预设值．
- -e<有效期限> 　指定帐号的有效期限。
- -f<缓冲天数> 　指定在密码过期后多少天即关闭该帐号。
- -g<群组> 　指定用户所属的群组。
- -G<群组> 　指定用户所属的附加群组。
- -m 　自动建立用户的登入目录。
- -M 　不要自动建立用户的登入目录。
- -n 　取消建立以用户名称为名的群组．
- -r 　建立系统帐号。
- -s<shell>　 　指定用户登入后所使用的shell。
- -u<uid> 　指定用户ID。

### 实例

添加一般用户

```sh
$ useradd tt
```

为添加的用户指定相应的用户组

```sh
$ useradd -g root tt
```

创建一个系统用户

```sh
$ useradd -r tt
```

为新添加的用户指定home目录

```sh
$ useradd -d /home/myd tt
```

建立用户且制定ID

```sh
$ useradd caojh -u 544
```

## passwd 命令

> passwd 命令用来更改使用者的密码。

### 语法

```
passwd [-k] [-l] [-u [-f]] [-d] [-S] [username]
```

**必要参数**：

- -d 删除密码
- -f 强制执行
- -k 更新只能发送在过期之后
- -l 停止账号使用
- -S 显示密码信息
- -u 启用已被停止的账户
- -x 设置密码的有效期
- -g 修改群组密码
- -i 过期后停止用户账号

**选择参数**：

- --help 显示帮助信息
- --version 显示版本信息

### 实例

修改用户密码

```sh
$ passwd w3cschool  //设置w3cschool用户的密码
Enter new UNIX password:  //输入新密码，输入的密码无回显
Retype new UNIX password:  //确认密码
passwd: password updated successfully
```

显示账号密码信息

```sh
$ passwd -S w3cschool
w3cschool P 05/13/2010 0 99999 7 -1
```

删除用户密码

```sh
$ passwd -d lx138 
passwd: password expiry information changed.
```

## userdel 命令

> userdel 命令用于删除用户帐号。
>
> userdel 可删除用户帐号与相关的文件。若不加参数，则仅删除用户帐号，而不删除相关文件。

### 语法

```
userdel [-r][用户帐号]
```

**参数说明**：

- -r 　删除用户登入目录以及目录中所有文件。

### 实例

删除用户账号

```sh
$ userdel hnlinux
```

## usermod 命令

> usermod 命令用于修改用户帐号。
>
> usermod 可用来修改用户帐号的各项设定。

### 语法

```
usermod [-LU][-c <备注>][-d <登入目录>][-e <有效期限>][-f <缓冲天数>][-g <群组>][-G <群组>][-l <帐号名称>][-s <shell>][-u <uid>][用户帐号]
```

**参数说明**：

- -c<备注> 　修改用户帐号的备注文字。
- -d登入目录> 　修改用户登入时的目录。
- -e<有效期限> 　修改帐号的有效期限。
- -f<缓冲天数> 　修改在密码过期后多少天即关闭该帐号。
- -g<群组> 　修改用户所属的群组。
- -G<群组> 　修改用户所属的附加群组。
- -l<帐号名称> 　修改用户帐号名称。
- -L 　锁定用户密码，使密码无效。
- -s<shell> 　修改用户登入后所使用的shell。
- -u<uid> 　修改用户ID。
- -U 　解除密码锁定。

### 实例

更改登录目录

```sh
# usermod -d /home/hnlinux root
```

改变用户的uid

```sh
# usermod -u 777 root
```

## su 命令

> su 命令用于变更为其他使用者的身份，除 root 外，需要键入该使用者的密码。
>
> 使用权限：所有使用者。

### 语法

```
su [options] [-] [USER [arg]...]
```

**参数说明**：

- -f 或 --fast 不必读启动档（如 csh.cshrc 等），仅用于 csh 或 tcsh
- -m -p 或 --preserve-environment 执行 su 时不改变环境变数
- -c command 或 --command=command 变更为帐号为 USER 的使用者并执行指令（command）后再变回原来使用者
- -s shell 或 --shell=shell 指定要执行的 shell （bash csh tcsh 等），预设值为 /etc/passwd 内的该使用者（USER） shell
- --help 显示说明文件
- --version 显示版本资讯
- \- -l 或 --login 这个参数加了之后，就好像是重新 login 为该使用者一样，大部份环境变数（HOME SHELL USER等等）都是以该使用者（USER）为主，并且工作目录也会改变，如果没有指定 USER ，内定是 root
- USER 欲变更的使用者帐号
- ARG 传入新的 shell 参数

### 实例

变更帐号为 root 并在执行 ls 指令后退出变回原使用者

```sh
$ su -c ls root
```

变更帐号为 root 并传入 -f 参数给新执行的 shell

```sh
$ su root -f
```

变更帐号为 clsung 并改变工作目录至 clsung 的家目录（home dir）

```sh
$ su - clsung
```

切换用户

```
hnlinux@w3cschool.cc:~$ whoami //显示当前用户
hnlinux
hnlinux@w3cschool.cc:~$ pwd //显示当前目录
/home/hnlinux
hnlinux@w3cschool.cc:~$ su root //切换到root用户
密码： 
root@w3cschool.cc:/home/hnlinux# whoami 
root
root@w3cschool.cc:/home/hnlinux# pwd
/home/hnlinux
```

切换用户，改变环境变量

```
hnlinux@w3cschool.cc:~$ whoami //显示当前用户
hnlinux
hnlinux@w3cschool.cc:~$ pwd //显示当前目录
/home/hnlinux
hnlinux@w3cschool.cc:~$ su - root //切换到root用户
密码： 
root@w3cschool.cc:/home/hnlinux# whoami 
root
root@w3cschool.cc:/home/hnlinux# pwd //显示当前目录
/root
```

## sudo 命令

> sudo 命令以系统管理者的身份执行指令，也就是说，经由 sudo 所执行的指令就好像是 root 亲自执行。
>
> 使用权限：在 `/etc/sudoers` 中有出现的使用者。

### 语法

```sh
usage: sudo -h | -K | -k | -V
usage: sudo -v [-AknS] [-g group] [-h host] [-p prompt] [-u user]
usage: sudo -l [-AknS] [-g group] [-h host] [-p prompt] [-U user] [-u user] [command]
usage: sudo [-AbEHknPS] [-r role] [-t type] [-C num] [-g group] [-h host] [-p prompt] [-u user] [VAR=value] [-i|-s] [<command>]
usage: sudo -e [-AknS] [-r role] [-t type] [-C num] [-g group] [-h host] [-p prompt] [-u user] file ...
```

**参数说明**：

- -V 显示版本编号
- -h 会显示版本编号及指令的使用方式说明
- -l 显示出自己（执行 sudo 的使用者）的权限
- -v 因为 sudo 在第一次执行时或是在 N 分钟内没有执行（N 预设为五）会问密码，这个参数是重新做一次确认，如果超过 N 分钟，也会问密码
- -k 将会强迫使用者在下一次执行 sudo 时问密码（不论有没有超过 N 分钟）
- -b 将要执行的指令放在背景执行
- -p prompt 可以更改问密码的提示语，其中 %u 会代换为使用者的帐号名称， %h 会显示主机名称
- -u username/#uid 不加此参数，代表要以 root 的身份执行指令，而加了此参数，可以以 username 的身份执行指令（#uid 为该 username 的使用者号码）
- -s 执行环境变数中的 SHELL 所指定的 shell ，或是 /etc/passwd 里所指定的 shell
- -H 将环境变数中的 HOME （家目录）指定为要变更身份的使用者家目录（如不加 -u 参数就是系统管理者 root ）
- command 要以系统管理者身份（或以 -u 更改为其他人）执行的指令

### 实例

sudo 命令使用

```sh
$ sudo ls
[sudo] password for hnlinux: 
hnlinux is not in the sudoers file. This incident will be reported.
```

指定用户执行命令

```sh
$ sudo -u userb ls -l
```

显示sudo设置

```sh
$ sudo -L //显示sudo设置
Available options in a sudoers ``Defaults'' line:

syslog: Syslog facility if syslog is being used for logging
syslog_goodpri: Syslog priority to use when user authenticates successfully
syslog_badpri: Syslog priority to use when user authenticates unsuccessfully
long_otp_prompt: Put OTP prompt on its own line
ignore_dot: Ignore '.' in $PATH
mail_always: Always send mail when sudo is run
mail_badpass: Send mail if user authentication fails
mail_no_user: Send mail if the user is not in sudoers
mail_no_host: Send mail if the user is not in sudoers for this host
mail_no_perms: Send mail if the user is not allowed to run a command
tty_tickets: Use a separate timestamp for each user/tty combo
lecture: Lecture user the first time they run sudo
lecture_file: File containing the sudo lecture
authenticate: Require users to authenticate by default
root_sudo: Root may run sudo
log_host: Log the hostname in the (non-syslog) log file
log_year: Log the year in the (non-syslog) log file
shell_noargs: If sudo is invoked with no arguments, start a shell
set_home: Set $HOME to the target user when starting a shell with -s
always_set_home: Always set $HOME to the target user's home directory
path_info: Allow some information gathering to give useful error messages
fqdn: Require fully-qualified hostnames in the sudoers file
insults: Insult the user when they enter an incorrect password
requiretty: Only allow the user to run sudo if they have a tty
env_editor: Visudo will honor the EDITOR environment variable
rootpw: Prompt for root's password, not the users's
runaspw: Prompt for the runas_default user's password, not the users's
targetpw: Prompt for the target user's password, not the users's
use_loginclass: Apply defaults in the target user's login class if there is one
set_logname: Set the LOGNAME and USER environment variables
stay_setuid: Only set the effective uid to the target user, not the real uid
preserve_groups: Don't initialize the group vector to that of the target user
loglinelen: Length at which to wrap log file lines (0 for no wrap)
timestamp_timeout: Authentication timestamp timeout
passwd_timeout: Password prompt timeout
passwd_tries: Number of tries to enter a password
umask: Umask to use or 0777 to use user's
logfile: Path to log file
mailerpath: Path to mail program
mailerflags: Flags for mail program
mailto: Address to send mail to
mailfrom: Address to send mail from
mailsub: Subject line for mail messages
badpass_message: Incorrect password message
timestampdir: Path to authentication timestamp dir
timestampowner: Owner of the authentication timestamp dir
exempt_group: Users in this group are exempt from password and PATH requirements
passprompt: Default password prompt
passprompt_override: If set, passprompt will override system prompt in all cases.
runas_default: Default user to run commands as
secure_path: Value to override user's $PATH with
editor: Path to the editor for use by visudo
listpw: When to require a password for 'list' pseudocommand
verifypw: When to require a password for 'verify' pseudocommand
noexec: Preload the dummy exec functions contained in 'noexec_file'
noexec_file: File containing dummy exec functions
ignore_local_sudoers: If LDAP directory is up, do we ignore local sudoers file
closefrom: File descriptors >= %d will be closed before executing a command
closefrom_override: If set, users may override the value of `closefrom' with the -C option
setenv: Allow users to set arbitrary environment variables
env_reset: Reset the environment to a default set of variables
env_check: Environment variables to check for sanity
env_delete: Environment variables to remove
env_keep: Environment variables to preserve
role: SELinux role to use in the new security context
type: SELinux type to use in the new security context
askpass: Path to the askpass helper program
env_file: Path to the sudo-specific environment file
sudoers_locale: Locale to use while parsing sudoers
visiblepw: Allow sudo to prompt for a password even if it would be visisble
pwfeedback: Provide visual feedback at the password prompt when there is user input
fast_glob: Use faster globbing that is less accurate but does not access the filesystem
umask_override: The umask specified in sudoers will override the user's, even if it is more permissive
```

以root权限执行上一条命令

```sh
$ sudo !!
```

以特定用户身份进行编辑文本

```sh
$ sudo -u uggc vi ~www/index.html
// 以 uggc 用户身份编辑  home 目录下www目录中的 index.html 文件
```

列出目前的权限

```sh
$ sudo -l
```

列出 sudo 的版本资讯

```sh
$ sudo -V
```

## ps 命令

> ps 命令用于显示当前进程 (process) 的状态。

### 语法

```
ps [options] [--help]
```

**参数**：

- ps 的参数非常多, 在此仅列出几个常用的参数并大略介绍含义
- -A 列出所有的行程
- -w 显示加宽可以显示较多的资讯
- -au 显示较详细的资讯
- -aux 显示所有包含其他使用者的行程
- au(x) 输出格式 :
- USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
- USER: 行程拥有者
- PID: pid
- %CPU: 占用的 CPU 使用率
- %MEM: 占用的记忆体使用率
- VSZ: 占用的虚拟记忆体大小
- RSS: 占用的记忆体大小
- TTY: 终端的次要装置号码 (minor device number of tty)
- STAT: 该行程的状态:
- D: 不可中断的静止 (通悸□□缜b进行 I/O 动作)
- R: 正在执行中
- S: 静止状态
- T: 暂停执行
- Z: 不存在但暂时无法消除
- W: 没有足够的记忆体分页可分配
- <: 高优先序的行程
- N: 低优先序的行程
- L: 有记忆体分页分配并锁在记忆体内 (实时系统或捱A I/O)
- START: 行程开始时间
- TIME: 执行的时间
- COMMAND:所执行的指令

### 实例

```sh
$ ps -A 显示进程信息
PID TTY     TIME CMD
  1 ?    00:00:02 init
  2 ?    00:00:00 kthreadd
  3 ?    00:00:00 migration/0
  4 ?    00:00:00 ksoftirqd/0
  5 ?    00:00:00 watchdog/0
  6 ?    00:00:00 events/0
  7 ?    00:00:00 cpuset
  8 ?    00:00:00 khelper
  9 ?    00:00:00 netns
  10 ?    00:00:00 async/mgr
  11 ?    00:00:00 pm
  12 ?    00:00:00 sync_supers
  13 ?    00:00:00 bdi-default
  14 ?    00:00:00 kintegrityd/0
  15 ?    00:00:02 kblockd/0
  16 ?    00:00:00 kacpid
  17 ?    00:00:00 kacpi_notify
  18 ?    00:00:00 kacpi_hotplug
  19 ?    00:00:27 ata/0
……省略部分结果
30749 pts/0  00:00:15 gedit
30886 ?    00:01:10 qtcreator.bin
30894 ?    00:00:00 qtcreator.bin 
31160 ?    00:00:00 dhclient
31211 ?    00:00:00 aptd
31302 ?    00:00:00 sshd
31374 pts/2  00:00:00 bash
31396 pts/2  00:00:00 ps
```

显示指定用户信息

```sh
$ ps -u root //显示root进程用户信息
 PID TTY     TIME CMD
  1 ?    00:00:02 init
  2 ?    00:00:00 kthreadd
  3 ?    00:00:00 migration/0
  4 ?    00:00:00 ksoftirqd/0
  5 ?    00:00:00 watchdog/0
  6 ?    00:00:00 events/0
  7 ?    00:00:00 cpuset
  8 ?    00:00:00 khelper
  9 ?    00:00:00 netns
  10 ?    00:00:00 async/mgr
  11 ?    00:00:00 pm
  12 ?    00:00:00 sync_supers
  13 ?    00:00:00 bdi-default
  14 ?    00:00:00 kintegrityd/0
  15 ?    00:00:02 kblockd/0
  16 ?    00:00:00 kacpid
……省略部分结果
30487 ?    00:00:06 gnome-terminal
30488 ?    00:00:00 gnome-pty-helpe
30489 pts/0  00:00:00 bash
30670 ?    00:00:00 debconf-communi 
30749 pts/0  00:00:15 gedit
30886 ?    00:01:10 qtcreator.bin
30894 ?    00:00:00 qtcreator.bin 
31160 ?    00:00:00 dhclient
31211 ?    00:00:00 aptd
31302 ?    00:00:00 sshd
31374 pts/2  00:00:00 bash
31397 pts/2  00:00:00 ps
```

显示所有进程信息，连同命令行

```sh
$ ps -ef //显示所有命令，连带命令行
UID    PID PPID C STIME TTY     TIME CMD
root     1   0 0 10:22 ?    00:00:02 /sbin/init
root     2   0 0 10:22 ?    00:00:00 [kthreadd]
root     3   2 0 10:22 ?    00:00:00 [migration/0]
root     4   2 0 10:22 ?    00:00:00 [ksoftirqd/0]
root     5   2 0 10:22 ?    00:00:00 [watchdog/0]
root     6   2 0 10:22 ?    /usr/lib/NetworkManager
……省略部分结果
root   31302 2095 0 17:42 ?    00:00:00 sshd: root@pts/2 
root   31374 31302 0 17:42 pts/2  00:00:00 -bash
root   31400   1 0 17:46 ?    00:00:00 /usr/bin/python /usr/sbin/aptd
root   31407 31374 0 17:48 pts/2  00:00:00 ps -ef
```

显示含关键字的进程

```sh
$ ps ef | grep xxx
```

## kill 命令

> kill 命令用于删除执行中的程序或工作。
>
> kill 可将指定的信息送至程序。预设的信息为 SIGTERM(15)，可将指定程序终止。若仍无法终止该程序，可使用 SIGKILL(9) 信息尝试强制删除程序。程序或工作的编号可利用 ps 指令或 jobs 指令查看。

### 语法

```
kill [-s <信息名称或编号>][程序]　或　kill [-l <信息编号>]
```

**参数说明**：

- -l <信息编号> 　若不加<信息编号>选项，则-l参数会列出全部的信息名称。
- -s <信息名称或编号> 　指定要送出的信息。
- [程序] 　[程序]可以是程序的PID或是PGID，也可以是工作编号。

### 实例

杀死进程

```sh
$ kill 12345
```

强制杀死进程

```sh
$ kill -KILL 123456
```

发送SIGHUP信号，可以使用一下信号

```sh
$ kill -HUP pid
```

彻底杀死进程

```sh
$ kill -9 123456
```

显示信号

```sh
$ kill -l
1) SIGHUP     2) SIGINT     3) SIGQUIT     4) SIGILL     5) SIGTRAP
6) SIGABRT     7) SIGBUS     8) SIGFPE     9) SIGKILL    10) SIGUSR1
11) SIGSEGV    12) SIGUSR2    13) SIGPIPE    14) SIGALRM    15) SIGTERM
16) SIGSTKFLT    17) SIGCHLD    18) SIGCONT    19) SIGSTOP    20) SIGTSTP
21) SIGTTIN    22) SIGTTOU    23) SIGURG    24) SIGXCPU    25) SIGXFSZ
26) SIGVTALRM    27) SIGPROF    28) SIGWINCH    29) SIGIO    30) SIGPWR
31) SIGSYS    34) SIGRTMIN    35) SIGRTMIN+1    36) SIGRTMIN+2    37) SIGRTMIN+3
38) SIGRTMIN+4    39) SIGRTMIN+5    40) SIGRTMIN+6    41) SIGRTMIN+7    42) SIGRTMIN+8
43) SIGRTMIN+9    44) SIGRTMIN+10    45) SIGRTMIN+11    46) SIGRTMIN+12    47) SIGRTMIN+13
48) SIGRTMIN+14    49) SIGRTMIN+15    50) SIGRTMAX-14    51) SIGRTMAX-13    52) SIGRTMAX-12
53) SIGRTMAX-11    54) SIGRTMAX-10    55) SIGRTMAX-9    56) SIGRTMAX-8    57) SIGRTMAX-7
58) SIGRTMAX-6    59) SIGRTMAX-5    60) SIGRTMAX-4    61) SIGRTMAX-3    62) SIGRTMAX-2
63) SIGRTMAX-1    64) SIGRTMAX
```

杀死指定用户所有进程

```sh
$ kill -9 $(ps -ef | grep hnlinux) //方法一 过滤出hnlinux用户进程 
$ kill -u hnlinux //方法二
```