---
title: git 快速指南
date: 2017-12-06
categories:
- linux
tags:
- linux
- vcs
- git
---

## 简介

### Git 是什么？

Git 是一个开源的分布式版本控制系统。

### 什么是版本控制？

版本控制是一种记录一个或若干文件内容变化，以便将来查阅特定版本修订情况的系统。

### 什么是分布式版本控制系统？

介绍分布式版本控制系统前，有必要先了解一下传统的集中式版本控制系统。

**集中化的版本控制系统**，诸如 CVS，Subversion 等，都有一个单一的集中管理的服务器，保存所有文件的修订版本，而协同工作的人们都通过客户端连到这台服务器，取出最新的文件或者提交更新。

这么做最显而易见的缺点是中央服务器的单点故障。如果宕机一小时，那么在这一小时内，谁都无法提交更新，也就无法协同工作。要是中央服务器的磁盘发生故障，碰巧没做备份，或者备份不够及时，就会有丢失数据的风险。最坏的情况是彻底丢失整个项目的所有历史更改记录。

![img](https://git-scm.com/figures/18333fig0102-tn.png)

**分布式版本控制系统**的客户端并不只提取最新版本的文件快照，而是把代码仓库完整地镜像下来。这么一来，任何一处协同工作用的服务器发生故障，事后都可以用任何一个镜像出来的本地仓库恢复。因为每一次的提取操作，实际上都是一次对代码仓库的完整备份。

![img](https://git-scm.com/figures/18333fig0103-tn.png)

### 为什么使用 Git？

Git 是分布式的。这是 Git 和其它非分布式的版本控制系统，例如 svn，cvs 等，最核心的区别。分布式带来以下好处：

**工作时不需要联网**

首先，分布式版本控制系统根本没有“中央服务器”，每个人的电脑上都是一个完整的版本库，这样，你工作的时候，就不需要联网了，因为版本库就在你自己的电脑上。既然每个人电脑上都有一个完整的版本库，那多个人如何协作呢？比方说你在自己电脑上改了文件A，你的同事也在他的电脑上改了文件A，这时，你们俩之间只需把各自的修改推送给对方，就可以互相看到对方的修改了。

**更加安全**

集中式版本控制系统，一旦中央服务器出了问题，所有人都无法工作。

分布式版本控制系统，每个人电脑中都有完整的版本库，所以某人的机器挂了，并不影响其它人。

## 原理

### 版本库

当你一个项目到本地或创建一个 git 项目，项目目录下会有一个隐藏的 `.git` 子目录。这个目录是 git 用来跟踪管理版本库的，千万不要手动修改。

### 哈希值

Git 中所有数据在存储前都计算校验和，然后以校验和来引用。 这意味着不可能在 Git 不知情时更改任何文件内容或目录内容。 这个功能建构在 Git 底层，是构成 Git 哲学不可或缺的部分。 若你在传送过程中丢失信息或损坏文件，Git 就能发现。

Git 用以计算校验和的机制叫做 SHA-1 散列（hash，哈希）。 这是一个由 40 个十六进制字符（0-9 和 a-f）组成字符串，基于 Git 中文件的内容或目录结构计算出来。 SHA-1 哈希看起来是这样：

```
24b9da6552252987aa493b52f8696cd6d3b00373
```

Git 中使用这种哈希值的情况很多，你将经常看到这种哈希值。 实际上，Git 数据库中保存的信息都是以文件内容的哈希值来索引，而不是文件名。

### 文件状态

在 GIt 中，你的文件可能会处于三种状态之一：

- **已修改（modified）**

  已修改表示修改了文件，但还没保存到数据库中。

- **已暂存（staged）**

  已暂存表示对一个已修改文件的当前版本做了标记，使之包含在下次提交的快照中。

- **已提交（committed）**

  已提交表示数据已经安全的保存在本地数据库中。 

### 工作区域

与文件状态对应的，不同状态的文件在 Git 中处于不同的工作区域。

- **工作区（working）**

  当你 `git clone` 一个项目到本地，相当于在本地克隆了项目的一个副本。

  工作区是对项目的某个版本独立提取出来的内容。 这些从 Git 仓库的压缩数据库中提取出来的文件，放在磁盘上供你使用或修改。


- **暂存区（staging）**

  暂存区是一个文件，保存了下次将提交的文件列表信息，一般在 Git 仓库目录中。 有时候也被称作`‘索引’'，不过一般说法还是叫暂存区。


- **本地仓库（local）**

  提交更新，找到暂存区域的文件，将快照永久性存储到 Git 本地仓库。

- **远程仓库（remote）**

  以上几个工作区都是在本地。为了让别人可以看到你的修改，你需要将你的更新推送到远程仓库。

  同理，如果你想同步别人的修改，你需要从远程仓库拉取更新。

![git-theory.png](http://oyz7npk35.bkt.clouddn.com//image/linux/git/git-theory.png)

## 安装

### Linux

#### Debian/Ubuntu

如果你使用的系统是 Debian/Ubuntu ， 安装命令为：

```sh
$ apt-get install libcurl4-gnutls-dev libexpat1-dev gettext \
> libz-dev libssl-dev
$ apt-get install git-core
$ git --version
git version 1.8.1.2
```

#### Centos/RedHat

如果你使用的系统是 Centos/RedHat ，安装命令为：

```
$ yum install curl-devel expat-devel gettext-devel \
> openssl-devel zlib-devel
$ yum -y install git-core
$ git --version
git version 1.7.1
```

### Windows

在[Git 官方下载地址](https://git-scm.com/downloads)下载 exe 安装包。按照安装向导安装即可。

建议安装 Git Bash 这个 git 的命令行工具。

### Mac

在[Git 官方下载地址](https://git-scm.com/downloads)下载 mac 安装包。按照安装向导安装即可。

## 使用

国外网友制作了一张 Git Cheat Sheet，总结很精炼，各位不妨收藏一下。

本节选择性介绍 git 中比较常用的命令行场景。

![git-cheat-sheet.png](http://oyz7npk35.bkt.clouddn.com//image/linux/git/git-cheat-sheet.png)

### 创建

#### 克隆一个已创建的仓库

```sh
# 通过 SSH
$ git clone ssh://user@domain.com/repo.git

#通过 HTTP
$ git clone http://domain.com/user/repo.git
```

#### 创建一个新的本地仓库

```sh
$ git init
```

### 本地修改

#### 添加修改到暂存区

##### 把指定文件添加到暂存区

```
$ git add xxx
```

##### 把当前所有修改添加到暂存区

```
$ git add .
```

##### 把所有修改添加到暂存区

```
$ git add -A
```

#### 提交修改到本地仓库

##### 提交本地的所有修改

```
$ git commit -a
```

##### 提交之前已标记的变化

```
$ git commit
```

##### 附加消息提交

```
$ git commit -m 'message here'
```

#### 储藏

我个人更喜欢称之为存草稿。

##### 将修改作为当前分支的草稿保存

```
git stash apply
```

##### 删除最新一次的 stashed changes：

```
git stash drop
```
### 查看

##### 显示工作路径下已修改的文件：

```
$ git status
```

##### 显示与上次提交版本文件的不同：

```
$ git diff
```

### 搜索

##### 从当前目录的所有文件中查找文本内容：

```
$ git grep "Hello"

```

##### 在某一版本中搜索文本：

```
$ git grep "Hello" v2.5
```

### 提交历史

##### 从最新提交开始，显示所有的提交记录（显示hash， 作者信息，提交的标题和时间）：

```
$ git log

```

##### 显示所有提交（仅显示提交的hash和message）：

```
$ git log --oneline

```

##### 显示某个用户的所有提交：

```
$ git log --author="username"

```

##### 显示某个文件的所有修改：

```
$ git log -p <file>

```

##### 仅显示远端<remote/master>分支与远端<origin/master>分支提交记录的差集：

```
$ git log --oneline <origin/master>..<remote/master> --left-right

```

##### 谁，在什么时间，修改了文件的什么内容：

```
$ git blame <file>

```

##### 显示reflog：

```
$ git reflog show 

```

##### 删除reflog：

```
$ git reflog delete
```

### 分支与标签

##### 列出所有的分支：

```
$ git branch

```

##### 列出所有的远端分支：

```
$ git branch -r

```

##### 切换分支：

```
$ git checkout <branch>

```

##### 创建并切换到新分支:

```
$ git checkout -b <branch>

```

##### 基于当前分支创建新分支：

```
$ git branch <new-branch>

```

##### 基于远程分支创建新的可追溯的分支：

```
$ git branch --track <new-branch> <remote-branch>

```

##### 删除本地分支:

```
$ git branch -d <branch>

```

##### 强制删除一个本地分支：

*将会丢失未合并的修改！*

```
$ git branch -D <branch>

```

##### 给当前版本打标签：

```
$ git tag <tag-name>

```

##### 给当前版本打标签并附加消息：

```
$ git tag -a <tag-name>
```

### 更新与发布

##### 列出当前配置的远程端：

```
$ git remote -v

```

##### 显示远程端的信息：

```
$ git remote show <remote>

```

##### 添加新的远程端：

```
$ git remote add <remote> <url>

```

##### 下载远程端版本，但不合并到HEAD中：

```
$ git fetch <remote>

```

##### 下载远程端版本，并自动与HEAD版本合并：

```
$ git remote pull <remote> <url>

```

##### 将远程端版本合并到本地版本中：

```
$ git pull origin master

```

##### 以rebase方式将远端分支与本地合并：

```
git pull --rebase <remote> <branch>

```

##### 将本地版本发布到远程端：

```
$ git push remote <remote> <branch>

```

##### 删除远程端分支：

```
$ git push <remote> :<branch> (since Git v1.5.0)
or
git push <remote> --delete <branch> (since Git v1.7.0)

```

##### 发布标签:

```
$ git push --tags
```

### 合并与重置

合并与重置(Rebase)

##### 将分支合并到当前HEAD中：

```
$ git merge <branch>

```

##### 将当前HEAD版本重置到分支中:

*请勿重置已发布的提交!*

```
$ git rebase <branch>

```

##### 退出重置:

```
$ git rebase --abort

```

##### 解决冲突后继续重置：

```
$ git rebase --continue

```

##### 使用配置好的merge tool 解决冲突：

```
$ git mergetool

```

##### 在编辑器中手动解决冲突后，标记文件为`已解决冲突`：

```
$ git add <resolved-file>

```

```
$ git rm <resolved-file>

```

##### 合并提交：

```
$ git rebase -i <commit-just-before-first>

```

把上面的内容替换为下面的内容：

原内容：

```
pick <commit_id>
pick <commit_id2>
pick <commit_id3>

```

替换为：

```
pick <commit_id>
squash <commit_id2>
squash <commit_id3>
```

### 撤销

##### 放弃工作目录下的所有修改：

```
$ git reset --hard HEAD

```

##### 移除缓存区的所有文件（i.e. 撤销上次`git add`）:

```
$ git reset HEAD

```

##### 放弃某个文件的所有本地修改：

```
$ git checkout HEAD <file>

```

##### 重置一个提交（通过创建一个截然不同的新提交）

```
$ git revert <commit>

```

##### 将HEAD重置到指定的版本，并抛弃该版本之后的所有修改：

```
$ git reset --hard <commit>

```

##### 用远端分支强制覆盖本地分支：

```
git reset --hard <remote/branch> e.g., upstream/master, origin/my-feature

```

##### 将HEAD重置到上一次提交的版本，并将之后的修改标记为未添加到缓存区的修改：

```
$ git reset <commit>

```

##### 将HEAD重置到上一次提交的版本，并保留未提交的本地修改：

```
$ git reset --keep <commit>

```

##### 删除添加`.gitignore`文件前错误提交的文件：

```
$ git rm -r --cached .
$ git add .
$ git commit -m "remove xyz file"
```

## 资料

[git 官网](https://git-scm.com/) | [git 官方 Github](https://github.com/git/git)

[廖雪峰的 git 教程](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)

[git-cheat-sheet](https://github.com/arslanbilal/git-cheat-sheet)

[github-cheat-sheet](https://github.com/tiimgreen/github-cheat-sheet)