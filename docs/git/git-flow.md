# git-flow 工作流

## 集中式 vs 分布式

在分布式版本控制工具 [**Git**](https://git-scm.com/) 之前，我一直用的是集中式版本控制工具，具体来说，我用过 **[ClearCase](http://www-03.ibm.com/software/products/en/clearcase)**（简称 cc）、**[Subversion](https://tortoisesvn.net/)**（简称 svn）。

这里，结合我的一点个人经验，谈谈这几个工具的特点。

### 集中式版本控制

**[ClearCase](http://www-03.ibm.com/software/products/en/clearcase)** 是 IBM 的产品。IBM 的产品总给人一种过于重型化的感觉，似乎它们的产品什么都想做，结果反而让人觉得太复杂，不好用（想想曾经被 Notes 邮箱支配的恐惧吧）。**[ClearCase](http://www-03.ibm.com/software/products/en/clearcase)** 一如既往，功能复杂，但是操作很繁琐。

**[Subversion](https://tortoisesvn.net/)** 由于 logo 是乌龟，所以也常被称为小乌龟。它的优点是：GUI 工具做的很细致，易于上手；安全控制和权限控制非常细粒度（目录级别的管控）；对于特别大型的项目，每个开发者都拷贝完整的镜像到本地，会占用较大的磁盘空间，还不如将所有数据都存放在大型服务器上。

### 分布式版本控制

分布式版本控制工具当然不止 Git，但是受 Github 的影响，Git 无疑是最火，用户最广的工具。

Git 的优点主要就体现在分布式设计上：

- 支持离线工作。除了同步远程仓库，基本都是在本地完成工作。
- 安全稳定。集中式版本控制工具，要求所有机器将每次修改都推送到中央服务器，一旦中央服务器宕机，所有人都不能工作。分布式版本控制工具的每台机器克隆远程仓库到本地后，都拥有完整的镜像，一台机器宕机，不影响其他人工作，而且数据容易恢复。
- Git 自身有着优秀的分支模型，拉分支、打标签都非常便捷。

### 小结

**[ClearCase](http://www-03.ibm.com/software/products/en/clearcase)** 比较难用，谁用谁知道。

**[Subversion](https://tortoisesvn.net/)** 由于自身的优点，还是有不少公司仍在使用的。不能说不使用分布式版本控制就一定是 out 了，很多时候也是基于公司应用场景的考量（大公司往往更看重安全和权限控制）。个人认为 svn 还是挺好用的，除了拉分支确实比较麻烦些，但这也是基于 svn 本身权限控制的考虑。

[**Git**](https://git-scm.com/) 由于其开源免费、分布式特性，深受互联网公司的青睐。

## 版本管理的挑战

Git 是一个非常优秀的版本控制工具，但是在实际版本管理中，仍然会遇到一些问题：

1. 如何开始一个Feature的开发，而不影响别的Feature？
2. 由于很容易创建新分支，分支多了如何管理，时间久了，如何知道每个分支是干什么的？
3. 哪些分支已经合并回了主干？
4. 如何进行Release的管理？开始一个Release的时候如何冻结Feature, 如何在Prepare Release的时候，开发人员可以继续开发新的功能？
5. 线上代码出Bug了，如何快速修复？而且修复的代码要包含到开发人员的分支以及下一个Release?

大部分开发人员现在使用Git就只是用三个甚至两个分支，一个是Master, 一个是Develop, 还有一个是基于Develop打得各种分支。这个在小项目规模的时候还勉强可以支撑，因为很多人做项目就只有一个Release, 但是人员一多，而且项目周期一长就会出现各种问题。

## git-flow 模型

[Vincent Driessen](http://nvie.com/about/) 同学发表了博客 [A successful Git branching model](http://nvie.com/git-model) ，文章讲解了他是如何让自己的[Git](http://www.oschina.net/p/git)仓库保持整洁，除此之外，他发布了git-flow; 一个可以轻松实现该模型的Git扩展。

这个最佳实践已经成为最为流行的 git 分支模型，一些 GUI 工具甚至已经支持建立这种模型。

下面，来介绍一下 git-flow 模型。

<br><div align="center"><img src="http://dunwu.test.upcdn.net/cs/web/git/git-flow.png!zp"/></div><br>

`Gitflow`工作流仍然用中央仓库作为所有开发者的交互中心。和其它的工作流一样，开发者在本地工作并`push`分支到要中央仓库中。

### 核心分支

`Gitflow`工作流使用2个分支来记录项目的历史。

`master` 分支对应线上实际的发布版本。

`develop` 分支作为功能的集成分支。

<br><div align="center"><img src="https://raw.githubusercontent.com/quickhack/translations/master/git-workflows-and-tutorials/images/git-workflow-release-cycle-1historical.png"/></div><br>

### 功能分支

每个新功能位于一个自己的分支，这样可以[`push`到中央仓库以备份和协作](https://www.atlassian.com/git/tutorial/remote-repositories#!push)。但功能分支不是从`master`分支上拉出新分支，而是使用`develop`分支作为父分支。当新功能完成时，[合并回`develop`分支](https://www.atlassian.com/git/tutorial/git-branches#!merge)。新功能提交应该从不直接与`master`分支交互。

<br><div align="center"><img src="https://raw.githubusercontent.com/quickhack/translations/master/git-workflows-and-tutorials/images/git-workflow-release-cycle-2feature.png"/></div><br>

注意，从各种含义和目的上来看，功能分支加上`develop`分支就是功能分支工作流的用法。但`Gitflow`工作流没有在这里止步。

### 发布分支

<br><div align="center"><img src="https://raw.githubusercontent.com/quickhack/translations/master/git-workflows-and-tutorials/images/git-workflow-release-cycle-3release.png"/></div><br>

一旦`develop`分支上有了做一次发布（或者说快到了既定的发布日）的足够功能，就从`develop`分支上`fork`一个发布分支。新建的分支用于开始发布循环，所以从这个时间点开始之后新的功能不能再加到这个分支上 —— 这个分支只应该做`Bug`修复、文档生成和其它面向发布任务。一旦对外发布的工作都完成了，发布分支合并到`master`分支并分配一个版本号打好`Tag`。另外，这些从新建发布分支以来的做的修改要合并回`develop`分支。

使用一个用于发布准备的专门分支，使得一个团队可以在完善当前的发布版本的同时，另一个团队可以继续开发下个版本的功能。
这也打造定义良好的开发阶段（比如，可以很轻松地说，『这周我们要做准备发布版本4.0』，并且在仓库的目录结构中可以实际看到）。

常用的分支约定：

`用于新建发布分支的分支: develop用于合并的分支: master分支命名: release-* 或 release/*`

### 维护分支

<br><div align="center"><img src="https://raw.githubusercontent.com/quickhack/translations/master/git-workflows-and-tutorials/images/git-workflow-release-cycle-4maintenance.png"/></div><br>

维护分支或说是热修复（`hotfix`）分支用于生成快速给产品发布版本（`production releases`）打补丁，这是唯一可以直接从`master`分支`fork`出来的分支。修复完成，修改应该马上合并回`master`分支和`develop`分支（当前的发布分支），`master`分支应该用新的版本号打好`Tag`。

为`Bug`修复使用专门分支，让团队可以处理掉问题而不用打断其它工作或是等待下一个发布循环。你可以把维护分支想成是一个直接在`master`分支上处理的临时发布。

## git-flow 代码示例

a. 创建develop分支

```bash
git branch develop
git push -u origin develop    
```

b. 开始新Feature开发

```bash
git checkout -b some-feature develop
# Optionally, push branch to origin:
git push -u origin some-feature    

# 做一些改动    
git status
git add some-file
git commit    
```

c. 完成Feature

```bash
git pull origin develop
git checkout develop
git merge --no-ff some-feature
git push origin develop

git branch -d some-feature

# If you pushed branch to origin:
git push origin --delete some-feature    
```

d. 开始Relase

```bash
git checkout -b release-0.1.0 develop

# Optional: Bump version number, commit
# Prepare release, commit
```

e. 完成Release

```bash
git checkout master
git merge --no-ff release-0.1.0
git push

git checkout develop
git merge --no-ff release-0.1.0
git push

git branch -d release-0.1.0

# If you pushed branch to origin:
git push origin --delete release-0.1.0   


git tag -a v0.1.0 master
git push --tags
```

f. 开始Hotfix

```bash
git checkout -b hotfix-0.1.1 master    
```

g. 完成Hotfix

```bash
git checkout master
git merge --no-ff hotfix-0.1.1
git push


git checkout develop
git merge --no-ff hotfix-0.1.1
git push

git branch -d hotfix-0.1.1

git tag -a v0.1.1 master
git push --tags
```

## git-flow 工具

实际上，当你理解了上面的流程后，你完全不用使用工具，但是实际上我们大部分人很多命令就是记不住呀，流程就是记不住呀，肿么办呢？

总有聪明的人创造好的工具给大家用, 那就是Git flow script.

### git-flow

#### 安装

你需要有一个可以工作的 git 作为前提。

Git flow 可以工作在 OSX, Linux 和 Windows之下

- OSX Homebrew

```
$ brew install git-flow
```

- OSX Macports

```
$ port install git-flow
```

- Linux

```
$ apt-get install git-flow
```

- Windows (Cygwin):

安装 git-flow, 你需要 wget 和 util-linux。

```
$ wget -q -O - --no-check-certificate https://github.com/nvie/gitflow/raw/develop/contrib/gitflow-installer.sh | bash
```

#### 使用

- **初始化:** git flow init
- **开始新Feature:** git flow feature start MYFEATURE
- **Publish一个Feature(也就是push到远程):** git flow feature publish MYFEATURE
- **获取Publish的Feature:** git flow feature pull origin MYFEATURE
- **完成一个Feature:** git flow feature finish MYFEATURE
- **开始一个Release:** git flow release start RELEASE [BASE]
- **Publish一个Release:** git flow release publish RELEASE
- **发布Release:** git flow release finish RELEASE
  别忘了git push --tags
- **开始一个Hotfix:** git flow hotfix start VERSION [BASENAME]
- **发布一个Hotfix:** git flow hotfix finish VERSION

<br><div align="center"><img src="http://dunwu.test.upcdn.net/cs/web/git/git-flow-commands.png!zp"/></div><br>

### Source Tree

[Source Tree](https://www.sourcetreeapp.com/) 支持Mac, Windows, Linux，是一个不过的 git-flow GUI 工具。

## 资料

[git 官网](https://git-scm.com/) | [git 官方 Github](https://github.com/git/git)

[廖雪峰的 git 教程](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)

[https://github.com/arslanbilal/git-cheat-sheet/blob/master/other-sheets/git-cheat-sheet-zh.md](https://github.com/arslanbilal/git-cheat-sheet/blob/master/other-sheets/git-cheat-sheet-zh.md)
