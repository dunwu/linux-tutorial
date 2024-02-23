<p align="center">
    <a href="https://dunwu.github.io/linux-tutorial/" target="_blank" rel="noopener noreferrer">
        <img src="https://raw.githubusercontent.com/dunwu/images/master/common/logo/linux.svg" alt="logo" width="100px">
    </a>
</p>

<p align="center">
    <img src="https://badgen.net/github/license/dunwu/linux-tutorial" alt="license">
    <img src="https://travis-ci.com/dunwu/linux-tutorial.svg?branch=master" alt="build">
</p>

<h1 align="center">linux-tutorial</h1>

> 📚 **linux-tutorial** 是一个 Linux 教程。
>
> - 🔁 项目同步维护：[Github](https://github.com/dunwu/linux-tutorial/) | [Gitee](https://gitee.com/turnon/linux-tutorial/)
> - 📖 电子书阅读：[Github Pages](https://dunwu.github.io/linux-tutorial/) | [Gitee Pages](http://turnon.gitee.io/linux-tutorial/)

## 📖 内容

### Linux 命令

> 学习 Linux 的第一步：当然是从 [Linux 命令](docs/linux/cli/README.md) 入手了。

- [查看 Linux 命令帮助信息](docs/linux/cli/linux-cli-help.md) - 关键词：`help`, `whatis`, `info`, `which`, `whereis`, `man`
- [Linux 文件目录管理](docs/linux/cli/linux-cli-dir.md) - 关键词：`cd`, `ls`, `pwd`, `mkdir`, `rmdir`, `tree`, `touch`, `ln`, `rename`, `stat`, `file`, `chmod`, `chown`, `locate`, `find`, `cp`, `mv`, `rm`
- [Linux 文件内容查看命令](docs/linux/cli/linux-cli-file.md) - 关键词：`cat`, `head`, `tail`, `more`, `less`, `sed`, `vi`, `grep`
- [Linux 文件压缩和解压](docs/linux/cli/linux-cli-file-compress.md) - 关键词：`tar`, `gzip`, `zip`, `unzip`
- [Linux 用户管理](docs/linux/cli/linux-cli-user.md) - 关键词：`groupadd`, `groupdel`, `groupmod`, `useradd`, `userdel`, `usermod`, `passwd`, `su`, `sudo`
- [Linux 系统管理](docs/linux/cli/linux-cli-system.md) - 关键词：`reboot`, `exit`, `shutdown`, `date`, `mount`, `umount`, `ps`, `kill`, `systemctl`, `service`, `crontab`
- [Linux 网络管理](docs/linux/cli/linux-cli-net.md) - 关键词：关键词：`curl`, `wget`, `telnet`, `ip`, `hostname`, `ifconfig`, `route`, `ssh`, `ssh-keygen`, `firewalld`, `iptables`, `host`, `nslookup`, `nc`/`netcat`, `ping`, `traceroute`, `netstat`
- [Linux 硬件管理](docs/linux/cli/linux-cli-hardware.md) - 关键词：`df`, `du`, `top`, `free`, `iotop`
- [Linux 软件管理](docs/linux/cli/linux-cli-software.md) - 关键词：`rpm`, `yum`, `apt-get`

### Linux 运维

> Linux 系统的常见运维工作。

- [网络运维](docs/linux/ops/network-ops.md)
- [Samba](docs/linux/ops/samba.md)
- [NTP](docs/linux/ops/ntp.md)
- [Firewalld](docs/linux/ops/firewalld.md)
- [Crontab](docs/linux/ops/crontab.md)
- [Systemd](docs/linux/ops/systemd.md)
- [Vim](docs/linux/ops/vim.md)
- [Iptables](docs/linux/ops/iptables.md)
- [oh-my-zsh](docs/linux/ops/zsh.md)

### 软件运维

> 部署在 Linux 系统上的软件运维。
>
> 配套安装脚本：⌨ [软件运维配置脚本集合](https://github.com/dunwu/linux-tutorial/tree/master/codes/linux/soft)

- 开发环境
  - [JDK 安装](docs/linux/soft/jdk-install.md)
  - [Maven 安装](docs/linux/soft/maven-install.md)
  - [Nodejs 安装](docs/linux/soft/nodejs-install.md)
- 开发工具
  - [Nexus 运维](docs/linux/soft/nexus-ops.md)
  - [Gitlab 运维](docs/linux/soft/gitlab-ops.md)
  - [Jenkins 运维](docs/linux/soft/jenkins-ops.md)
  - [Svn 运维](docs/linux/soft/svn-ops.md)
  - [YApi 运维](docs/linux/soft/yapi-ops.md)
- 中间件服务
  - [Elastic 运维](docs/linux/soft/elastic)
  - [Kafka 运维](docs/linux/soft/kafka-install.md)
  - [RocketMQ 运维](docs/linux/soft/rocketmq-install.md)
  - [Zookeeper 运维](https://github.com/dunwu/javatech/blob/master/docs/technology/monitor/zookeeper-ops.md)
  - [Nacos 运维](docs/linux/soft/nacos-install.md)
- 服务器
  - [Nginx 教程](https://github.com/dunwu/nginx-tutorial) 📚
  - [Tomcat 运维](docs/linux/soft/tomcat-install.md)
- [数据库](https://github.com/dunwu/db-tutorial) 📚
  - [MySQL 运维](https://github.com/dunwu/db-tutorial/blob/master/docs/12.%E6%95%B0%E6%8D%AE%E5%BA%93/03.%E5%85%B3%E7%B3%BB%E5%9E%8B%E6%95%B0%E6%8D%AE%E5%BA%93/02.Mysql/20.Mysql%E8%BF%90%E7%BB%B4.md)
  - [Redis 运维](https://github.com/dunwu/db-tutorial/blob/master/docs/12.%E6%95%B0%E6%8D%AE%E5%BA%93/05.KV%E6%95%B0%E6%8D%AE%E5%BA%93/01.Redis/20.Redis%E8%BF%90%E7%BB%B4.md)

### Docker

- [Docker 快速入门](docs/docker/docker-quickstart.md)
- [Dockerfile 最佳实践](docs/docker/docker-dockerfile.md)
- [Docker Cheat Sheet](docs/docker/docker-cheat-sheet.md)
- [Kubernetes 应用指南](docs/docker/kubernetes.md)

### 其他

- [一篇文章让你彻底掌握 Python](https://dunwu.github.io/blog/pages/ef501b/)
- [一篇文章让你彻底掌握 Shell](https://dunwu.github.io/blog/pages/ea6ae1/)
- [如何优雅的玩转 Git](https://dunwu.github.io/blog/pages/2fc8b1/)

## ⌨ 脚本

### Shell 脚本大全

**Shell 脚本大全** 精心收集、整理了 Linux 环境下的常见 Shell 脚本操作片段。

源码：[**Shell 脚本大全**](https://github.com/dunwu/linux-tutorial/tree/master/codes/shell)

### CentOS 运维脚本集合

本人作为一名 Java 后端，苦于经常在 CentOS 环境上开荒虚拟机。为提高效率，写了一套 Shell 脚本，提供如下功能：安装常用 lib 库、命令工具、设置 DNS、NTP、配置国内 yum 源、一键安装常用软件等。

源码：[**CentOS 常规操作运维脚本集合**](https://github.com/dunwu/linux-tutorial/tree/master/codes/linux)

## 📚 资料

- **Linux 命令**
  - [命令行的艺术](https://github.com/jlevy/the-art-of-command-line/blob/master/README-zh.md)
  - [Linux 命令大全](https://man.linuxde.net/)
  - [linux-command](https://github.com/jaywcjlove/linux-command)
- **社区网站**
  - [Linux 中国](https://linux.cn/) - 各种资讯、文章、技术
  - [实验楼](https://www.shiyanlou.com/) - 免费提供了 Linux 在线环境，不用在自己机子上装系统也可以学习 Linux，超方便实用。
  - [鸟哥的 linux 私房菜](http://linux.vbird.org/) - 非常适合 Linux 入门初学者看的教程。
  - [Linux 公社](http://www.linuxidc.com/) - Linux 相关的新闻、教程、主题、壁纸都有。
  - [Linux Today](http://www.linuxde.net) - Linux 新闻资讯发布，Linux 职业技术学习！。
- **知识相关**
  - [Linux 思维导图整理](http://www.jianshu.com/p/59f759207862)
  - [Linux 初学者进阶学习资源整理](http://www.jianshu.com/p/fe2a790b41eb)
  - [Linux 基础入门（新版）](https://www.shiyanlou.com/courses/1)
  - [【译】Linux 概念架构的理解](http://www.jianshu.com/p/c5ae8f061cfe) [En](http://oss.org.cn/ossdocs/linux/kernel/a1/index.html)
  - [Linux 守护进程的启动方法](http://www.ruanyifeng.com/blog/2016/02/linux-daemon.html)
  - [Linux 编程之内存映射](https://www.shiyanlou.com/questions/2992)
  - [Linux 知识点小结](https://blog.huachao.me/2016/1/Linux%E7%9F%A5%E8%AF%86%E7%82%B9%E5%B0%8F%E7%BB%93/)
  - [10 大白帽黑客专用的 Linux 操作系统](https://linux.cn/article-6971-1.html)
- **软件工具**
  - [超赞的 Linux 软件](https://www.gitbook.com/book/alim0x/awesome-linux-software-zh_cn/details) Github 仓库[Zh](https://github.com/alim0x/Awesome-Linux-Software-zh_CN) [En](https://github.com/VoLuong/Awesome-Linux-Software)
  - [程序员喜欢的 9 款最佳的 Linux 文件比较工具](http://os.51cto.com/art/201607/513796.htm)
  - [提高 Linux 开发效率的 5 个工具](http://www.codeceo.com/article/5-linux-productivity-tools.html)
  - [你要了解的 11 款面向 Linux 系统的一流备份实用工具](http://os.51cto.com/art/201603/508027.htm)
  - [16 个很有用的在线工具](http://www.simlinux.com/archives/264.html)
  - Adobe 软件的最佳替代品 [原文在这里](https://linux.cn/article-8928-1.html)
    - [Evince (Adobe Acrobat Reader)](https://wiki.gnome.org/Apps/Evince) 一个“支持多种文档格式的文档查看器”，可以查看 PDF，还支持各种漫画书格式
    - [Pixlr (Adobe Photoshop)](https://pixlr.com/) 一个强大的图像编辑工具
    - [Inkscape (Adobe Illustrator)](https://inkscape.org/zh/) 一个专业的矢量图形编辑器
    - [Pinegrow Web Editor (Adobe Dreamweaver)](https://pinegrow.com/) 一个可视化编辑制作 HTML 网站
    - [Scribus (Adobe InDesign)](https://www.scribus.net/) 一个开源电子杂志制作软件
    - [Webflow (Adobe Muse)](https://webflow.com/) 一款可以帮助用户不用编码就可以快速创建网站的谷歌浏览器插件。
    - [Tupi (Adobe Animate)](http://www.maefloresta.com/portal/) 一款可以创建 HTML5 动画的工具。
    - [Black Magic Fusion (Adobe After Effects)](https://www.blackmagicdesign.com) 一款先进的合成软件，广泛应用于视觉特效、广电影视设计以及 3D 动画设计等领域。
- **中国开源镜像**
  - [阿里云开源镜像站](http://mirrors.aliyun.com/)
  - [网易开源镜像站](http://mirrors.163.com/)
  - [搜狐开源镜像站](http://mirrors.sohu.com/)
  - [北京交通大学](http://mirror.bjtu.edu.cn/)
  - [兰州大学](http://mirror.lzu.edu.cn/)
  - [厦门大学](http://mirrors.xmu.edu.cn/)
  - [上海交通大学](http://ftp.sjtu.edu.cn/)
  - [清华大学](http://mirrors.tuna.tsinghua.edu.cn/)
  - [中国科学技术大学](http://mirrors.ustc.edu.cn/)
  - [东北大学](http://mirror.neu.edu.cn/)
  - [浙江大学](http://mirrors.zju.edu.cn/)
  - [东软信息学院](http://mirrors.neusoft.edu.cn/)
  - [校园网联合镜像站](https://mirrors.cernet.edu.cn)

## 🚪 传送门

◾ 💧 [钝悟的 IT 知识图谱](https://dunwu.github.io/waterdrop/) ◾ 🎯 [钝悟的博客](https://dunwu.github.io/blog/) ◾
