# oh-my-zsh 应用

## 1. Zsh 简介

### 1.1. Zsh 是什么

使用 Linux 的人都知道：***Shell_ 是一个用 C 语言编写的程序,它是用户使用 Linux 的桥梁。_Shell_ 既是一种命令语言,又是一种程序设计语言**。

Shell 的类型有很多种，linux 下默认的是 bash，虽然 bash 的功能已经很强大，但对于以懒惰为美德的程序员来说，bash 的提示功能不够强大，界面也不够炫，并非理想工具。

[**Zsh**](http://www.zsh.org/) 也是一种 Shell（据传说 99% 的 Bash 操作 和 Zsh 是相同的），它的功能极其强大，只是配置过于复杂，起初只有极客才在用。后来，出现了一个名叫 [**oh-my-zsh**](https://github.com/robbyrussell/oh-my-zsh) 的开源项目，使用 zsh 就变得十分简易了。

## 2. Zsh 安装

### 2.1. 环境要求

- CentOS 6.7 64 bit
- root 用户

### 2.2. 安装 zsh

- 先看下你的 CentOS 支持哪些 shell：`cat /etc/shells`，正常结果应该是这样的：

```bash
/bin/sh
/bin/bash
/sbin/nologin
/bin/dash
/bin/tcsh
/bin/csh
```

如果已经有 zsh ，那么我们就不必安装了。

- CentOS 安装：`sudo yum install -y zsh`
- Ubuntu 安装：`sudo apt-get install -y zsh`
- 检查系统的 shell：`cat /etc/shells`，你会发现多了一个：`/bin/zsh`

### 2.3. 安装 oh-my-zsh

使用 [**Zsh**](http://www.zsh.org/)，怎么能离开灵魂伴侣 [**oh-my-zsh**](https://github.com/robbyrussell/oh-my-zsh)？

```bash
# 安装 oh-my-zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
```

### 2.4. 配置 oh-my-zsh

#### 2.4.1. 插件

> oh-my-zsh 插件太多，不一一列举，请参考：[oh-my-zsh 插件列表](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins)

- 启用 oh-my-zsh 中自带的插件。
- 查看 oh-my-zsh 插件数：`ls -l /root/.oh-my-zsh/plugins |grep "^d"|wc -l`
- 编辑配置文件：`vim /root/.zshrc`
- 插件推荐：
  - [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions)
    - 这个插件会对历史命令一些补全，类似 fish 终端
    - 安装，复制该命令：`git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-\~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions` - 编辑：`vim \~/.zshrc`，找到这一行，后括号里面的后面添加：`plugins=( 前面的一些插件名称，换行，加上：zsh-autosuggestions)` - 刷新下配置：`source \~/.zshrc`
  - extract
    - 功能强大的解压插件，所有类型的文件解压一个命令 x 全搞定，再也不需要去记 tar 后面到底是哪几个参数了。
  - z
    - 强大的目录自动跳转命令，会记忆你曾经进入过的目录，用模糊匹配快速进入你想要的目录。
  - [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting)
    - 这个插件会对终端命令高亮显示,比如正确的拼写会是绿色标识,否则是红色,另外对于一些 shell 输出语句也会有高亮显示,算是不错的辅助插件
    - 安装，复制该命令：`git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-\~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
    - 编辑：`vim \~/.zshrc`，找到这一行，后括号里面的后面添加：`plugins=( 前面的一些插件名称，换行，加上：zsh-syntax-highlighting)` - 刷新下配置：`source \~/.zshrc`
  - [`wd`](https://github.com/mfaerevaag/wd)
    - 简单地讲就是给指定目录映射一个全局的名字，以后方便直接跳转到这个目录，比如：
    - 编辑配置文件，添加上 wd 的名字：`vim /root/.zshrc`
    - 我常去目录：**/opt/setups**，每次进入该目录下都需要这样：`cd /opt/setups`
    - 现在用 wd 给他映射一个快捷方式：`cd /opt/setups ; wd add setups`
    - 以后我在任何目录下只要运行：`wd setups` 就自动跑到 /opt/setups 目录下了
  - [`autojump`](https://github.com/wting/autojump)
    - 这个插件会记录你常去的那些目录，然后做一下权重记录，你可以用这个命令看到你的习惯：`j --stat`，如果这个里面有你的记录，那你就只要敲最后一个文件夹名字即可进入，比如我个人习惯的 program：`j program`，就可以直接到：`/usr/program`
    - 插件下载：`wget https://github.com/downloads/wting/autojump/autojump_v21.1.2.tar.gz`
    - 解压：`tar zxvf autojump_v21.1.2.tar.gz`
    - 进入解压后目录并安装：`cd autojump_v21.1.2/ ; ./install.sh`
    - 再执行下这个：`source /etc/profile.d/autojump.sh`
    - 编辑配置文件，添加上 autojump 的名字：`vim /root/.zshrc`

#### 2.4.2. 主题

> oh-my-zsh 主题太多，不一一列举，请参考：[oh-my-zsh 主题列表](https://github.com/robbyrussell/oh-my-zsh/wiki/Themes)

- 查看 oh-my-zsh 主题数：`ls -l /root/.oh-my-zsh/themes |grep "^-"|wc -l`
- 个人比较推荐的是（排名有先后）：
  - `ys`
  - `agnoster`
  - `avit`
  - `blinks`
- 编辑配置文件：`vim /root/.zshrc`
- 配置好新主题需要重新连接 shell 才能看到效果

zsh 效果如下：

![img](https://cloud.githubusercontent.com/assets/2618447/6316862/70f58fb6-ba03-11e4-82c9-c083bf9a6574.png)
## 3. 快捷键

- 呃，这个其实可以不用讲的，你自己用的时候你自己会发现的，各种便捷，特别是用 Tab 多的人一定会有各种惊喜的。
- 使用 ctrl-r 来搜索命令历史记录。按完此快捷键后，可以输入关键命令词语，如果历史记录有含有此词语会显示出来。
- 命令别名： - 在命令行中输入 alias 可以查看已经有的命令别名 - 自己新增一些别名，编辑文件：`vim \~/.zshrc`，在文件加入下面格式的命令，比如以下是网友提供的一些思路：

```shell
alias cls='clear'
alias ll='ls -l'
alias la='ls -a'
alias grep="grep --color=auto"
alias -s html='vim'   # 在命令行直接输入后缀为 html 的文件名，会在 Vim 中打开
alias -s rb='vim'     # 在命令行直接输入 ruby 文件，会在 Vim 中打开
alias -s py='vim'      # 在命令行直接输入 python 文件，会用 vim 中打开，以下类似
alias -s js='vim'
alias -s c='vim'
alias -s java='vim'
alias -s txt='vim'
alias -s gz='tar -xzvf' # 在命令行直接输入后缀为 gz 的文件名，会自动解压打开
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
```

## 4. 参考资料

- [oh-my-zsh Github](https://github.com/robbyrussell/oh-my-zsh)
