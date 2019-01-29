# OS

> 作为研发工程师，谁还没干过点运维的活？:joy:
>
> 搞运维，怎么着也得懂点操作系统相关。
>
> 本项目，就是本人在日常学习工作中，对于操作系统、运维部署等相关知识的整理。

## :books: 内容

### [Linux](docs/linux/README.md)

- [查看 Linux 命令帮助信息](docs/linux/01.查看Linux命令帮助信息.md) - 关键词：`help`, `whatis`, `info`, `which`, `whereis`, `man`
- [Linux 文件目录管理](docs/linux/02.Linux文件目录管理.md) - 关键词：`cd`, `ls`, `pwd`, `mkdir`, `rmdir`, `tree`, `touch`, `ln`, `rename`, `stat`, `file`, `chmod`, `chown`, `locate`, `find`, `cp`, `mv`, `rm`
- [Linux 文件内容查看命令](docs/linux/03.Linux文件内容查看编辑.md) - 关键词：`cat`, `head`, `tail`, `more`, `less`, `sed`, `vi`, `grep`
- [Linux 文件压缩和解压](docs/linux/04.Linux文件压缩和解压.md) - 关键词：`tar`, `gzip`, `zip`, `unzip`
- [Linux 用户管理](docs/linux/05.Linux用户管理.md) - 关键词：`groupadd`, `groupdel`, `groupmod`, `useradd`, `userdel`, `usermod`, `passwd`, `su`, `sudo`
- [Linux 系统管理](docs/linux/06.Linux系统管理.md) - 关键词：`reboot`, `exit`, `shutdown`, `date`, `mount`, `umount`, `ps`, `kill`, `systemctl`, `service`, `crontab`
- [Linux 网络管理](docs/linux/07.Linux网络管理.md) - 关键词：关键词：`curl`, `wget`, `telnet`, `ip`, `hostname`, `ifconfig`, `route`, `ssh`, `ssh-keygen`, `firewalld`, `iptables`, `host`, `nslookup`, `nc`/`netcat`, `ping`, `traceroute`, `netstat`
- [Linux 硬件管理](docs/linux/08.Linux硬件管理.md) - 关键词：`df`, `du`, `top`, `free`, `iotop`
- [Linux 软件管理](docs/linux/09.Linux软件管理.md) - 关键词：`rpm`, `yum`, `apt-get`
- [samba 使用详解](docs/linux/samba使用详解.md)
- [命令行的艺术（转载）](docs/linux/命令行的艺术.md)

### [Shell](docs/shell.md)

### [Python](docs/python.md)

### [Vim](docs/vim.md)

### [Docker](docs/docker/README.md)

### Windows

- [Windows 工具](docs/windows/Windows工具.md)

## :hammer_and_pick: 常见软件安装/配置/使用指南

> :bulb: **说明**
> 
> 这里总结了多种常用研发软件的安装、配置、使用指南。并提供基本安装、运行的脚本。
>
> [环境部署工具](codes/deploy/README.md) ：适合开发、运维人员，在 [CentOS](https://www.centos.org/) 机器上安装常用命令工具或开发软件。
> 
> - *`Scripts`：安装配置脚本，按照说明安装使用即可。*
> - *`Docs`: 安装配置文档，说明安装的方法以及一些注意事项。*
> - *`Tutorial`: 教程文档。*

#### 研发环境

- JDK
  - | [**`Scripts`**](codes/deploy/tool/jdk) | [**`Docs`**](docs/tool/jdk.md) |
- Maven
  - | [**`Scripts`**](codes/deploy/tool/maven) | [**`Tutorial`**](https://github.com/dunwu/javastack/tree/master/docs/javatool/build/maven) | 
- Nginx
  - | [**`Scripts`**](codes/deploy/tool/nginx)  | [**`Tutorial`**](https://github.com/dunwu/nginx-tutorial) | 
- Nodejs
  - | [**`Scripts`**](codes/deploy/tool/nodejs) | [**`Docs`**](docs/tool/nodejs.md) |
- Tomcat
  - | [**`Scripts`**](codes/deploy/tool/tomcat) | [**`Docs`**](docs/tool/tomcat.md) |
- Zookeeper
  - | [**`Scripts`**](codes/deploy/tool/zookeeper) | [**`Docs`**](docs/tool/zookeeper.md) |

#### 研发工具

- Nexus - Maven 私服。
  - | [**`Docs`**](docs/tool/nexus.md) |
- Gitlab - Git 代码管理平台。
- Jenkins - 持续集成和持续交付平台。
  - | [**`Scripts`**](codes/deploy/tool/jenkins) | [**`Docs`**](docs/tool/jenkins.md) |
- Elastic  -  常被称为 `ELK` ，是 Java 世界最流行的分布式日志解决方案 。 `ELK`  是 Elastic 公司旗下三款产品 [ElasticSearch](https://www.elastic.co/products/elasticsearch) 、[Logstash](https://www.elastic.co/products/logstash) 、[Kibana](https://www.elastic.co/products/kibana) 的首字母组合。
  - | [**`Tutorial`**](docs/tool/elastic/README.md) |

#### 版本控制

- Git
  - | [**`Tutorial`**](docs/git/README.md) |
- Svn - Svn 是 Subversion 的简称，是一个开放源代码的版本控制系统，它采用了分支管理系统。
  - | [**`Docs`**](docs/tool/svn.md) |

#### 消息中间件

- Kafka - 应该是 Java 世界最流行的消息中间件了吧。
  - | [**`Scripts`**](codes/deploy/tool/kafka) | [**`Docs`**](docs/tool/kafka.md) |
- RocketMQ - 阿里巴巴开源的消息中间件。
  - | [**`Scripts`**](codes/deploy/tool/rocketmq) | [**`Docs`**](docs/tool/rocketmq.md) |

#### 数据库

- Mysql - 关系型数据库
  - | [**`Docs`**](https://github.com/dunwu/database/blob/master/docs/mysql/install-mysql.md) |
- PostgreSQL - 关系型数据库
  - | [**`Docs`**](https://github.com/dunwu/database/blob/master/docs/postgresql.md#安装) |
- Mongodb - Nosql
  - | [**`Scripts`**](codes/deploy/tool/mongodb) | [**`Docs`**](https://github.com/dunwu/database/blob/master/docs/mongodb/install-mongodb.md) |
- Redis - Nosql
  - | [**`Scripts`**](codes/deploy/tool/redis) | [**`Docs`**](https://github.com/dunwu/database/blob/master/docs/redis/install-redis.md) |
