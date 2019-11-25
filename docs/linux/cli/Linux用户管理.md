# Linux 用户管理

> 关键词：`groupadd`, `groupdel`, `groupmod`, `useradd`, `userdel`, `usermod`, `passwd`, `su`, `sudo`

## 1. Linux 用户管理要点

- 创建用户组 - 使用 [groupadd](#groupadd)
- 删除用户组 - 使用 [groupdel](#groupdel)
- 修改用户组信息 - 使用 [groupmod](#groupmod)
- 创建用户 - 使用 [useradd](#useradd)
- 删除用户 - 使用 [userdel](#userdel)
- 修改用户信息 - 使用 [usermod](#usermod)
- 设置用户认证信息 - 使用 [passwd](#passwd)
- 切换用户 - 使用 [su](#su)
- 当前用户想执行没有权限执行的命令时，使用其他用户身份去执行 - 使用 [sudo](#sudo)

## 2. 命令常见用法

### 2.1. groupadd

> groupadd 命令用于创建一个新的用户组，新用户组的信息将被添加到系统文件中。
>
> 参考：http://man.linuxde.net/groupadd

示例：

```bash
# 建立一个新组，并设置组 ID 加入系统
$ groupadd -g 344 jsdigname
```

### 2.2. groupdel

> groupdel 命令用于删除指定的用户组，本命令要修改的系统文件包括 `/ect/group` 和 `/ect/gshadow`。若该群组中仍包括某些用户，则必须先删除这些用户后，方能删除群组。
>
> 参考：http://man.linuxde.net/groupdel

示例：

```bash
$ groupadd damon  # 创建damon用户组
$ groupdel damon  # 删除这个用户组
```

### 2.3. groupmod

> groupmod 命令更改群组识别码或名称。需要更改群组的识别码或名称时，可用 groupmod 指令来完成这项工作。
>
> 参考：http://man.linuxde.net/groupmod

### 2.4. useradd

> useradd 命令用于 Linux 中创建的新的系统用户。useradd 可用来建立用户帐号。帐号建好之后，再用 passwd 设定帐号的密码．而可用 userdel 删除帐号。使用 useradd 指令所建立的帐号，实际上是保存在 `/etc/passwd` 文本文件中。
>
> 参考：http://man.linuxde.net/useradd

示例：

```bash
# 新建用户加入组
$ useradd –g sales jack –G company,employees    # -g：加入主要组、-G：加入次要组

# 建立一个新用户账户，并设置 ID
$ useradd caojh -u 544
```

### 2.5. userdel

> userdel 命令用于删除给定的用户，以及与用户相关的文件。若不加选项，则仅删除用户帐号，而不删除相关文件。
>
> 参考：http://man.linuxde.net/userdel

示例：

userdel 命令很简单，比如我们现在有个用户 linuxde，其 home 目录位于`/var`目录中，现在我们来删除这个用户：

```bash
$ userdel linuxde       # 删除用户linuxde，但不删除其家目录及文件；
$ userdel -r linuxde    # 删除用户linuxde，其 home 目录及文件一并删除；
```

### 2.6. usermod

> usermod 命令用于修改用户的基本信息。usermod 命令不允许你改变正在线上的使用者帐号名称。当 usermod 命令用来改变 user id，必须确认这名 user 没在电脑上执行任何程序。你需手动更改使用者的 crontab 档。也需手动更改使用者的 at 工作档。采用 NIS server 须在 server 上更动相关的 NIS 设定。
>
> 参考：http://man.linuxde.net/usermod

示例：

```bash
# 将 newuser2 添加到组 staff 中
$ usermod -G staff newuser2

# 修改 newuser 的用户名为 newuser1
$ usermod -l newuser1 newuser

# 锁定账号 newuser1
$ usermod -L newuser1

# 解除对 newuser1 的锁定
$ usermod -U newuser1
```

### 2.7. passwd

> passwd 命令用于设置用户的认证信息，包括用户密码、密码过期时间等。系统管理者则能用它管理系统用户的密码。只有管理者可以指定用户名称，一般用户只能变更自己的密码。
>
> 参考：http://man.linuxde.net/passwd

示例：

```bash
# 如果是普通用户执行 passwd 只能修改自己的密码。
# 如果新建用户后，要为新用户创建密码，则用 passwd 用户名，注意要以 root 用户的权限来创建。
$ passwd linuxde    # 更改或创建linuxde用户的密码；
Changing password for user linuxde.
New UNIX password:          # 请输入新密码；
Retype new UNIX password:   # 再输入一次；
passwd: all authentication tokens updated successfully. # 成功；

# 普通用户如果想更改自己的密码，直接运行 passwd 即可，比如当前操作的用户是 linuxde。
$ passwd
Changing password for user linuxde. # 更改linuxde用户的密码；
(current) UNIX password:   # 请输入当前密码；
New UNIX password:         # 请输入新密码；
Retype new UNIX password:  # 确认新密码；
passwd: all authentication tokens updated successfully. # 更改成功；

# 比如我们让某个用户不能修改密码，可以用`-l`选项来锁定：
$ passwd -l linuxde    # 锁定用户linuxde不能更改密码；
Locking password for user linuxde.
passwd: Success           # 锁定成功；

$ su linuxde   # 通过su切换到linuxde用户；
$ passwd      # linuxde来更改密码；
Changing password for user linuxde.
Changing password for linuxde
(current) UNIX password:          # 输入linuxde的当前密码；
passwd: Authentication token manipulation error     # 失败，不能更改密码；

$ passwd -d linuxde  # 清除linuxde用户密码；
Removing password for user linuxde.
passwd: Success                         # 清除成功；

$ passwd -S linuxde    # 查询linuxde用户密码状态；
Empty password.                         # 空密码，也就是没有密码；
```

### 2.8. su

> su 命令用于切换当前用户身份到其他用户身份，变更时须输入所要变更的用户帐号与密码。
>
> 参考：http://man.linuxde.net/su

示例：

```bash
# 变更帐号为 root 并在执行 ls 指令后退出变回原使用者：
$ su -c ls root

# 变更帐号为 root 并传入`-f`选项给新执行的 shell：
$ su root -f

# 变更帐号为 test 并改变工作目录至 test 的家目录：
$ su -test
```

### 2.9. sudo

> sudo 命令用来以其他身份来执行命令，预设的身份为 root。在 `/etc/sudoers` 中设置了可执行 sudo 指令的用户。若其未经授权的用户企图使用 sudo，则会发出警告的邮件给管理员。用户使用 sudo 时，必须先输入密码，之后有 5 分钟的有效期限，超过期限则必须重新输入密码。
>
> 参考：http://man.linuxde.net/sudo

示例：

```bash
# 指定用户执行命令
$ sudo -u userb ls -l
# 列出目前的权限
$ sudo -l
# 显示sudo设置
$ sudo -L
```

#### 2.9.1. 给普通用户授权 sudo

假设要给普通用户 mary 配置 sudo 权限：

1. `/etc/sudoers` 文件存放了 sudo 的相关用户，但是默认是没有写权限的，所以需要设为可写：`chmod u+w /etc/sudoers`
2. 在该文件中添加 `mary ALL=(ALL) ALL` ，保存并退出，让 mary 具有 sudo 的所有权限
3. 再将 `/etc/sudoers` 的权限恢复到默认状态：`chmod u-w /etc/sudoers`

#### 2.9.2. 免密码授权 sudo

与给普通用户授权 sudo 类似，区别仅在于第 2 步：`mary ALL=(ALL) NOPASSWD: ALL`。
