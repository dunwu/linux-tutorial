# Tomcat 安装

<!-- TOC depthFrom:2 depthTo:3 -->

- [安装](#安装)
- [启动](#启动)
- [脚本](#脚本)

<!-- /TOC -->

## 安装

安装步骤如下：

（1）下载并解压到本地

进入官网下载地址：https://tomcat.apache.org/download-80.cgi ，选择合适的版本下载。

我选择的是最新稳定版本 8.5.28：http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.28/bin/apache-tomcat-8.5.28.tar.gz

我个人喜欢存放在：`/opt/tomcat`

```
wget -O /opt/tomcat/apache-tomcat-8.5.28.tar.gz http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.28/bin/apache-tomcat-8.5.28.tar.gz
cd /opt/tomcat
tar zxvf apache-tomcat-8.5.28.tar.gz
```

## 启动

**启动 tomcat 服务**

```
cd /opt/tomcat/apache-tomcat-8.5.28/bin
./catalina.sh start
```

**停止 tomcat 服务**

```
cd /opt/tomcat/apache-tomcat-8.5.28/bin
./catalina.sh stop
```

## 脚本

| [安装脚本](https://github.com/dunwu/linux-tutorial/tree/master/codes/linux/soft) |

## 更多内容

- **引申**
  - [操作系统、运维部署总结系列](https://github.com/dunwu/OS)
