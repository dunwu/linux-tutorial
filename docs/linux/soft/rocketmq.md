# RocketMQ 安装部署

<!-- TOC depthFrom:2 depthTo:3 -->

- [环境要求](#环境要求)
- [下载解压](#下载解压)
- [启动 Name Server](#启动-name-server)
- [启动 Broker](#启动-broker)
- [收发消息](#收发消息)
- [关闭服务器](#关闭服务器)
- [FAQ](#faq)
    - [connect to <172.17.0.1:10909> failed](#connect-to-172170110909-failed)
- [参考资料](#参考资料)

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

```bash
> unzip rocketmq-all-4.2.0-source-release.zip
> cd rocketmq-all-4.2.0/
```

## 启动 Name Server

```bash
> nohup sh bin/mqnamesrv &
> tail -f ~/logs/rocketmqlogs/namesrv.log
The Name Server boot success...
```

## 启动 Broker

```bash
> nohup sh bin/mqbroker -n localhost:9876 -c conf/broker.conf &
> tail -f ~/logs/rocketmqlogs/broker.log
The broker[%s, 172.30.30.233:10911] boot success...
```

## 收发消息

执行收发消息操作之前，不许告诉客户端命名服务器的位置。在 RocketMQ 中有多种方法来实现这个目的。这里，我们使用最简单的方法——设置环境变量 `NAMESRV_ADDR` ：

```bash
> export NAMESRV_ADDR=localhost:9876
> sh bin/tools.sh org.apache.rocketmq.example.quickstart.Producer
SendResult [sendStatus=SEND_OK, msgId= ...

> sh bin/tools.sh org.apache.rocketmq.example.quickstart.Consumer
ConsumeMessageThread_%d Receive New Messages: [MessageExt...
```

## 关闭服务器

```bash
> sh bin/mqshutdown broker
The mqbroker(36695) is running...
Send shutdown request to mqbroker(36695) OK

> sh bin/mqshutdown namesrv
The mqnamesrv(36664) is running...
Send shutdown request to mqnamesrv(36664) OK
```

## FAQ

### connect to <172.17.0.1:10909> failed

启动后，生产者客户端连接 RocketMQ 时报错：

```java
org.apache.rocketmq.remoting.exception.RemotingConnectException: connect to <172.17.0.1:10909> failed
    at org.apache.rocketmq.remoting.netty.NettyRemotingClient.invokeSync(NettyRemotingClient.java:357)
    at org.apache.rocketmq.client.impl.MQClientAPIImpl.sendMessageSync(MQClientAPIImpl.java:343)
    at org.apache.rocketmq.client.impl.MQClientAPIImpl.sendMessage(MQClientAPIImpl.java:327)
    at org.apache.rocketmq.client.impl.MQClientAPIImpl.sendMessage(MQClientAPIImpl.java:290)
    at org.apache.rocketmq.client.impl.producer.DefaultMQProducerImpl.sendKernelImpl(DefaultMQProducerImpl.java:688)
    at org.apache.rocketmq.client.impl.producer.DefaultMQProducerImpl.sendSelectImpl(DefaultMQProducerImpl.java:901)
    at org.apache.rocketmq.client.impl.producer.DefaultMQProducerImpl.send(DefaultMQProducerImpl.java:878)
    at org.apache.rocketmq.client.impl.producer.DefaultMQProducerImpl.send(DefaultMQProducerImpl.java:873)
    at org.apache.rocketmq.client.producer.DefaultMQProducer.send(DefaultMQProducer.java:369)
    at com.emrubik.uc.mdm.sync.utils.MdmInit.sendMessage(MdmInit.java:62)
    at com.emrubik.uc.mdm.sync.utils.MdmInit.main(MdmInit.java:2149)
```

原因：RocketMQ 部署在虚拟机上，内网 ip 为 10.10.30.63，该虚拟机一个 docker0 网卡，ip 为 172.17.0.1。RocketMQ broker 启动时默认使用了 docker0 网卡，生产者客户端无法连接 172.17.0.1，造成以上问题。

解决方案

（1）干掉 docker0 网卡或修改网卡名称

（2）停掉 broker，修改 broker 配置文件，重启 broker。

修改 conf/broker.conf，增加两行来指定启动 broker 的 IP：

```
namesrvAddr = 10.10.30.63:9876
brokerIP1 = 10.10.30.63
```

启动时需要指定配置文件

```bash
nohup sh bin/mqbroker -n localhost:9876 -c conf/broker.conf &
```

## 更多内容

- **引申**
  - [操作系统、运维部署总结系列](https://github.com/dunwu/OS)
- **引用**
  - [RocketMQ 官方文档](http://rocketmq.apache.org/docs/quick-start/)
  - [RocketMQ 搭建及刨坑](http://laciagin.me/2017/12/07/RocketMQ%E6%90%AD%E5%BB%BA%E5%8F%8A%E5%88%A8%E5%9D%91/)
