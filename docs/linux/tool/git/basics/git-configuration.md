# Git 配置

## 配置 Git

Git 使用一系列配置文件来保存你自定义的行为。 它首先会查找 `/etc/gitconfig` 文件，该文件含有系统里每位用户及他们所拥有的仓库的配置值。 如果你传递 `--system` 选项给 `git config`，它就会读写该文件。

接下来 Git 会查找每个用户的 `\~/.gitconfig` 文件（或者 `\~/.config/git/config` 文件）。 你可以传递 `--global` 选项让 Git 读写该文件。

最后 Git 会查找你正在操作的版本库所对应的 Git 目录下的配置文件（`.git/config`）。 这个文件中的值只对该版本库有效。

以上三个层次中每层的配置（系统、全局、本地）都会覆盖掉上一层次的配置，所以 `.git/config` 中的值会覆盖掉 `/etc/gitconfig` 中所对应的值。

## 客户端基本配置

### `core.editor`

默认情况下，Git 会调用环境变量（`$VISUAL` 或 `$EDITOR`）设置的任意文本编辑器，如果没有设置，会调用 `vi` 来创建和编辑你的提交以及标签信息。 你可以使用 `core.editor` 选项来修改默认的编辑器：

```
$ git config --global core.editor emacs
```

现在，无论你定义了什么终端编辑器，Git 都会调用 Emacs 编辑信息。

### `commit.template`

如果把此项指定为你的系统上某个文件的路径，当你提交的时候， Git 会使用该文件的内容作为提交的默认信息。 例如：假设你创建了一个叫 `\~/.gitmessage.txt` 的模板文件，类似这样：

```
subject line

what happened

[ticket: X]
```

要想让 Git 把它作为运行 `git commit` 时显示在你的编辑器中的默认信息， 如下设置 `commit.template`：

```
$ git config --global commit.template ~/.gitmessage.txt
$ git commit
```

然后当你提交时，编辑器中就会显示如下的提交信息占位符：

```
subject line

what happened

[ticket: X]
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
# modified:   lib/test.rb
#
~
~
".git/COMMIT_EDITMSG" 14L, 297C
```

如果你的团队对提交信息有格式要求，可以在系统上创建一个文件，并配置 Git 把它作为默认的模板，这样可以更加容易地使提交信息遵循格式。

### `core.pager`

该配置项指定 Git 运行诸如 `log` 和 `diff` 等命令所使用的分页器。 你可以把它设置成用 `more` 或者任何你喜欢的分页器（默认用的是 `less`），当然也可以设置成空字符串，关闭该选项：

```
$ git config --global core.pager ''
```

这样不管命令的输出量多少，Git 都会在一页显示所有内容。

### `user.signingkey`

