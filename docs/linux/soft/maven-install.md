# Maven 安装

> 环境要求：
>
> - JDK

<!-- TOC depthFrom:2 depthTo:3 -->

- [安装方法](#安装方法)
- [脚本](#脚本)

<!-- /TOC -->

## 安装方法

安装步骤如下：

（1）下载

进入官网下载地址：https://maven.apache.org/download.cgi ，选择合适的版本下载。

我选择的是最新 Maven3 版本：http://mirrors.hust.edu.cn/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz

（2）解压到本地

我个人喜欢存放在：`/opt/maven`

（3）设置环境变量

输入 `vi /etc/profile` ，添加环境变量如下：

```
# MAVEN 的根路径
export MAVEN_HOME=/opt/maven/apache-maven-3.5.2
export PATH=\$MAVEN_HOME/bin:\$PATH
```

执行 `source /etc/profile` ，立即生效

（4）检验是否安装成功，执行 `mvn -v` 命令

## 脚本

以上两种安装方式，我都写了脚本去执行：

| [安装脚本](https://github.com/dunwu/linux-tutorial/tree/master/codes/linux/soft) |
