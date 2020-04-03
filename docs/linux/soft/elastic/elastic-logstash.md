---
title: Elastic 技术栈之 Logstash 基础
date: 2017-12-26
categories:
- javatool
tags:
- java
- javatool
- log
- elastic
---

# Elastic 技术栈之 Logstash 基础

> 本文是 Elastic 技术栈（ELK）的 Logstash 应用。
>
> 如果不了解 Elastic 的安装、配置、部署，可以参考：[Elastic 技术栈之快速入门](https://github.com/dunwu/JavaStack/blob/master/docs/javatool/elastic/elastic-quickstart.md)

## 简介

Logstash 可以传输和处理你的日志、事务或其他数据。

### 功能

Logstash 是 Elasticsearch  的最佳数据管道。

Logstash 是插件式管理模式，在输入、过滤、输出以及编码过程中都可以使用插件进行定制。Logstash 社区有超过 200 种可用插件。

### 工作原理

Logstash 有两个必要元素：`input` 和 `output` ，一个可选元素：`filter`。

这三个元素，分别代表 Logstash 事件处理的三个阶段：输入 > 过滤器 > 输出。

![img](https://www.elastic.co/guide/en/logstash/current/static/images/basic_logstash_pipeline.png)

- input 负责从数据源采集数据。
- filter 将数据修改为你指定的格式或内容。
- output 将数据传输到目的地。

在实际应用场景中，通常输入、输出、过滤器不止一个。Logstash 的这三个元素都使用插件式管理方式，用户可以根据应用需要，灵活的选用各阶段需要的插件，并组合使用。

后面将对插件展开讲解，暂且不表。

## 设置

### 设置文件

- **`logstash.yml`**：logstash 的默认启动配置文件
- **`jvm.options`**：logstash 的 JVM 配置文件。
- **`startup.options`** (Linux)：包含系统安装脚本在 `/usr/share/logstash/bin` 中使用的选项为您的系统构建适当的启动脚本。安装 Logstash 软件包时，系统安装脚本将在安装过程结束时执行，并使用 `startup.options` 中指定的设置来设置用户，组，服务名称和服务描述等选项。


### logstash.yml 设置项

节选部分设置项，更多项请参考：https://www.elastic.co/guide/en/logstash/current/logstash-settings-file.html

| 参数                         | 描述                                       | 默认值                                      |
| -------------------------- | ---------------------------------------- | ---------------------------------------- |
| `node.name`                | 节点名                                      | 机器的主机名                                   |
| `path.data`                | Logstash及其插件用于任何持久性需求的目录。                | `LOGSTASH_HOME/data`                     |
| `pipeline.workers`         | 同时执行管道的过滤器和输出阶段的工作任务数量。如果发现事件正在备份，或CPU未饱和，请考虑增加此数字以更好地利用机器处理能力。 | Number of the host’s CPU cores           |
| `pipeline.batch.size`      | 尝试执行过滤器和输出之前，单个工作线程从输入收集的最大事件数量。较大的批量处理大小一般来说效率更高，但是以增加的内存开销为代价。您可能必须通过设置 `LS_HEAP_SIZE` 变量来有效使用该选项来增加JVM堆大小。 | `125`                                    |
| `pipeline.batch.delay`     | 创建管道事件批处理时，在将一个尺寸过小的批次发送给管道工作任务之前，等待每个事件需要多长时间（毫秒）。 | `5`                                      |
| `pipeline.unsafe_shutdown` | 如果设置为true，则即使在内存中仍存在inflight事件时，也会强制Logstash在关闭期间退出。默认情况下，Logstash将拒绝退出，直到所有接收到的事件都被推送到输出。启用此选项可能会导致关机期间数据丢失。 | `false`                                  |
| `path.config`              | 主管道的Logstash配置路径。如果您指定一个目录或通配符，配置文件将按字母顺序从目录中读取。 | Platform-specific. See [[dir-layout\]](https://github.com/elastic/logstash/blob/6.1/docs/static/settings-file.asciidoc#dir-layout). |
| `config.string`            | 包含用于主管道的管道配置的字符串。使用与配置文件相同的语法。           | None                                     |
| `config.test_and_exit`     | 设置为true时，检查配置是否有效，然后退出。请注意，使用此设置不会检查grok模式的正确性。 Logstash可以从目录中读取多个配置文件。如果将此设置与log.level：debug结合使用，则Logstash将记录组合的配置文件，并注掉其源文件的配置块。 | `false`                                  |
| `config.reload.automatic`  | 设置为true时，定期检查配置是否已更改，并在配置更改时重新加载配置。这也可以通过SIGHUP信号手动触发。 | `false`                                  |
| `config.reload.interval`   | Logstash 检查配置文件更改的时间间隔。                  | `3s`                                     |
| `config.debug`             | 设置为true时，将完全编译的配置显示为调试日志消息。您还必须设置`log.level：debug`。警告：日志消息将包括任何传递给插件配置作为明文的“密码”选项，并可能导致明文密码出现在您的日志！ | `false`                                  |
| `config.support_escapes`   | 当设置为true时，带引号的字符串将处理转义字符。                | `false`                                  |
| `modules`                  | 配置时，模块必须处于上表所述的嵌套YAML结构中。                | None                                     |
| `http.host`                | 绑定地址                                     | `"127.0.0.1"`                            |
| `http.port`                | 绑定端口                                     | `9600`                                   |
| `log.level`                | 日志级别。有效选项：fatal > error > warn > info > debug > trace | `info`                                   |
| `log.format`               | 日志格式。json （JSON 格式）或 plain （原对象）         | `plain`                                  |
| `path.logs`                | Logstash 自身日志的存储路径                       | `LOGSTASH_HOME/logs`                     |
| `path.plugins`             | 在哪里可以找到自定义的插件。您可以多次指定此设置以包含多个路径。         |                                          |

## 启动

### 命令行

通过命令行启动 logstash 的方式如下：

```
bin/logstash [options]
```

其中 [options] 是您可以指定用于控制 Logstash 执行的命令行标志。

在命令行上设置的任何标志都会覆盖 Logstash 设置文件（`logstash.yml`）中的相应设置，但设置文件本身不会更改。

> **注**
>
> 虽然可以通过指定命令行参数的方式，来控制 logstash 的运行方式，但显然这么做很麻烦。
>
> 建议通过指定配置文件的方式，来控制 logstash 运行，启动命令如下：
>
> ```
> bin/logstash -f logstash.conf
> ```
> 若想了解更多的命令行参数细节，请参考：https://www.elastic.co/guide/en/logstash/current/running-logstash-command-line.html
>

### 配置文件

上节，我们了解到，logstash 可以执行 `bin/logstash -f logstash.conf` ，按照配置文件中的参数去覆盖默认设置文件（`logstash.yml`）中的设置。

这节，我们就来学习一下这个配置文件如何配置参数。

#### 配置文件结构

在工作原理一节中，我们已经知道了 Logstash 主要有三个工作阶段 input 、filter、output。而 logstash 配置文件文件结构也与之相对应：

```
input {}

filter {}

output {}
```

> 每个部分都包含一个或多个插件的配置选项。如果指定了多个过滤器，则会按照它们在配置文件中的显示顺序应用它们。

#### 插件配置

插件的配置由插件名称和插件的一个设置块组成。

下面的例子中配置了两个输入文件配置：

```
input {
  file {
    path => "/var/log/messages"
    type => "syslog"
  }

  file {
    path => "/var/log/apache/access.log"
    type => "apache"
  }
}
```

您可以配置的设置因插件类型而异。你可以参考： [Input Plugins](https://www.elastic.co/guide/en/logstash/current/input-plugins.html), [Output Plugins](https://www.elastic.co/guide/en/logstash/current/output-plugins.html), [Filter Plugins](https://www.elastic.co/guide/en/logstash/current/filter-plugins.html), 和 [Codec Plugins](https://www.elastic.co/guide/en/logstash/current/codec-plugins.html) 。

#### 值类型

一个插件可以要求设置的值是一个特定的类型，比如布尔值，列表或哈希值。以下值类型受支持。

- Array

```
  users => [ {id => 1, name => bob}, {id => 2, name => jane} ]
```

- Lists

```
  path => [ "/var/log/messages", "/var/log/*.log" ]
  uris => [ "http://elastic.co", "http://example.net" ]
```

- Boolean

```
  ssl_enable => true
```

- Bytes

```
  my_bytes => "1113"   # 1113 bytes
  my_bytes => "10MiB"  # 10485760 bytes
  my_bytes => "100kib" # 102400 bytes
  my_bytes => "180 mb" # 180000000 bytes
```

- Codec

```
  codec => "json"
```

- Hash

```
match => {
  "field1" => "value1"
  "field2" => "value2"
  ...
}
```

- Number

```
  port => 33
```

- Password

```
  my_password => "password"
```

- URI

```
  my_uri => "http://foo:bar@example.net"
```

- Path

```
  my_path => "/tmp/logstash"
```

- String


- 转义字符

## 插件

### input

> Logstash 支持各种输入选择 ，可以在同一时间从众多常用来源捕捉事件。能够以连续的流式传输方式，轻松地从您的日志、指标、Web 应用、数据存储以及各种 AWS 服务采集数据。

#### 常用 input 插件

- **file**：从文件系统上的文件读取，就像UNIX命令 `tail -0F` 一样
- **syslog：**在众所周知的端口514上侦听系统日志消息，并根据RFC3164格式进行解析
- **redis：**从redis服务器读取，使用redis通道和redis列表。 Redis经常用作集中式Logstash安装中的“代理”，它将来自远程Logstash“托运人”的Logstash事件排队。
- **beats：**处理由Filebeat发送的事件。

更多详情请见：[Input Plugins](https://www.elastic.co/guide/en/logstash/current/input-plugins.html)

### filter

> 过滤器是Logstash管道中的中间处理设备。如果符合特定条件，您可以将条件过滤器组合在一起，对事件执行操作。

#### 常用 filter 插件

- **grok：**解析和结构任意文本。 Grok目前是Logstash中将非结构化日志数据解析为结构化和可查询的最佳方法。
- **mutate：**对事件字段执行一般转换。您可以重命名，删除，替换和修改事件中的字段。

- **drop：**完全放弃一个事件，例如调试事件。

- **clone：**制作一个事件的副本，可能会添加或删除字段。

- **geoip：**添加有关IP地址的地理位置的信息（也可以在Kibana中显示惊人的图表！）


更多详情请见：[Filter Plugins](https://www.elastic.co/guide/en/logstash/current/filter-plugins.html)

### output

> 输出是Logstash管道的最后阶段。一个事件可以通过多个输出，但是一旦所有输出处理完成，事件就完成了执行。

#### 常用 output 插件

- **elasticsearch：**将事件数据发送给 Elasticsearch（推荐模式）。
- **file：**将事件数据写入文件或磁盘。
- **graphite：**将事件数据发送给 graphite（一个流行的开源工具，存储和绘制指标。 http://graphite.readthedocs.io/en/latest/）。
- **statsd：**将事件数据发送到 statsd （这是一种侦听统计数据的服务，如计数器和定时器，通过UDP发送并将聚合发送到一个或多个可插入的后端服务）。

更多详情请见：[Output Plugins](https://www.elastic.co/guide/en/logstash/current/output-plugins.html)

### codec

用于格式化对应的内容。

#### 常用 codec 插件

- **json：**以JSON格式对数据进行编码或解码。
- **multiline：**将多行文本事件（如java异常和堆栈跟踪消息）合并为单个事件。

更多插件请见：[Codec Plugins](https://www.elastic.co/guide/en/logstash/current/codec-plugins.html)

## 实战

前面的内容都是对 Logstash 的介绍和原理说明。接下来，我们来实战一些常见的应用场景。

### 传输控制台数据

> stdin input 插件从标准输入读取事件。这是最简单的 input 插件，一般用于测试场景。
>

**应用**

（1）创建 `logstash-input-stdin.conf` ：

```
input { stdin { } }
output {
  elasticsearch { hosts => ["localhost:9200"] }
  stdout { codec => rubydebug }
}
```

更多配置项可以参考：https://www.elastic.co/guide/en/logstash/current/plugins-inputs-stdin.html

（2）执行 logstash，使用 `-f` 来指定你的配置文件：

```
bin/logstash -f logstash-input-stdin.conf
```

### 传输 logback 日志

> elk 默认使用的 Java 日志工具是 log4j2 ，并不支持 logback 和 log4j。
>
> 想使用 logback + logstash ，可以使用 [logstash-logback-encoder](https://github.com/logstash/logstash-logback-encoder) 。[logstash-logback-encoder](https://github.com/logstash/logstash-logback-encoder) 提供了 UDP / TCP / 异步方式来传输日志数据到 logstash。
>
> 如果你使用的是 log4j ，也不是不可以用这种方式，只要引入桥接 jar 包即可。如果你对 log4j 、logback ，或是桥接 jar 包不太了解，可以参考我的这篇博文：[细说 Java 主流日志工具库](https://github.com/dunwu/JavaStack/blob/master/docs/javalib/java-log.md) 。

#### TCP 应用

1. logstash 配置

   （1）创建 `logstash-input-tcp.conf` ：

```
input {
tcp {
  port => 9251
  codec => json_lines
  mode => server
}
}
output {
 elasticsearch { hosts => ["localhost:9200"] }
 stdout { codec => rubydebug }
}
```

   更多配置项可以参考：https://www.elastic.co/guide/en/logstash/current/plugins-inputs-tcp.html

   （2）执行 logstash，使用 `-f` 来指定你的配置文件：`bin/logstash -f logstash-input-udp.conf`


2. java 应用配置

   （1）在 Java 应用的 pom.xml 中引入 jar 包：

```xml
<dependency>
 <groupId>net.logstash.logback</groupId>
 <artifactId>logstash-logback-encoder</artifactId>
 <version>4.11</version>
</dependency>

<!-- logback 依赖包 -->
<dependency>
 <groupId>ch.qos.logback</groupId>
 <artifactId>logback-core</artifactId>
 <version>1.2.3</version>
</dependency>
<dependency>
 <groupId>ch.qos.logback</groupId>
 <artifactId>logback-classic</artifactId>
 <version>1.2.3</version>
</dependency>
<dependency>
 <groupId>ch.qos.logback</groupId>
 <artifactId>logback-access</artifactId>
 <version>1.2.3</version>
</dependency>
```

   （2）接着，在 logback.xml 中添加 appender

```xml
<appender name="ELK-TCP" class="net.logstash.logback.appender.LogstashTcpSocketAppender">
 <!--
 destination 是 logstash 服务的 host:port，
 相当于和 logstash 建立了管道，将日志数据定向传输到 logstash
 -->
 <destination>192.168.28.32:9251</destination>
 <encoder charset="UTF-8" class="net.logstash.logback.encoder.LogstashEncoder"/>
</appender>
<logger name="io.github.dunwu.spring" level="TRACE" additivity="false">
 <appender-ref ref="ELK-TCP" />
</logger>
```

   （3）接下来，就是 logback 的具体使用 ，如果对此不了解，不妨参考一下我的这篇博文：[细说 Java 主流日志工具库](https://github.com/dunwu/JavaStack/blob/master/docs/javalib/java-log.md) 。

   **实例：**[我的logback.xml](https://github.com/dunwu/JavaStack/blob/master/codes/javatool/src/main/resources/logback.xml)

#### UDP 应用

UDP 和 TCP 的使用方式大同小异。

1. logstash 配置

   （1）创建 `logstash-input-udp.conf` ：

```
input {
udp {
  port => 9250
  codec => json
}
}
output {
 elasticsearch { hosts => ["localhost:9200"] }
 stdout { codec => rubydebug }
}
```

   更多配置项可以参考：https://www.elastic.co/guide/en/logstash/current/plugins-inputs-udp.html

   （2）执行 logstash，使用 `-f` 来指定你的配置文件：`bin/logstash -f logstash-input-udp.conf`


2. java 应用配置

   （1）在 Java 应用的 pom.xml 中引入 jar 包：

   与 **TCP 应用** 一节中的引入依赖包完全相同。

   （2）接着，在 logback.xml 中添加 appender

 ```xml
 <appender name="ELK-UDP" class="net.logstash.logback.appender.LogstashSocketAppender">
   <host>192.168.28.32</host>
   <port>9250</port>
 </appender>
 <logger name="io.github.dunwu.spring" level="TRACE" additivity="false">
   <appender-ref ref="ELK-UDP" />
 </logger>
 ```

   （3）接下来，就是 logback 的具体使用 ，如果对此不了解，不妨参考一下我的这篇博文：[细说 Java 主流日志工具库](https://github.com/dunwu/JavaStack/blob/master/docs/javalib/java-log.md) 。

   **实例：**[我的logback.xml](https://github.com/dunwu/JavaStack/blob/master/codes/javatool/src/main/resources/logback.xml)

### 传输文件

> 在 Java Web 领域，需要用到一些重要的工具，例如 Tomcat 、Nginx 、Mysql 等。这些不属于业务应用，但是它们的日志数据对于定位问题、分析统计同样很重要。这时无法使用 logback 方式将它们的日志传输到 logstash。
>
> 如何采集这些日志文件呢？别急，你可以使用 logstash 的 file input 插件。
>
> 需要注意的是，传输文件这种方式，必须在日志所在的机器上部署 logstash 。

**应用**

logstash 配置

（1）创建 `logstash-input-file.conf` ：

```
input {
	file {
		path => ["/var/log/nginx/access.log"]
		type => "nginx-access-log"
		start_position => "beginning"
	}
}

output {
	if [type] == "nginx-access-log" {
		elasticsearch {
			hosts => ["localhost:9200"]
			index => "nginx-access-log"
		}
	}
}
```

（2）执行 logstash，使用 `-f` 来指定你的配置文件：`bin/logstash -f logstash-input-file.conf`

更多配置项可以参考：https://www.elastic.co/guide/en/logstash/current/plugins-inputs-file.html

## 小技巧

### 启动、终止应用

如果你的 logstash 每次都是通过指定配置文件方式启动。不妨建立一个启动脚本。

```
# cd xxx 进入 logstash 安装目录下的 bin 目录
logstash -f logstash.conf
```

如果你的 logstash 运行在 linux 系统下，不妨使用 nohup 来启动一个守护进程。这样做的好处在于，即使关闭终端，应用仍会运行。

**创建 startup.sh**

```
nohup ./logstash -f logstash.conf >> nohup.out 2>&1 &
```

终止应用没有什么好方法，你只能使用 ps -ef | grep logstash ，查出进程，将其kill 。不过，我们可以写一个脚本来干这件事：

**创建 shutdown.sh**

脚本不多解释，请自行领会作用。

```
PID=`ps -ef | grep logstash | awk '{ print $2}' | head -n 1`
kill -9 ${PID}
```

## 资料

- [Logstash 官方文档](https://www.elastic.co/guide/en/logstash/current/index.html)
- [logstash-logback-encoder](https://github.com/logstash/logstash-logback-encoder)
- [ELK Stack权威指南](https://github.com/chenryn/logstash-best-practice-cn)
- [ELK（Elasticsearch、Logstash、Kibana）安装和配置](https://github.com/judasn/Linux-Tutorial/blob/master/ELK-Install-And-Settings.md)

## 推荐阅读

- [Elastic 技术栈](https://github.com/dunwu/JavaStack/blob/master/docs/javatool/elastic/README.md)
- [JavaStack](https://github.com/dunwu/JavaStack)
