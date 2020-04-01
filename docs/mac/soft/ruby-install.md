# 安装 Ruby

## 安装 rvm

### 下载安装 rvm

- 先安装好 RVM
- RVM 是一个便捷的多版本 Ruby 环境的管理和切换工具
   官网：[https://rvm.io/](https://links.jianshu.com/go?to=https%3A%2F%2Frvm.io%2F)
- 在终端控制台命令：
   $ curl -sSL [https://get.rvm.io](https://links.jianshu.com/go?to=https%3A%2F%2Fget.rvm.io) | bash -s stable    之后按回车键
- 截止到目前 最新的版本是 1.29.9
- 如下所示：

```shell
:~ admin$ curl -sSL https://get.rvm.io | bash -s stable
Downloading https://github.com/rvm/rvm/archive/1.29.1.tar.gz
Downloading https://github.com/rvm/rvm/releases/download/1.29.1/1.29.1.tar.gz.asc
Found PGP signature at: 'https://github.com/rvm/rvm/releases/download/1.29.1/1.29.1.tar.gz.asc',
but no GPG software exists to validate it, skipping.

Installing RVM to /Users/admin/.rvm/
    Adding rvm PATH line to /Users/admin/.profile /Users/admin/.mkshrc /Users/admin/.bashrc /Users/admin/.zshrc.
    Adding rvm loading line to /Users/admin/.profile /Users/admin/.bash_profile /Users/admin/.zlogin.
Installation of RVM in /Users/admin/.rvm/ is almost complete:

  * To start using RVM you need to run `source /Users/admin/.rvm/scripts/rvm`
    in all your open shell windows, in rare cases you need to reopen all shell windows.

# admin,
#
#   Thank you for using RVM!
#   We sincerely hope that RVM helps to make your life easier and more enjoyable!!!
#
# ~Wayne, Michal & team.

In case of problems: https://rvm.io/help and https://twitter.com/rvm_io
```

等待一两分钟，成功安装好 RVM。

### 设置环境变量



```shell
# 1.2 然后，载入 RVM 环境：
$ source /etc/profile.d/rvm.sh
$ sudo chmod -R 777 /usr/local/rvm/archives

# 1.3 修改 RVM 下载 Ruby 的源，到 Ruby China 的镜像
$ echo "ruby_url=https://cache.ruby-china.com/pub/ruby" > /usr/local/rvm/user/db
$ rvm install 2.7.0 --disable-binary

// 如下所示：
AdmindeiMac-4:~ admin$ source ~/.rvm/scripts/rvm
AdmindeiMac-4:~ admin$ echo "ruby_url=https://cache.ruby-china.org/pub/ruby" > ~/.rvm/user/db
AdmindeiMac-4:~ admin$ rvm -v
rvm 1.29.9 (latest) by Michal Papis, Piotr Kuczynski, Wayne E. Seguin [https://rvm.io/]
如果能显示版本号,则安装成功。
```

## 参考资料

- [MAC_Ruby 安装](https://www.jianshu.com/p/c073e6fc01f5)