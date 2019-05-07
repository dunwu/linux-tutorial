---
title: Mac
date: 2019-03-06
---

# Mac

## 基本操作

### 软件管理

dmg 格式：双击安装包，然后拖到 applications 文件夹下即可。

### 浏览器

#### 更改默认搜索引擎

选择「偏好设置--\>搜索--\>搜索引擎--\>Google」。

#### 导入 chrome 浏览器的书签

选择「文件-->导入自--> Google Chrome」，然后选择要导入的项目。

#### 快捷键

Command + R 刷新

#### 上方显示书签栏／收藏栏

选择「显示--> 显示个人收藏栏」。

#### 关闭软件的右上角通知

在 Mac 系统中有对通知的设置，打开系统偏好设置 — 通知 找到 QQ，然后将 QQ 提示样式设置成无即可。

#### 复制文件/文件夹路径

- OS X 10.11 系统，选中文件夹，「cmd +Option +c」 复制文件夹路径，cmd+v 粘贴。
  之前的系统，利用 Administrator 创建一个到右键菜单，然后到设置里面设置快捷键。具体操作请百度。

#### 打开来自身份不明的开发者的应用程序

在应用程序文件夹，按住 control 键的同时打开应用程序。

#### 复制文件路径

- 选择文件／文件夹按 Command+C 复制，在终端中 Command+V 粘贴即可。

- 如果只是想在 Finder 中看到文件的路径, 并方便切换层级, Finder 内置了「显示路径栏」的功能, 并配置了快捷键(Option+Cmd+P). 如下图所示：

20161124-184148.png

参考链接：

