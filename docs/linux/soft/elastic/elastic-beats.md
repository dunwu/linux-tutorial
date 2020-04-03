---
title: Elastic 技术栈之 Filebeat
date: 2017-01-03
categories:
- javatool
tags:
- java
- javatool
- log
- elastic
---

# Elastic 技术栈之 Filebeat

## 简介

Beats 是安装在服务器上的数据中转代理。

Beats 可以将数据直接传输到 Elasticsearch 或传输到 Logstash 。

![img](https://www.elastic.co/guide/en/beats/libbeat/current/images/beats-platform.png)

Beats 有多种类型，可以根据实际应用需要选择合适的类型。

常用的类型有：

- **Packetbeat：**网络数据包分析器，提供有关您的应用程序服务器之间交换的事务的信息。
- **Filebeat：**从您的服务器发送日志文件。
- **Metricbeat：**是一个服务器监视代理程序，它定期从服务器上运行的操作系统和服务收集指标。
- **Winlogbeat：**提供Windows事件日志。

> **参考**
>
> 更多 Beats 类型可以参考：[community-beats](https://www.elastic.co/guide/en/beats/libbeat/current/community-beats.html)
>
> **说明**
>
> 由于本人工作中只应用了 FileBeat，所以后面内容仅介绍 FileBeat 。

### FileBeat 的作用

相比 Logstash，FileBeat 更加轻量化。

在任何环境下，应用程序都有停机的可能性。 Filebeat 读取并转发日志行，如果中断，则会记住所有事件恢复联机状态时所在位置。

Filebeat带有内部模块（auditd，Apache，Nginx，System和MySQL），可通过一个指定命令来简化通用日志格式的收集，解析和可视化。

FileBeat 不会让你的管道超负荷。FileBeat 如果是向 Logstash 传输数据，当 Logstash 忙于处理数据，会通知 FileBeat 放慢读取速度。一旦拥塞得到解决，FileBeat 将恢复到原来的速度并继续传播。

![img](https://www.elastic.co/guide/en/beats/filebeat/current/images/filebeat.png)

## 安装

Unix / Linux 系统建议使用下面方式安装，因为比较通用。

```
wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.1.1-linux-x86_64.tar.gz
tar -zxf filebeat-6.1.1-linux-x86_64.tar.gz
```

> **参考**
>
> 更多内容可以参考：[filebeat-installation](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-installation.html)

## 配置

### 配置文件

首先，需要知道的是：`filebeat.yml` 是 filebeat 的配置文件。配置文件的路径会因为你安装方式的不同而变化。

Beat 所有系列产品的配置文件都基于 [YAML](http://www.yaml.org/) 格式，FileBeat 当然也不例外。

filebeat.yml 部分配置示例：

```yaml
filebeat:
  prospectors:
    - type: log
      paths:
        - /var/log/*.log
      multiline:
        pattern: '^['
        match: after
```

> **参考**
>
> 更多 filebeat 配置内容可以参考：[配置 filebeat](https://www.elastic.co/guide/en/beats/filebeat/current/configuring-howto-filebeat.html)
>
> 更多 filebeat.yml 文件格式内容可以参考：[filebeat.yml 文件格式](https://www.elastic.co/guide/en/beats/libbeat/6.1/config-file-format.html)

### 重要配置项

#### filebeat.prospectors

（文件监视器）用于指定需要关注的文件。

**示例**

```yaml
filebeat.prospectors:
- type: log
  enabled: true
  paths:
    - /var/log/*.log
```

#### output.elasticsearch

如果你希望使用 filebeat 直接向 elasticsearch 输出数据，需要配置 output.elasticsearch 。

**示例**

```yaml
output.elasticsearch:
  hosts: ["192.168.1.42:9200"]
```

#### output.logstash

如果你希望使用 filebeat 向 logstash输出数据，然后由 logstash 再向elasticsearch 输出数据，需要配置 output.logstash。

> **注意**
>
> 相比于向 elasticsearch 输出数据，个人更推荐向 logstash 输出数据。
>
> 因为 logstash 和 filebeat 一起工作时，如果 logstash 忙于处理数据，会通知 FileBeat 放慢读取速度。一旦拥塞得到解决，FileBeat 将恢复到原来的速度并继续传播。这样，可以减少管道超负荷的情况。

**示例**

```yaml
output.logstash:
  hosts: ["127.0.0.1:5044"]
```

此外，还需要在 logstash 的配置文件（如 logstash.conf）中指定 beats input 插件：

```yaml
input {
  beats {
    port => 5044 # 此端口需要与 filebeat.yml 中的端口相同
  }
}

# The filter part of this file is commented out to indicate that it is
# optional.
# filter {
#
# }

output {
  elasticsearch {
    hosts => "localhost:9200"
    manage_template => false
    index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}" 
    document_type => "%{[@metadata][type]}" 
  }
}
```

#### setup.kibana

如果打算使用 Filebeat 提供的 Kibana 仪表板，需要配置 setup.kibana 。

**示例**

```yaml
setup.kibana:
  host: "localhost:5601"
```

#### setup.template.settings

在 Elasticsearch 中，[索引模板](https://www.elastic.co/guide/en/elasticsearch/reference/6.1/indices-templates.html)用于定义设置和映射，以确定如何分析字段。

在 Filebeat 中，setup.template.settings 用于配置索引模板。

Filebeat 推荐的索引模板文件由 Filebeat 软件包安装。如果您接受 filebeat.yml 配置文件中的默认配置，Filebeat在成功连接到 Elasticsearch 后自动加载模板。

您可以通过在 Filebeat 配置文件中配置模板加载选项来禁用自动模板加载，或加载自己的模板。您还可以设置选项来更改索引和索引模板的名称。

> **参考**
>
> 更多内容可以参考：[filebeat-template](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-template.html)
>
> **说明**
>
> 如无必要，使用 Filebeat 配置文件中的默认索引模板即可。

#### setup.dashboards

Filebeat 附带了示例 Kibana 仪表板。在使用仪表板之前，您需要创建索引模式 `filebeat- *`，并将仪表板加载到Kibana 中。为此，您可以运行 `setup` 命令或在 `filebeat.yml` 配置文件中配置仪表板加载。

为了在 Kibana 中加载 Filebeat 的仪表盘，需要在 `filebeat.yml` 配置中启动开关：

```
setup.dashboards.enabled: true
```

> **参考**
>
> 更多内容可以参考：[configuration-dashboards](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-dashboards.html)
>

## 命令

filebeat 提供了一系列命令来完成各种功能。

执行命令方式：

```bash
./filebeat COMMAND
```

> **参考**
>
> 更多内容可以参考：[command-line-options](https://www.elastic.co/guide/en/beats/filebeat/current/command-line-options.html)
>
> **说明**
>
> 个人认为命令行没有必要一一掌握，因为绝大部分功能都可以通过配置来完成。且通过命令行指定功能这种方式要求每次输入同样参数，不利于固化启动方式。
>
> 最重要的当然是启动命令 run 了。
>
> **示例** 指定配置文件启动
>
> ```bash
> ./filebeat run -e -c filebeat.yml -d "publish"
> ./filebeat -e -c filebeat.yml -d "publish" # run 可以省略
> ```

## 模块

Filebeat 提供了一套预构建的模块，让您可以快速实施和部署日志监视解决方案，并附带示例仪表板和数据可视化。这些模块支持常见的日志格式，例如Nginx，Apache2和MySQL 等。

### 运行模块的步骤

- 配置 elasticsearch 和 kibana

```
output.elasticsearch:
  hosts: ["myEShost:9200"]
  username: "elastic"
  password: "elastic"
setup.kibana:
  host: "mykibanahost:5601"
  username: "elastic" 
  password: "elastic
```

> username 和 password 是可选的，如果不需要认证则不填。

- 初始化环境

执行下面命令，filebeat 会加载推荐索引模板。

```
./filebeat setup -e
```

- 指定模块

执行下面命令，指定希望加载的模块。

```
./filebeat -e --modules system,nginx,mysql
```

> **参考**
>
> 更多内容可以参考： [配置 filebeat 模块](https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-modules.html) | [filebeat 支持模块](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-modules.html)

## 原理

Filebeat 有两个主要组件：

harvester：负责读取一个文件的内容。它会逐行读取文件内容，并将内容发送到输出目的地。

prospector：负责管理 harvester 并找到所有需要读取的文件源。比如类型是日志，prospector 就会遍历制定路径下的所有匹配要求的文件。

```yaml
filebeat.prospectors:
- type: log
  paths:
    - /var/log/*.log
    - /var/path2/*.log
```

Filebeat保持每个文件的状态，并经常刷新注册表文件中的磁盘状态。状态用于记住 harvester 正在读取的最后偏移量，并确保发送所有日志行。

Filebeat 将每个事件的传递状态存储在注册表文件中。所以它能保证事件至少传递一次到配置的输出，没有数据丢失。

## 资料

[Beats 官方文档](https://www.elastic.co/guide/en/beats/libbeat/current/index.html)

