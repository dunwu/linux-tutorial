# Kafka 安装部署

> 环境要求：
>
> - JDK8
> - ZooKeeper

<!-- TOC depthFrom:2 depthTo:3 -->

- [下载解压](#下载解压)
- [启动服务器](#启动服务器)
- [停止服务器](#停止服务器)
- [创建主题](#创建主题)
- [生产者生产消息](#生产者生产消息)
- [消费者消费消息](#消费者消费消息)
- [集群部署](#集群部署)

<!-- /TOC -->

## 下载解压

进入官方下载地址：http://kafka.apache.org/downloads，选择合适版本。

解压到本地：

```
> tar -xzf kafka_2.11-1.1.0.tgz
> cd kafka_2.11-1.1.0
```

现在您已经在您的机器上下载了最新版本的 Kafka。

## 启动服务器

由于 Kafka 依赖于 ZooKeeper，所以运行前需要先启动 ZooKeeper

```
> bin/zookeeper-server-start.sh config/zookeeper.properties
[2013-04-22 15:01:37,495] INFO Reading configuration from: config/zookeeper.properties (org.apache.zookeeper.server.quorum.QuorumPeerConfig)
...
```

然后，启动 Kafka

```
> bin/kafka-server-start.sh config/server.properties
[2013-04-22 15:01:47,028] INFO Verifying properties (kafka.utils.VerifiableProperties)
[2013-04-22 15:01:47,051] INFO Property socket.send.buffer.bytes is overridden to 1048576 (kafka.utils.VerifiableProperties)
...
```

## 停止服务器

执行所有操作后，可以使用以下命令停止服务器

```
$ bin/kafka-server-stop.sh config/server.properties
```

## 创建主题

创建一个名为 test 的 Topic，这个 Topic 只有一个分区以及一个备份：

```
> bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
```

## 生产者生产消息

运行生产者，然后可以在控制台中输入一些消息，这些消息会发送到服务器：

```
> bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
This is a message
This is another message
```

## 消费者消费消息

启动消费者，然后获得服务器中 Topic 下的消息：

```
> bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning
This is a message
This is another message
```

## 集群部署

复制配置为多份（Windows 使用 copy 命令代理）：

```
> cp config/server.properties config/server-1.properties
> cp config/server.properties config/server-2.properties
```

修改配置：

```
config/server-1.properties:
    broker.id=1
    listeners=PLAINTEXT://:9093
    log.dir=/tmp/kafka-logs-1

config/server-2.properties:
    broker.id=2
    listeners=PLAINTEXT://:9094
    log.dir=/tmp/kafka-logs-2
```

其中，broker.id 这个参数必须是唯一的。

端口故意配置的不一致，是为了可以在一台机器启动多个应用节点。

根据这两份配置启动三个服务器节点：

```
> bin/kafka-server-start.sh config/server.properties &
...
> bin/kafka-server-start.sh config/server-1.properties &
...
> bin/kafka-server-start.sh config/server-2.properties &
...
```

创建一个新的 Topic 使用 三个备份：

```
> bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic my-replicated-topic
```

查看主题：

```
> bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic my-replicated-topic
Topic:my-replicated-topic   PartitionCount:1    ReplicationFactor:3 Configs:
    Topic: my-replicated-topic  Partition: 0    Leader: 1   Replicas: 1,2,0 Isr: 1,2,0
```

- leader - 负责指定分区的所有读取和写入的节点。每个节点将成为随机选择的分区部分的领导者。
- replicas - 是复制此分区日志的节点列表，无论它们是否为领导者，或者即使它们当前处于活动状态。
- isr - 是“同步”复制品的集合。这是副本列表的子集，该列表当前处于活跃状态并且已经被领导者捕获。

## 更多内容

- **引申**
  - [操作系统、运维部署总结系列](https://github.com/dunwu/OS)