- [https://www.zhihu.com/question/22883229]

### 隐藏和取消隐藏 Mac App Store 中的已购项目

### Mac 同时登陆两个 QQ

在已经打开的 QQ 中，按住「command + N」即可。

## 系统便好设置

### 语音播报

打开「系统便好设置-->辅助功能-->语音」，即可设置不同国家的语言。

勾选上图中的红框部分，可以设置全局快捷键。这样的话，在任何一个软件当中，按下「 option+esc」时，就会朗读选中的文本。

### 调整字体大小

Mac 调整字体大小：「系统偏好设置 -> 显示器 -> 缩放」。如下图：

### 如何分别设置 Mac 的鼠标和触控板的滚动方向

很多人习惯鼠标使用相反的滚动方向，而触控板类似 iPad 那样的自然滚动，问如何设置，当时我的回答是不知道，因为目前 OS X 的系统设置里，鼠标和触控板的设置是统一
的。今天发现了一个免费的软件 Scroll Reverser，可以实现鼠标和触控板的分别设置。下载地址：<https://pilotmoon.com/scrollreverser/>
启动后程序显示在顶部菜单栏，设置简单明了，有需要的用户体验一下吧。

### Touch Bar 自定义

打开「系统偏好设置-键盘」，下面有个自定义控制条。

### 色温调节：夜间模式

iOS9.3 的最明显变化，莫过于苹果在发布会上特意提到的 Night Shift 夜间护眼模式。

### iCloud 邮箱

如果您用于设置 iCloud 的 Apple ID 不以“@icloud.com”、“@me.com”或“@mac.com”结尾，您必须先设置一个“@icloud.com”电子邮件地址，然后才能使用 iCloud“邮件”。

如果您拥有以“@mac.com”或“@me.com”结尾的电子邮件地址，则您已经拥有了名称相同但以“@icloud.com”结尾的等效地址。如果您使用的电子邮件别名以“@mac.com”或“@me.com”结尾，您也将拥有以“@icloud.com”结尾的等效地址。

**操作如下：**

- 在 iOS 设备上，前往“设置”>“iCloud”，开启“邮件”，然后按照屏幕上的说明操作。

- 在 Mac 上，选取 Apple 菜单 >“系统偏好设置”，点按“iCloud”，再选择“邮件”，然后按照屏幕上的说明操作。

PS：创建 iCloud 电子邮件地址后，您无法对其进行更改。

设置 @icloud.com 电子邮件地址后即可用其登录 iCloud。您也可以用创建 iCloud 帐户时所用的 Apple ID 登录。

您可以从以下任意地址发送 iCloud 电子邮件：

您的 iCloud 电子邮件地址（您的帐号名称@icloud.com）

别名

参考链接：

**直接注册以@icloud.com 结尾的 Apple ID：**

参考链接：

## PodCast

PodCast 中文翻译为播客，是一种特殊的音频 or 视频节目。PodCast 这个单词是由 iPod+Broadcast 这两个单词组成的。

PodCast 可以在 iTunes 中收听。

## others

### 词典

系统有一个自带应用「词典」，可以进行单词的查询。

### 如何解决 MAC 软件（dmg，akp，app）出现程序已损坏的提示

「xxx.app 已损坏,打不开.你应该将它移到废纸篓」，并非你安装的软件已损坏，而是 Mac 系统的安全设置问题，因为这些应用都是破解或者汉化的,那么解决方法就是临时改变 Mac 系统安全设置。

出现这个问题的解决方法：修改系统配置：系统偏好设置... -> 安全性与隐私。修改为任何来源。

如果没有这个选项的话（macOS Sierra 10.12）,打开终端，执行：

```bash
sudo spctl --master-disable
```

即可。

参考链接：

- [Max OS-[xxx.app 已损坏,打不开.你应该将它移到废纸篓]](http://www.jianshu.com/p/379b49b88df9)

- [如何解决 MAC 软件（dmg，akp，app）出现程序已损坏的提示](http://www.yunrui.co/25693.html)

备注：这个链接里的各种资源都很不错啊。

#### 终端

#### 在 Finder 的当前目录打开终端

在 Finder 打开 terminal 终端这个功能其实是有的，但是系统默认没有打开。我们可以通过如下方法将其打开：

进入系统偏好设置->键盘->快捷键->服务。

在右边新建位于文件夹位置的终端窗口上打勾。

如此设置后，在 Finder 中右击某文件，在出现的菜单中找到服务，然后点击新建位于文件夹位置的终端窗口即可！

## Mac 常用快捷键

### Finder

| 快捷键              | 作用                 | 备注               |
| :------------------ | :------------------- | :----------------- |
| Shift + Command + G | 前往指定路径的文件夹 | 包括隐藏文件夹     |
| Shift + Command + . | 显示隐藏文件、文件夹 | 再按一次，恢复隐藏 |
| Command + ↑         | 返回上一层           |                    |
| Command + ↓         | 进入当前文件夹       |                    |

### 编辑

**删除文字**：

| 快捷键                   | 作用                   | 备注                          |
| :----------------------- | :--------------------- | :---------------------------- |
| delete                   | 删除光标的前一个字符   | 相当于 Windows 键盘上的退格键 |
| fn + delete              | 删除光标的后一个字符   |                               |
| option + delete          | 删除光标之前的一个单词 | 英文有效                      |
| **command + delete**     | 删除光标之前的整行内容 | 【荐】                        |
| command + delete         | 在 finder 中删掉该文件 |                               |
| shift + command + delete | 清空回收站             |                               |

**剪切文件**：

首先选中文件，按 Command+C 复制文件；然后按「Command ＋ Option ＋ V」剪切文件。

备注：Command+X 只能剪切文字文本，不要混淆了。

## Mac 用户必须知道的 15 组快捷键

> 参考链接：[《轻松玩 Mac》第 6 期：Mac 用户必须知道的 15 组快捷键](http://v.youku.com/v_show/id_XNDE4MzM0NDgw.html)

### 「space」键：快速预览

选中文件后， 不需要启动任何应用程序，使用「space」空格键可进行快速预览，再次按下「space」空格键取消预览。

可以预览 mp3、视频、pdf 等文件。

我们还可以**选中多张图片**， 然后按「space」键，就可以同时对比预览多张图片。这一点，很赞。

### 改名

选中文件/文件夹后，按 enter 键，就可以改名了。

### 「command + I」键：查看文件属性

- 选中文件后，按「command + I」键，可以查看文件的各种属性。

- 选中**文件夹**后，按「command + I」键，可以查看文件夹的大小。【荐】

### 切换输入法

「control + space」

### 打开 spotlight 搜索框

spotlight 是系统自带的软件，搜索功能不是很强大。我们一般都会用第三方的 Alfred 软件。

### 编辑相关

Cmd+C、Cmd+V、Cmd+X、Cmd+A、Cmd+Z。

### 翻页和光标

- 「control + ↑」：将光标定位到文章的最开头（翻页到文档的最上方）

- 「control + ↓」：将光标定位到文章的最末尾（翻页到文档的最下方）

- 「control + ←」：将光标定位到当前行的最左侧

- 「control + →」：将光标定位到当前行的最右侧

### 「command + shift + Y」：将文字快速保存到便笺

选中你想要的内容（例如文字、链接等），然后按下 command + shift + Y」，那么你选中的内容就会快速保存到系统自带的「便笺」软件中。

如果你想临时性的保存一段内容，这个操作很实用。

### 程序相关

- 「command + Q」：快速退出程序

- 「command + tab」：切换程序

- 「command + H」：隐藏当前应用程序。这是一个有趣的快捷键。

- 「command + ，」：打开当前应用程序的「偏好设置」。

### 窗口相关

- 「command + N」：新建一个当前应用程序的窗口

- 「command + `」：在当前应用程序的不同窗口之间切换【很实用】

我们知道，「command + tab」是在不同的软件之间切换。但你不知道的是，「command + `」是在同一个软件的不同窗口之间切换。

- 「command + M」：将当前窗口最小化

- 「command + W」：关闭当前窗口

### 浏览器相关

- 「command + T」：浏览器中，新建一个标签

- 「command + W」：关闭当前标签

* 「command + R」：强制刷新。

- 「command + L」：定位到地址栏。【重要】

### 截图相关

- 「command + shift + 3」：截全屏（对整个屏幕截图）。

### 声音相关

选中文字后，按住「ctrl + esc」键，会将文字进行朗读。（我发现，在触控条版的 mac 上，并没有生效）

### Dock 栏相关

- 「option + command + D」：隐藏 dock 栏

### 强制推出

> 强制退出的快捷键非常重要

- 「option + command + esc」：打开强制退出的窗口

### option 相关

> 强烈推荐

- 「option + command + H」：隐藏除当前应用程序之外的其他应用程序

- 在文本中，按住「option」键，配合鼠标的选中，可以进行块状文字选取。

- 「option + command + W」：快速关闭当前应用程序的所有窗口。【很实用】

比如说，你一次性打开了很多文件的详情，然后就可以通过此快捷键，将这些窗口一次性关闭。

- 「option + command + I」：查看多个文件的总的属性。

* 打开 launchpad，按住「option」键，可以快速卸载应用程序。

* 在 dock 栏，右键点击软件图标，同时按住「option」键，就可以**强制退出**该软件。【重要】

- 在 Safari 浏览器中，按住「option + command + Q」退出 Safari。等下次进入 Safari 的时候，上次退出时的网址会自动被打开。【实用】

### 推荐一个软件：CheatSheet

打开 CheatSheet 后，长按 command 键，会弹出当前应用程序的所有快捷键。我们还可以对这些快捷键进行保存。

## :books: 学习资源

- [Awesome Mac](https://github.com/jaywcjlove/awesome-mac)
- [awesome-macos-command-line](https://github.com/herrbischoff/awesome-macos-command-line)

## :door: 传送门

| [回首頁](https://github.com/dunwu/blog) |
