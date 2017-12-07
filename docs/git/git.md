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

### 为什么使用 Git？

Git 是分布式的。这是 Git 和其它非分布式的版本控制系统，例如 svn，cvs 等，最核心的区别。分布式带来以下好处：

**工作时不需要联网**

首先，分布式版本控制系统根本没有“中央服务器”，每个人的电脑上都是一个完整的版本库，这样，你工作的时候，就不需要联网了，因为版本库就在你自己的电脑上。既然每个人电脑上都有一个完整的版本库，那多个人如何协作呢？比方说你在自己电脑上改了文件A，你的同事也在他的电脑上改了文件A，这时，你们俩之间只需把各自的修改推送给对方，就可以互相看到对方的修改了。

**更加安全**

集中式版本控制系统，一旦中央服务器出了问题，所有人都无法工作。

分布式版本控制系统，每个人电脑中都有完整的版本库，所以某人的机器挂了，并不影响其它人。

### 原理

![git-theory.png](http://oyz7npk35.bkt.clouddn.com//image/linux/git/git-theory.png)

先介绍几个核心概念，介绍概念过程中的命令具体用法会在后面详述，这里暂不做介绍：

#### 版本库

当你一个项目到本地或创建一个 git 项目，项目目录下会有一个隐藏的 `.git` 子目录。这个目录是 git 用来跟踪管理版本库的，千万不要手动修改。

#### 工作区（WORKING）

当你 `git clone` 一个项目到本地，本地的项目目录相当于一个工作副本，这就是工作区。

#### 暂存区（STAGING）

当你在工作区上执行增删改操作，致使文件状态发生变化，可以通过 `git add` 暂存，存储的区域就是暂存区。

#### 本地仓库（LOCAL）

通过 `git commit` 命令，可以将所有暂存的记录提交到当前分支，这时内容被保存在了本地仓库。此时，工作区相当于是清空了。

#### REMOTE（远程仓库）

以上的所有版本控制都是在你的本地完成，远程仓库并没有保存你的修改，换句话说，其他人并不知道你的工作。为了让所以人都能看到你的修改，你需要使用 `git push` 将自己的修改推送到远程仓库上。

同理，如果你想知道别人在远程仓库上做了什么修改，你可以使用 `git fetch` 或 `git pull` 同步别人的修改。

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

![git-cheat-sheet.png](http://oyz7npk35.bkt.clouddn.com//image/linux/git/git-cheat-sheet.png)

### 创建

##### 复制一个已创建的仓库:

```
# 通过 SSH
$ git clone ssh://user@domain.com/repo.git

#通过 HTTP
$ git clone http://domain.com/user/repo.git
```

##### 创建一个新的本地仓库:

```
$ git init
```

### 本地修改

##### 显示工作路径下已修改的文件：

```
$ git status
```

##### 显示与上次提交版本文件的不同：

```
$ git diff
```

##### 把当前所有修改添加到下次提交中：

```
$ git add .
```

##### 把对某个文件的修改添加到下次提交中：

```
$ git add -p <file>
```

##### 提交本地的所有修改：

```
$ git commit -a
```

##### 提交之前已标记的变化：

```
$ git commit
```

##### 附加消息提交：

```
$ git commit -m 'message here'
```

##### 提交，并将提交时间设置为之前的某个日期:

```
git commit --date="`date --date='n day ago'`" -am "Commit Message"
```

##### 修改上次提交

*请勿修改已发布的提交记录!*

```
$ git commit --amend
```

##### 修改上次提交的committer date：

```
GIT_COMMITTER_DATE="date" git commit --amend
```

##### 修改上次提交的author date：

```
git commit --amend --date="date"
```

##### 把当前分支中未提交的修改移动到其他分支：

```
git stash
git checkout branch2
git stash pop
```

##### 将 stashed changes 应用到当前分支：

```
git stash apply
```

##### 删除最新一次的 stashed changes：

```
git stash drop
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