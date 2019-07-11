# Mongodb 安装

<!-- TOC depthFrom:2 depthTo:3 -->

- [安装](#安装)
- [启动](#启动)
- [脚本](#脚本)

<!-- /TOC -->

## 安装

安装步骤如下：

（1）下载并解压到本地

进入官网下载地址：https://www.mongodb.com/download-center#community ，选择合适的版本下载。

我选择的是最新稳定版本 3.6.3：https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.6.3.tgz

我个人喜欢存放在：`/opt/mongodb`

```
wget -O /opt/mongodb/mongodb-linux-x86_64-3.6.3.tgz https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.6.3.tgz
cd /opt/mongodb
tar zxvf mongodb-linux-x86_64-3.6.3.tgz
mv mongodb-linux-x86_64-3.6.3 mongodb-3.6.3
mkdir -p /data/db
```

## 启动

**启动 mongodb 服务**

```
cd /opt/mongodb/mongodb-3.6.3/bin
./mongod --dbpath=/data/db
```

**启动 mongodb 客户端**

```
cd /opt/mongodb/mongodb-3.6.3/bin
./mongo
```

## 脚本

| [安装脚本](https://github.com/dunwu/linux-tutorial/tree/master/codes/linux/soft) |
