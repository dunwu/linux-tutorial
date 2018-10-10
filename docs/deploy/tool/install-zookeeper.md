# ZooKeeper 安装部署

> 环境要求：JDK6+

<!-- TOC depthFrom:2 depthTo:3 -->

- [下载解压 ZooKeeper](#下载解压-zookeeper)
- [创建配置文件](#创建配置文件)
- [启动 ZooKeeper 服务器](#启动-zookeeper-服务器)
- [启动 CLI](#启动-cli)
- [停止 ZooKeeper 服务器](#停止-zookeeper-服务器)

<!-- /TOC -->

在安装 ZooKeeper 之前，请确保你的系统是在以下任一操作系统上运行：

- **任意 Linux OS** - 支持开发和部署。适合演示应用程序。
- **Windows OS** - 仅支持开发。
- **Mac OS** - 仅支持开发。

安装步骤如下：

## 下载解压 ZooKeeper

进入官方下载地址：http://zookeeper.apache.org/releases.html#download ，选择合适版本。

解压到本地：

```
$ tar -zxf zookeeper-3.4.6.tar.gz
$ cd zookeeper-3.4.6
```

## 创建配置文件

你必须创建 `conf/zoo.cfg` 文件，否则启动时会提示你没有此文件。

初次尝试，不妨直接使用 Kafka 提供的模板配置文件 `conf/zoo_sample.cfg`：

```
$ cp conf/zoo_sample.cfg conf/zoo.cfg
```

## 启动 ZooKeeper 服务器

执行以下命令

```
$ bin/zkServer.sh start
```

执行此命令后，你将收到以下响应

```
$ JMX enabled by default
$ Using config: /Users/../zookeeper-3.4.6/bin/../conf/zoo.cfg
$ Starting zookeeper ... STARTED
```

## 启动 CLI

键入以下命令

```
$ bin/zkCli.sh
```

键入上述命令后，将连接到 ZooKeeper 服务器，你应该得到以下响应。

```
Connecting to localhost:2181
................
................
................
Welcome to ZooKeeper!
................
................
WATCHER::
WatchedEvent state:SyncConnected type: None path:null
[zk: localhost:2181(CONNECTED) 0]
```

## 停止 ZooKeeper 服务器

连接服务器并执行所有操作后，可以使用以下命令停止 zookeeper 服务器。

```
$ bin/zkServer.sh stop
```

> 本节安装内容参考：[Zookeeper 安装](https://www.w3cschool.cn/zookeeper/zookeeper_installation.html)
