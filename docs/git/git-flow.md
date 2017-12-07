---
title: git-flow 工作流
date: 2017-12-06
categories:
- linux
tags:
- linux
- vcs
- git
---

# git-flow 工作流

## git-flow 模型

[@nvie](http://twitter.com/nvie) 同学发表了博客 [“一种有效的Git分支模型”](http://nvie.com/git-model), 文章讲解了他是如何让自己的[Git](http://www.oschina.net/p/git)仓库保持整洁，除此之外，他发布了git-flow; 一个可以轻松实现该模型的Git扩展。

![git-flow.png](http://oyz7npk35.bkt.clouddn.com//image/linux/git/git-flow.png)

`Gitflow`工作流仍然用中央仓库作为所有开发者的交互中心。和其它的工作流一样，开发者在本地工作并`push`分支到要中央仓库中。

### 历史分支

相对使用仅有的一个`master`分支，`Gitflow`工作流使用2个分支来记录项目的历史。`master`分支存储了正式发布的历史，而`develop`分支作为功能的集成分支。这样也方便`master`分支上的所有提交分配一个版本号。

![img](https://raw.githubusercontent.com/quickhack/translations/master/git-workflows-and-tutorials/images/git-workflow-release-cycle-1historical.png)

剩下要说明的问题围绕着这2个分支的区别展开。

### 功能分支

每个新功能位于一个自己的分支，这样可以[`push`到中央仓库以备份和协作](https://www.atlassian.com/git/tutorial/remote-repositories#!push)。但功能分支不是从`master`分支上拉出新分支，而是使用`develop`分支作为父分支。当新功能完成时，[合并回`develop`分支](https://www.atlassian.com/git/tutorial/git-branches#!merge)。新功能提交应该从不直接与`master`分支交互。

![img](https://raw.githubusercontent.com/quickhack/translations/master/git-workflows-and-tutorials/images/git-workflow-release-cycle-2feature.png)

注意，从各种含义和目的上来看，功能分支加上`develop`分支就是功能分支工作流的用法。但`Gitflow`工作流没有在这里止步。

### 发布分支

![img](https://raw.githubusercontent.com/quickhack/translations/master/git-workflows-and-tutorials/images/git-workflow-release-cycle-3release.png)

一旦`develop`分支上有了做一次发布（或者说快到了既定的发布日）的足够功能，就从`develop`分支上`fork`一个发布分支。新建的分支用于开始发布循环，所以从这个时间点开始之后新的功能不能再加到这个分支上 —— 这个分支只应该做`Bug`修复、文档生成和其它面向发布任务。一旦对外发布的工作都完成了，发布分支合并到`master`分支并分配一个版本号打好`Tag`。另外，这些从新建发布分支以来的做的修改要合并回`develop`分支。

使用一个用于发布准备的专门分支，使得一个团队可以在完善当前的发布版本的同时，另一个团队可以继续开发下个版本的功能。
这也打造定义良好的开发阶段（比如，可以很轻松地说，『这周我们要做准备发布版本4.0』，并且在仓库的目录结构中可以实际看到）。

常用的分支约定：

`用于新建发布分支的分支: develop用于合并的分支: master分支命名: release-* 或 release/*`

### 维护分支

![img](https://raw.githubusercontent.com/quickhack/translations/master/git-workflows-and-tutorials/images/git-workflow-release-cycle-4maintenance.png)

维护分支或说是热修复（`hotfix`）分支用于生成快速给产品发布版本（`production releases`）打补丁，这是唯一可以直接从`master`分支`fork`出来的分支。修复完成，修改应该马上合并回`master`分支和`develop`分支（当前的发布分支），`master`分支应该用新的版本号打好`Tag`。

为`Bug`修复使用专门分支，让团队可以处理掉问题而不用打断其它工作或是等待下一个发布循环。你可以把维护分支想成是一个直接在`master`分支上处理的临时发布。

## 安装

- 你需要有一个可以工作的 git 作为前提。
- Git flow 可以工作在 OSX, Linux 和 Windows之下

### OSX Homebrew

```
$ brew install git-flow

```

### OSX Macports

```
$ port install git-flow

```

### Linux

```
$ apt-get install git-flow

```

### Windows (Cygwin):

安装 git-flow, 你需要 wget 和 util-linux。

```
$ wget -q -O - --no-check-certificate https://github.com/nvie/gitflow/raw/develop/contrib/gitflow-installer.sh | bash
```
## Git Flow代码示例

![git-flow-commands.png](http://oyz7npk35.bkt.clouddn.com//image/linux/git/git-flow-commands.png)

### 开始

- 为了自定义你的项目，Git flow 需要初始化过程。
- 使用 git-flow，从初始化一个现有的 git 库内开始。
- 初始化，你必须回答几个关于分支的命名约定的问题。建议使用默认值。

```
git flow init

```

### 特性

- 为即将发布的版本开发新功能特性。
- 这通常只存在开发者的库中。

##### 创建一个新特性:

下面操作创建了一个新的feature分支，并切换到该分支

```
git flow feature start MYFEATURE

```

##### 完成新特性的开发:

完成开发新特性。这个动作执行下面的操作：

1. 合并 MYFEATURE 分支到 'develop'
2. 删除这个新特性分支
3. 切换回 'develop' 分支

```
git flow feature finish MYFEATURE

```

##### 发布新特性:

你是否合作开发一项新特性？ 发布新特性分支到远程服务器，所以，其它用户也可以使用这分支。

```
git flow feature publish MYFEATURE

```

##### 取得一个发布的新特性分支:

取得其它用户发布的新特性分支。

```
git flow feature pull origin MYFEATURE

```

##### 追溯远端上的特性:

通过下面命令追溯远端上的特性

```
git flow feature track MYFEATURE

```

### 做一个release版本

- 支持一个新的用于生产环境的发布版本。
- 允许修正小问题，并为发布版本准备元数据。

##### 开始创建release版本:

- 开始创建release版本，使用 git flow release 命令。
- 'release' 分支的创建基于 'develop' 分支。
- 你可以选择提供一个 [BASE]参数，即提交记录的 sha-1 hash 值，来开启动 release 分支。
- 这个提交记录的 sha-1 hash 值必须是'develop' 分支下的。

```
git flow release start RELEASE [BASE]

```

创建 release 分支之后立即发布允许其它用户向这个 release 分支提交内容是个明智的做法。命令十分类似发布新特性：

```
git flow release publish RELEASE

```

(你可以通过 `git flow release track RELEASE` 命令追溯远端的 release 版本)

##### 完成 release 版本:

完成 release 版本是一个大 git 分支操作。它执行下面几个动作：

1. 归并 release 分支到 'master' 分支。
2. 用 release 分支名打 Tag
3. 归并 release 分支到 'develop'
4. 移除 release 分支。

```
git flow release finish RELEASE

```

不要忘记使用`git push --tags`将tags推送到远端

### 紧急修复

紧急修复来自这样的需求：生产环境的版本处于一个不预期状态，需要立即修正。有可能是需要修正 master 分支上某个 TAG 标记的生产版本。

##### 开始 git flow 紧急修复:

像其它 git flow 命令一样, 紧急修复分支开始自：

```
$ git flow hotfix start VERSION [BASENAME]

```

VERSION 参数标记着修正版本。你可以从 `[BASENAME]开始，`[BASENAME]`为finish release时填写的版本号

##### 完成紧急修复:

当完成紧急修复分支，代码归并回 develop 和 master 分支。相应地，master 分支打上修正版本的 TAG。

```
git flow hotfix finish VERSION
```

## 资料

[git 官网](https://git-scm.com/) | [git 官方 Github](https://github.com/git/git)

[廖雪峰的 git 教程](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)

[https://github.com/arslanbilal/git-cheat-sheet/blob/master/other-sheets/git-cheat-sheet-zh.md](https://github.com/arslanbilal/git-cheat-sheet/blob/master/other-sheets/git-cheat-sheet-zh.md)
