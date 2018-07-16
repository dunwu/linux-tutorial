# RocketMQ 安装部署

<!-- TOC depthFrom:2 depthTo:3 -->

- [环境要求](#环境要求)
- [下载解压](#下载解压)
- [启动 Name Server](#启动-name-server)
- [启动 Broker](#启动-broker)
- [收发消息](#收发消息)
- [关闭服务器](#关闭服务器)

<!-- /TOC -->

## 环境要求

- 推荐 64 位操作系统：Linux/Unix/Mac
- 64bit JDK 1.8+
- Maven 3.2.x
- Git

## 下载解压

进入官方下载地址：https://rocketmq.apache.org/dowloading/releases/，选择合适版本

建议选择 binary 版本。

解压到本地：

```sh
> unzip rocketmq-all-4.2.0-source-release.zip
> cd rocketmq-all-4.2.0/
```

## 启动 Name Server

```sh
> nohup sh bin/mqnamesrv &
> tail -f ~/logs/rocketmqlogs/namesrv.log
The Name Server boot success...
```

## 启动 Broker

```sh
> nohup sh bin/mqbroker -n localhost:9876 &
> tail -f ~/logs/rocketmqlogs/broker.log 
The broker[%s, 172.30.30.233:10911] boot success...
```

## 收发消息

执行收发消息操作之前，不许告诉客户端命名服务器的位置。在 RocketMQ 中有多种方法来实现这个目的。这里，我们使用最简单的方法——设置环境变量 `NAMESRV_ADDR` ：

```sh
> export NAMESRV_ADDR=localhost:9876
> sh bin/tools.sh org.apache.rocketmq.example.quickstart.Producer
SendResult [sendStatus=SEND_OK, msgId= ...

> sh bin/tools.sh org.apache.rocketmq.example.quickstart.Consumer
ConsumeMessageThread_%d Receive New Messages: [MessageExt...
```

## 关闭服务器

```sh
> sh bin/mqshutdown broker
The mqbroker(36695) is running...
Send shutdown request to mqbroker(36695) OK

> sh bin/mqshutdown namesrv
The mqnamesrv(36664) is running...
Send shutdown request to mqnamesrv(36664) OK
```