如果你要创建经签署的含附注的标签（正如 [签署工作](https://git-scm.com/book/zh/v2/ch00/r_signing) 所述），那么把你的 GPG 签署密钥设置为配置项会更好。 如下设置你的密钥 ID：

```
$ git config --global user.signingkey <gpg-key-id>
```

现在，你每次运行 `git tag` 命令时，即可直接签署标签，而无需定义密钥：

```
$ git tag -s <tag-name>
```

### `core.excludesfile`

正如 [忽略文件](https://git-scm.com/book/zh/v2/ch00/r_ignoring) 所述，你可以在你的项目的 `.gitignore` 文件里面规定无需纳入 Git 管理的文件的模板，这样它们既不会出现在未跟踪列表，也不会在你运行 `git add` 后被暂存。

不过有些时候，你想要在你所有的版本库中忽略掉某一类文件。 如果你的操作系统是 OS X，很可能就是指`.DS_Store`。 如果你把 Emacs 或 Vim 作为首选的编辑器，你肯定知道以 `\~` 结尾的临时文件。

这个配置允许你设置类似于全局生效的 `.gitignore` 文件。 如果你按照下面的内容创建一个`\~/.gitignore_global` 文件：

```
*~
.DS_Store
```

……然后运行 `git config --global core.excludesfile \~/.gitignore_global`，Git 将把那些文件永远地拒之门外。

### `help.autocorrect`

假如你打错了一条命令，会显示：

```
$ git chekcout master
git：'chekcout' 不是一个 git 命令。参见 'git --help'。

您指的是这个么？
  checkout
```

Git 会尝试猜测你的意图，但是它不会越俎代庖。 如果你把 `help.autocorrect` 设置成 1，那么只要有一个命令被模糊匹配到了，Git 会自动运行该命令。

```
$ git chekcout master
警告：您运行一个不存在的 Git 命令 'chekcout'。继续执行假定您要要运行的
是 'checkout'
在 0.1 秒钟后自动运行...
```

注意提示信息中的“0.1 秒”。`help.autocorrect` 接受一个代表十分之一秒的整数。 所以如果你把它设置为 50, Git 将在自动执行命令前给你 5 秒的时间改变主意。

## 格式化与多余的空白字符

格式化与多余的空白字符是许多开发人员在协作时，特别是在跨平台情况下，不时会遇到的令人头疼的琐碎的问题。 由于编辑器的不同或者文件行尾的换行符在 Windows 下被替换了，一些细微的空格变化会不经意地混入提交的补丁或其它协作成果中。 不用怕，Git 提供了一些配置项来帮助你解决这些问题。

### `core.autocrlf`

假如你正在 Windows 上写程序，而你的同伴用的是其他系统（或相反），你可能会遇到 CRLF 问题。 这是因为 Windows 使用回车（CR）和换行（LF）两个字符来结束一行，而 Mac 和 Linux 只使用换行（LF）一个字符。 虽然这是小问题，但它会极大地扰乱跨平台协作。许多 Windows 上的编辑器会悄悄把行尾的换行字符转换成回车和换行，或在用户按下 Enter 键时，插入回车和换行两个字符。

Git 可以在你提交时自动地把回车和换行转换成换行，而在检出代码时把换行转换成回车和换行。 你可以用 `core.autocrlf` 来打开此项功能。 如果是在 Windows 系统上，把它设置成 `true`，这样在检出代码时，换行会被转换成回车和换行：

```
$ git config --global core.autocrlf true
```

如果使用以换行作为行结束符的 Linux 或 Mac，你不需要 Git 在检出文件时进行自动的转换；然而当一个以回车加换行作为行结束符的文件不小心被引入时，你肯定想让 Git 修正。 你可以把 `core.autocrlf` 设置成 input 来告诉 Git 在提交时把回车和换行转换成换行，检出时不转换：

```
$ git config --global core.autocrlf input
```

这样在 Windows 上的检出文件中会保留回车和换行，而在 Mac 和 Linux 上，以及版本库中会保留换行。

如果你是 Windows 程序员，且正在开发仅运行在 Windows 上的项目，可以设置 `false` 取消此功能，把回车保留在版本库中：

```
$ git config --global core.autocrlf false
```

### `core.whitespace`

Git 预先设置了一些选项来探测和修正多余空白字符问题。 它提供了六种处理多余空白字符的主要选项 —— 其中三个默认开启，另外三个默认关闭，不过你可以自由地设置它们。

默认被打开的三个选项是：`blank-at-eol`，查找行尾的空格；`blank-at-eof`，盯住文件底部的空行；`space-before-tab`，警惕行头 tab 前面的空格。

默认被关闭的三个选项是：`indent-with-non-tab`，揪出以空格而非 tab 开头的行（你可以用 `tabwidth`选项控制它）；`tab-in-indent`，监视在行头表示缩进的 tab；`cr-at-eol`，告诉 Git 忽略行尾的回车。

通过设置 `core.whitespace`，你可以让 Git 按照你的意图来打开或关闭以逗号分割的选项。 要想关闭某个选项，你可以在输入设置选项时不指定它或在它前面加个 `-`。 例如，如果你想要打开除 `cr-at-eol` 之外的所有选项：

```
$ git config --global core.whitespace \
    trailing-space,space-before-tab,indent-with-non-tab
```

当你运行 `git diff` 命令并尝试给输出着色时，Git 将探测到这些问题，因此你在提交前就能修复它们。 用`git apply` 打补丁时你也会从中受益。 如果正准备应用的补丁存有特定的空白问题，你可以让 Git 在应用补丁时发出警告：

```
$ git apply --whitespace=warn <patch>
```

或者让 Git 在打上补丁前自动修正此问题：

```
$ git apply --whitespace=fix <patch>
```

这些选项也能运用于 `git rebase`。 如果提交了有空白问题的文件，但还没推送到上游，你可以运行 `git rebase --whitespace=fix` 来让 Git 在重写补丁时自动修正它们。

## 服务器端配置

Git 服务器端的配置项相对来说并不多，但仍有一些饶有生趣的选项值得你一看。

### `receive.fsckObjects`

Git 能够确认每个对象的有效性以及 SHA-1 检验和是否保持一致。 但 Git 不会在每次推送时都这么做。这个操作很耗时间，很有可能会拖慢提交的过程，特别是当库或推送的文件很大的情况下。 如果想在每次推送时都要求 Git 检查一致性，设置 `receive.fsckObjects` 为 true 来强迫它这么做：

```
$ git config --system receive.fsckObjects true
```

现在 Git 会在每次推送生效前检查库的完整性，确保没有被有问题的客户端引入破坏性数据。

### `receive.denyNonFastForwards`

如果你变基已经被推送的提交，继而再推送，又或者推送一个提交到远程分支，而这个远程分支当前指向的提交不在该提交的历史中，这样的推送会被拒绝。 这通常是个很好的策略，但有时在变基的过程中，你确信自己需要更新远程分支，可以在 push 命令后加 `-f` 标志来强制更新（force-update）。

要禁用这样的强制更新推送（force-pushes），可以设置 `receive.denyNonFastForwards`：

```
$ git config --system receive.denyNonFastForwards true
```

稍后我们会提到，用服务器端的接收钩子也能达到同样的目的。 那种方法可以做到更细致的控制，例如禁止某一类用户做非快进（non-fast-forwards）推送。

### `receive.denyDeletes`

有一些方法可以绕过 `denyNonFastForwards` 策略。其中一种是先删除某个分支，再连同新的引用一起推送回该分支。 把 `receive.denyDeletes` 设置为 true 可以把这个漏洞补上：

```
$ git config --system receive.denyDeletes true
```

这样会禁止通过推送删除分支和标签 — 没有用户可以这么做。 要删除远程分支，必须从服务器手动删除引用文件。 通过用户访问控制列表（ACL）也能够在用户级的粒度上实现同样的功能，你将在 [使用强制策略的一个例子](https://git-scm.com/book/zh/v2/ch00/r_an_example_git_enforced_policy) 一节学到具体的做法。
