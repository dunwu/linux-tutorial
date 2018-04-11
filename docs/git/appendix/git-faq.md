<!-- TOC -->

- [Git 常见问题](#git-%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98)
    - [帮助](#%E5%B8%AE%E5%8A%A9)
        - [展示帮助信息](#%E5%B1%95%E7%A4%BA%E5%B8%AE%E5%8A%A9%E4%BF%A1%E6%81%AF)
        - [回到远程仓库的状态](#%E5%9B%9E%E5%88%B0%E8%BF%9C%E7%A8%8B%E4%BB%93%E5%BA%93%E7%9A%84%E7%8A%B6%E6%80%81)
        - [重设第一个commit](#%E9%87%8D%E8%AE%BE%E7%AC%AC%E4%B8%80%E4%B8%AAcommit)
        - [展示工作区和暂存区的不同](#%E5%B1%95%E7%A4%BA%E5%B7%A5%E4%BD%9C%E5%8C%BA%E5%92%8C%E6%9A%82%E5%AD%98%E5%8C%BA%E7%9A%84%E4%B8%8D%E5%90%8C)
        - [展示暂存区和最近版本的不同](#%E5%B1%95%E7%A4%BA%E6%9A%82%E5%AD%98%E5%8C%BA%E5%92%8C%E6%9C%80%E8%BF%91%E7%89%88%E6%9C%AC%E7%9A%84%E4%B8%8D%E5%90%8C)
        - [展示暂存区、工作区和最近版本的不同](#%E5%B1%95%E7%A4%BA%E6%9A%82%E5%AD%98%E5%8C%BA%E3%80%81%E5%B7%A5%E4%BD%9C%E5%8C%BA%E5%92%8C%E6%9C%80%E8%BF%91%E7%89%88%E6%9C%AC%E7%9A%84%E4%B8%8D%E5%90%8C)
        - [快速切换分支](#%E5%BF%AB%E9%80%9F%E5%88%87%E6%8D%A2%E5%88%86%E6%94%AF)
        - [删除已经合并到master的分支](#%E5%88%A0%E9%99%A4%E5%B7%B2%E7%BB%8F%E5%90%88%E5%B9%B6%E5%88%B0master%E7%9A%84%E5%88%86%E6%94%AF)
        - [展示本地分支关联远程仓库的情况](#%E5%B1%95%E7%A4%BA%E6%9C%AC%E5%9C%B0%E5%88%86%E6%94%AF%E5%85%B3%E8%81%94%E8%BF%9C%E7%A8%8B%E4%BB%93%E5%BA%93%E7%9A%84%E6%83%85%E5%86%B5)
        - [关联远程分支](#%E5%85%B3%E8%81%94%E8%BF%9C%E7%A8%8B%E5%88%86%E6%94%AF)
        - [列出所有远程分支](#%E5%88%97%E5%87%BA%E6%89%80%E6%9C%89%E8%BF%9C%E7%A8%8B%E5%88%86%E6%94%AF)
        - [列出本地和远程分支](#%E5%88%97%E5%87%BA%E6%9C%AC%E5%9C%B0%E5%92%8C%E8%BF%9C%E7%A8%8B%E5%88%86%E6%94%AF)
        - [创建并切换到本地分支](#%E5%88%9B%E5%BB%BA%E5%B9%B6%E5%88%87%E6%8D%A2%E5%88%B0%E6%9C%AC%E5%9C%B0%E5%88%86%E6%94%AF)
        - [创建并切换到远程分支](#%E5%88%9B%E5%BB%BA%E5%B9%B6%E5%88%87%E6%8D%A2%E5%88%B0%E8%BF%9C%E7%A8%8B%E5%88%86%E6%94%AF)
        - [删除本地分支](#%E5%88%A0%E9%99%A4%E6%9C%AC%E5%9C%B0%E5%88%86%E6%94%AF)
        - [删除远程分支](#%E5%88%A0%E9%99%A4%E8%BF%9C%E7%A8%8B%E5%88%86%E6%94%AF)
        - [重命名本地分支](#%E9%87%8D%E5%91%BD%E5%90%8D%E6%9C%AC%E5%9C%B0%E5%88%86%E6%94%AF)
        - [查看标签](#%E6%9F%A5%E7%9C%8B%E6%A0%87%E7%AD%BE)
        - [本地创建标签](#%E6%9C%AC%E5%9C%B0%E5%88%9B%E5%BB%BA%E6%A0%87%E7%AD%BE)
        - [推送标签到远程仓库](#%E6%8E%A8%E9%80%81%E6%A0%87%E7%AD%BE%E5%88%B0%E8%BF%9C%E7%A8%8B%E4%BB%93%E5%BA%93)
        - [删除本地标签](#%E5%88%A0%E9%99%A4%E6%9C%AC%E5%9C%B0%E6%A0%87%E7%AD%BE)
        - [删除远程标签](#%E5%88%A0%E9%99%A4%E8%BF%9C%E7%A8%8B%E6%A0%87%E7%AD%BE)
        - [切回到某个标签](#%E5%88%87%E5%9B%9E%E5%88%B0%E6%9F%90%E4%B8%AA%E6%A0%87%E7%AD%BE)
        - [放弃工作区的修改](#%E6%94%BE%E5%BC%83%E5%B7%A5%E4%BD%9C%E5%8C%BA%E7%9A%84%E4%BF%AE%E6%94%B9)
        - [恢复删除的文件](#%E6%81%A2%E5%A4%8D%E5%88%A0%E9%99%A4%E7%9A%84%E6%96%87%E4%BB%B6)
        - [回到某一个commit的状态，并重新增添一个commit](#%E5%9B%9E%E5%88%B0%E6%9F%90%E4%B8%80%E4%B8%AAcommit%E7%9A%84%E7%8A%B6%E6%80%81%EF%BC%8C%E5%B9%B6%E9%87%8D%E6%96%B0%E5%A2%9E%E6%B7%BB%E4%B8%80%E4%B8%AAcommit)
        - [回到某个commit的状态，并删除后面的commit](#%E5%9B%9E%E5%88%B0%E6%9F%90%E4%B8%AAcommit%E7%9A%84%E7%8A%B6%E6%80%81%EF%BC%8C%E5%B9%B6%E5%88%A0%E9%99%A4%E5%90%8E%E9%9D%A2%E7%9A%84commit)
        - [修改上一个commit的描述](#%E4%BF%AE%E6%94%B9%E4%B8%8A%E4%B8%80%E4%B8%AAcommit%E7%9A%84%E6%8F%8F%E8%BF%B0)
        - [查看commit历史](#%E6%9F%A5%E7%9C%8Bcommit%E5%8E%86%E5%8F%B2)
        - [查看某段代码是谁写的](#%E6%9F%A5%E7%9C%8B%E6%9F%90%E6%AE%B5%E4%BB%A3%E7%A0%81%E6%98%AF%E8%B0%81%E5%86%99%E7%9A%84)
        - [显示本地执行过git命令](#%E6%98%BE%E7%A4%BA%E6%9C%AC%E5%9C%B0%E6%89%A7%E8%A1%8C%E8%BF%87git%E5%91%BD%E4%BB%A4)
        - [修改作者名](#%E4%BF%AE%E6%94%B9%E4%BD%9C%E8%80%85%E5%90%8D)
        - [修改远程仓库的url](#%E4%BF%AE%E6%94%B9%E8%BF%9C%E7%A8%8B%E4%BB%93%E5%BA%93%E7%9A%84url)
        - [增加远程仓库](#%E5%A2%9E%E5%8A%A0%E8%BF%9C%E7%A8%8B%E4%BB%93%E5%BA%93)
        - [列出所有远程仓库](#%E5%88%97%E5%87%BA%E6%89%80%E6%9C%89%E8%BF%9C%E7%A8%8B%E4%BB%93%E5%BA%93)
        - [查看两个星期内的改动](#%E6%9F%A5%E7%9C%8B%E4%B8%A4%E4%B8%AA%E6%98%9F%E6%9C%9F%E5%86%85%E7%9A%84%E6%94%B9%E5%8A%A8)
        - [把A分支的某一个commit，放到B分支上](#%E6%8A%8Aa%E5%88%86%E6%94%AF%E7%9A%84%E6%9F%90%E4%B8%80%E4%B8%AAcommit%EF%BC%8C%E6%94%BE%E5%88%B0b%E5%88%86%E6%94%AF%E4%B8%8A)
        - [给git命令起别名](#%E7%BB%99git%E5%91%BD%E4%BB%A4%E8%B5%B7%E5%88%AB%E5%90%8D)
        - [存储当前的修改，但不用提交commit](#%E5%AD%98%E5%82%A8%E5%BD%93%E5%89%8D%E7%9A%84%E4%BF%AE%E6%94%B9%EF%BC%8C%E4%BD%86%E4%B8%8D%E7%94%A8%E6%8F%90%E4%BA%A4commit)
        - [保存当前状态，包括untracked的文件](#%E4%BF%9D%E5%AD%98%E5%BD%93%E5%89%8D%E7%8A%B6%E6%80%81%EF%BC%8C%E5%8C%85%E6%8B%ACuntracked%E7%9A%84%E6%96%87%E4%BB%B6)
        - [展示所有stashes](#%E5%B1%95%E7%A4%BA%E6%89%80%E6%9C%89stashes)
        - [回到某个stash的状态](#%E5%9B%9E%E5%88%B0%E6%9F%90%E4%B8%AAstash%E7%9A%84%E7%8A%B6%E6%80%81)
        - [回到最后一个stash的状态，并删除这个stash](#%E5%9B%9E%E5%88%B0%E6%9C%80%E5%90%8E%E4%B8%80%E4%B8%AAstash%E7%9A%84%E7%8A%B6%E6%80%81%EF%BC%8C%E5%B9%B6%E5%88%A0%E9%99%A4%E8%BF%99%E4%B8%AAstash)
        - [删除所有的stash](#%E5%88%A0%E9%99%A4%E6%89%80%E6%9C%89%E7%9A%84stash)
        - [从stash中拿出某个文件的修改](#%E4%BB%8Estash%E4%B8%AD%E6%8B%BF%E5%87%BA%E6%9F%90%E4%B8%AA%E6%96%87%E4%BB%B6%E7%9A%84%E4%BF%AE%E6%94%B9)
        - [展示所有tracked的文件](#%E5%B1%95%E7%A4%BA%E6%89%80%E6%9C%89tracked%E7%9A%84%E6%96%87%E4%BB%B6)
        - [展示所有untracked的文件](#%E5%B1%95%E7%A4%BA%E6%89%80%E6%9C%89untracked%E7%9A%84%E6%96%87%E4%BB%B6)
        - [展示所有忽略的文件](#%E5%B1%95%E7%A4%BA%E6%89%80%E6%9C%89%E5%BF%BD%E7%95%A5%E7%9A%84%E6%96%87%E4%BB%B6)
        - [强制删除untracked的文件](#%E5%BC%BA%E5%88%B6%E5%88%A0%E9%99%A4untracked%E7%9A%84%E6%96%87%E4%BB%B6)
        - [强制删除untracked的目录](#%E5%BC%BA%E5%88%B6%E5%88%A0%E9%99%A4untracked%E7%9A%84%E7%9B%AE%E5%BD%95)
        - [展示简化的commit历史](#%E5%B1%95%E7%A4%BA%E7%AE%80%E5%8C%96%E7%9A%84commit%E5%8E%86%E5%8F%B2)
        - [把某一个分支到导出成一个文件](#%E6%8A%8A%E6%9F%90%E4%B8%80%E4%B8%AA%E5%88%86%E6%94%AF%E5%88%B0%E5%AF%BC%E5%87%BA%E6%88%90%E4%B8%80%E4%B8%AA%E6%96%87%E4%BB%B6)
        - [从包中导入分支](#%E4%BB%8E%E5%8C%85%E4%B8%AD%E5%AF%BC%E5%85%A5%E5%88%86%E6%94%AF)
        - [执行rebase之前自动stash](#%E6%89%A7%E8%A1%8Crebase%E4%B9%8B%E5%89%8D%E8%87%AA%E5%8A%A8stash)
        - [从远程仓库根据ID，拉下某一状态，到本地分支](#%E4%BB%8E%E8%BF%9C%E7%A8%8B%E4%BB%93%E5%BA%93%E6%A0%B9%E6%8D%AEid%EF%BC%8C%E6%8B%89%E4%B8%8B%E6%9F%90%E4%B8%80%E7%8A%B6%E6%80%81%EF%BC%8C%E5%88%B0%E6%9C%AC%E5%9C%B0%E5%88%86%E6%94%AF)
        - [详细展示一行中的修改](#%E8%AF%A6%E7%BB%86%E5%B1%95%E7%A4%BA%E4%B8%80%E8%A1%8C%E4%B8%AD%E7%9A%84%E4%BF%AE%E6%94%B9)
        - [清除gitignore文件中记录的文件](#%E6%B8%85%E9%99%A4gitignore%E6%96%87%E4%BB%B6%E4%B8%AD%E8%AE%B0%E5%BD%95%E7%9A%84%E6%96%87%E4%BB%B6)
        - [展示所有alias和configs](#%E5%B1%95%E7%A4%BA%E6%89%80%E6%9C%89alias%E5%92%8Cconfigs)
        - [展示忽略的文件](#%E5%B1%95%E7%A4%BA%E5%BF%BD%E7%95%A5%E7%9A%84%E6%96%87%E4%BB%B6)
        - [commit历史中显示Branch1有的，但是Branch2没有commit](#commit%E5%8E%86%E5%8F%B2%E4%B8%AD%E6%98%BE%E7%A4%BAbranch1%E6%9C%89%E7%9A%84%EF%BC%8C%E4%BD%86%E6%98%AFbranch2%E6%B2%A1%E6%9C%89commit)
        - [在commit log中显示GPG签名](#%E5%9C%A8commit-log%E4%B8%AD%E6%98%BE%E7%A4%BAgpg%E7%AD%BE%E5%90%8D)
        - [删除全局设置](#%E5%88%A0%E9%99%A4%E5%85%A8%E5%B1%80%E8%AE%BE%E7%BD%AE)
        - [新建并切换到新分支上，同时这个分支没有任何commit](#%E6%96%B0%E5%BB%BA%E5%B9%B6%E5%88%87%E6%8D%A2%E5%88%B0%E6%96%B0%E5%88%86%E6%94%AF%E4%B8%8A%EF%BC%8C%E5%90%8C%E6%97%B6%E8%BF%99%E4%B8%AA%E5%88%86%E6%94%AF%E6%B2%A1%E6%9C%89%E4%BB%BB%E4%BD%95commit)
        - [展示任意分支某一文件的内容](#%E5%B1%95%E7%A4%BA%E4%BB%BB%E6%84%8F%E5%88%86%E6%94%AF%E6%9F%90%E4%B8%80%E6%96%87%E4%BB%B6%E7%9A%84%E5%86%85%E5%AE%B9)
        - [clone下来指定的单一分支](#clone%E4%B8%8B%E6%9D%A5%E6%8C%87%E5%AE%9A%E7%9A%84%E5%8D%95%E4%B8%80%E5%88%86%E6%94%AF)
        - [忽略某个文件的改动](#%E5%BF%BD%E7%95%A5%E6%9F%90%E4%B8%AA%E6%96%87%E4%BB%B6%E7%9A%84%E6%94%B9%E5%8A%A8)
        - [忽略文件的权限变化](#%E5%BF%BD%E7%95%A5%E6%96%87%E4%BB%B6%E7%9A%84%E6%9D%83%E9%99%90%E5%8F%98%E5%8C%96)
        - [以最后提交的顺序列出所有Git分支](#%E4%BB%A5%E6%9C%80%E5%90%8E%E6%8F%90%E4%BA%A4%E7%9A%84%E9%A1%BA%E5%BA%8F%E5%88%97%E5%87%BA%E6%89%80%E6%9C%89git%E5%88%86%E6%94%AF)
        - [在commit log中查找相关内容](#%E5%9C%A8commit-log%E4%B8%AD%E6%9F%A5%E6%89%BE%E7%9B%B8%E5%85%B3%E5%86%85%E5%AE%B9)
        - [把暂存区的指定file放到工作区中](#%E6%8A%8A%E6%9A%82%E5%AD%98%E5%8C%BA%E7%9A%84%E6%8C%87%E5%AE%9Afile%E6%94%BE%E5%88%B0%E5%B7%A5%E4%BD%9C%E5%8C%BA%E4%B8%AD)
        - [强制推送](#%E5%BC%BA%E5%88%B6%E6%8E%A8%E9%80%81)
        - [回退到指定版本号](#%E5%9B%9E%E9%80%80%E5%88%B0%E6%8C%87%E5%AE%9A%E7%89%88%E6%9C%AC%E5%8F%B7)
    - [资料](#%E8%B5%84%E6%96%99)

<!-- /TOC -->

# Git 常见问题

## 帮助

### 展示帮助信息

```sh
git help -g
```

### 回到远程仓库的状态

抛弃本地所有的修改，回到远程仓库的状态。  
```sh
git fetch --all && git reset --hard origin/master
```

### 重设第一个commit

也就是把所有的改动都重新放回工作区，并**清空所有的commit**，这样就可以重新提交第一个commit了
```sh
git update-ref -d HEAD
```

### 展示工作区和暂存区的不同

输出**工作区**和**暂存区**的different(不同)。
```sh
git diff
```

还可以展示本地仓库中任意两个commit之间的文件变动：
```sh
git diff <commit-id> <commit-id>
```

### 展示暂存区和最近版本的不同

输出**暂存区**和本地最近的版本(commit)的different(不同)。
```sh
git diff --cached
```

### 展示暂存区、工作区和最近版本的不同

输出**工作区**、**暂存区** 和本地最近的版本(commit)的different(不同)。
```sh
git diff HEAD
```

### 快速切换分支

```sh
git checkout -
```

### 删除已经合并到master的分支

```sh
git branch --merged master | grep -v '^\*\|  master' | xargs -n 1 git branch -d
```

### 展示本地分支关联远程仓库的情况

```sh
git branch -vv
```

### 关联远程分支

关联之后，`git branch -vv`就可以展示关联的远程分支名了，同时推送到远程仓库直接：`git push`，不需要指定远程仓库了。
```sh
git branch -u origin/mybranch
```

或者在push时加上`-u`参数
```sh
git push origin/mybranch -u
```

### 列出所有远程分支

-r参数相当于：remote
```sh
git branch -r
```

### 列出本地和远程分支

-a参数相当于：all
```sh
git branch -a
```

### 创建并切换到本地分支

```sh
git checkout -b <branch-name>
```

### 创建并切换到远程分支

```sh
git checkout -b <branch-name> origin/<branch-name>
```

### 删除本地分支

```sh
git branch -d <local-branchname>
```

### 删除远程分支

```sh
git push origin --delete <remote-branchname>
```

或者  
```sh
git push origin :<remote-branchname>
```

### 重命名本地分支

```sh
git branch -m <new-branch-name>
```

### 查看标签

```
git tag
```

展示当前分支的最近的tag
```sh
git describe --tags --abbrev=0
```

### 本地创建标签

```sh
git tag <version-number>
```

默认tag是打在最近的一次commit上，如果需要指定commit打tag：
```sh
$ git tag -a <version-number> -m "v1.0 发布(描述)" <commit-id>
```

### 推送标签到远程仓库

首先要保证本地创建好了标签才可以推送标签到远程仓库：
```sh
git push origin <local-version-number>
```

一次性推送所有标签，同步到远程仓库：
```
git push origin --tags
```

### 删除本地标签

```sh
git tag -d <tag-name>
```

### 删除远程标签

删除远程标签需要**先删除本地标签**，再执行下面的命令：
```sh
git push origin :refs/tags/<tag-name>
```

### 切回到某个标签

一般上线之前都会打tag，就是为了防止上线后出现问题，方便快速回退到上一版本。下面的命令是回到某一标签下的状态：
```sh
git checkout -b branch_name tag_name
```

### 放弃工作区的修改

```sh
git checkout <file-name>
```

放弃所有修改：  
```sh
git checkout .
```

### 恢复删除的文件

```sh
git rev-list -n 1 HEAD -- <file_path> #得到 deleting_commit

git checkout <deleting_commit>^ -- <file_path> #回到删除文件 deleting_commit 之前的状态
```

### 回到某一个commit的状态，并重新增添一个commit

```sh
git revert <commit-id>
```

### 回到某个commit的状态，并删除后面的commit

和revert的区别：reset命令会抹去某个commit id之后的所有commit
```sh
git reset <commit-id>  #默认就是-mixed参数。

git reset –mixed HEAD^  #回退至上个版本，它将重置HEAD到另外一个commit,并且重置暂存区以便和HEAD相匹配，但是也到此为止。工作区不会被更改。

git reset –soft HEAD~3  #回退至三个版本之前，只回退了commit的信息，暂存区和工作区与回退之前保持一致。如果还要提交，直接commit即可   

git reset –hard <commit-id>  #彻底回退到指定commit-id的状态，暂存区和工作区也会变为指定commit-id版本的内容
```

### 修改上一个commit的描述

```sh
git commit --amend
```

### 查看commit历史

```sh
git log
```

### 查看某段代码是谁写的

blame的意思为‘责怪’，你懂的。
```sh
git blame <file-name>
```

### 显示本地执行过git命令

就像shell的history一样
```
git reflog
```

### 修改作者名

```sh
git commit --amend --author='Author Name <email@address.com>'
```

### 修改远程仓库的url

```sh
git remote set-url origin <URL>
```

### 增加远程仓库

```sh
git remote add origin <remote-url>
```

### 列出所有远程仓库

```sh
git remote
```

### 查看两个星期内的改动

```sh
git whatchanged --since='2 weeks ago'
```

### 把A分支的某一个commit，放到B分支上

这个过程需要`cherry-pick`命令，[参考](http://sg552.iteye.com/blog/1300713#bc2367928)
```sh
git checkout <branch-name> && git cherry-pick <commit-id>
```

### 给git命令起别名

简化命令

```sh
git config --global alias.<handle> <command>

比如：git status 改成 git st，这样可以简化命令

git config --global alias.st status
```

### 存储当前的修改，但不用提交commit

详解可以参考[廖雪峰老师的git教程](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/00137602359178794d966923e5c4134bc8bf98dfb03aea3000)
```sh
git stash
```

### 保存当前状态，包括untracked的文件

untracked文件：新建的文件
```sh
git stash -u
```

### 展示所有stashes

```sh
git stash list
```

### 回到某个stash的状态

```sh
git stash apply <stash@{n}>
```

### 回到最后一个stash的状态，并删除这个stash

```sh
git stash pop
```

### 删除所有的stash

```sh
git stash clear
```

### 从stash中拿出某个文件的修改

```sh
git checkout <stash@{n}> -- <file-path>
```

### 展示所有tracked的文件

```sh
git ls-files -t
```

### 展示所有untracked的文件

```sh
git ls-files --others
```

### 展示所有忽略的文件

```sh
git ls-files --others -i --exclude-standard
```

### 强制删除untracked的文件

可以用来删除新建的文件。如果不指定文件文件名，则清空所有工作的untracked文件。`clean`命令，**注意两点**：  
1. clean后，删除的文件无法找回
2. 不会影响tracked的文件的改动，只会删除untracked的文件

```sh
git clean <file-name> -f
```

### 强制删除untracked的目录

可以用来删除新建的目录，**注意**:这个命令也可以用来删除untracked的文件。详情见上一条

```sh
git clean <directory-name> -df
```

### 展示简化的commit历史

```sh
git log --pretty=oneline --graph --decorate --all
```

### 把某一个分支到导出成一个文件

```sh
git bundle create <file> <branch-name>
```

### 从包中导入分支

新建一个分支，分支内容就是上面`git bundle create`命令导出的内容
```sh
git clone repo.bundle <repo-dir> -b <branch-name>
```

### 执行rebase之前自动stash

```sh
git rebase --autostash
```

### 从远程仓库根据ID，拉下某一状态，到本地分支

```sh
git fetch origin pull/<id>/head:<branch-name>
```

### 详细展示一行中的修改

```sh
git diff --word-diff
```

### 清除gitignore文件中记录的文件

```sh
git clean -X -f
```

### 展示所有alias和configs

**注意：** config分为：当前目录（local）和全局（golbal）的config，默认为当前目录的config

```sh
git config --local --list (当前目录)
git config --global --list (全局)
```

### 展示忽略的文件

```sh
git status --ignored
```

### commit历史中显示Branch1有的，但是Branch2没有commit

```sh
git log Branch1 ^Branch2
```

### 在commit log中显示GPG签名

```sh
git log --show-signature
```

### 删除全局设置

```sh
git config --global --unset <entry-name>
```

### 新建并切换到新分支上，同时这个分支没有任何commit

相当于保存修改，但是重写commit历史
```sh
git checkout --orphan <branch-name>
```

### 展示任意分支某一文件的内容

```sh
git show <branch-name>:<file-name>
```

### clone下来指定的单一分支

```sh
git clone -b <branch-name> --single-branch https://github.com/user/repo.git
```

### 忽略某个文件的改动

关闭 track 指定文件的改动，也就是 Git 将不会在记录这个文件的改动
```
git update-index --assume-unchanged path/to/file
```

恢复 track 指定文件的改动
```
git update-index --no-assume-unchanged path/to/file
```

### 忽略文件的权限变化

不再将文件的权限变化视作改动
```sh
git config core.fileMode false
```

### 以最后提交的顺序列出所有Git分支

最新的放在最上面   

```sh
git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads/
```

### 在commit log中查找相关内容

通过grep查找，given-text：所需要查找的字段

```sh
git log --all --grep='<given-text>'
```

### 把暂存区的指定file放到工作区中

不添加参数，默认是-mixed
```sh
git reset <file-name>
```

### 强制推送

```sh
git push -f <remote-name> <branch-name>
```

### 回退到指定版本号

先找到想要回退版本的上一个版本 HASH，然后执行以下命令：

```
git reset --soft 747abfa5689d9a14da1ed7a14a762fcf6368ef13
git push -f

```

## 资料

https://github.com/521xueweihan/git-tips
