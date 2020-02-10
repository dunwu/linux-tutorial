# 服务安装配置

<!-- TOC depthFrom:2 depthTo:3 -->

- [oh-my-zsh 安装](#oh-my-zsh-安装)
- [JDK8 安装](#jdk8-安装)
- [Maven 安装配置](#maven-安装配置)
- [Node.js 安装](#nodejs-安装)
- [MongoDB 安装](#mongodb-安装)
- [Redis 安装配置](#redis-安装配置)
- [Tomcat8 安装](#tomcat8-安装)
- [Kafka 安装](#kafka-安装)
- [RocketMQ 安装](#rocketmq-安装)
- [Nacos 安装](#nacos-安装)
- [ZooKeeper 安装](#zookeeper-安装)
- [Nginx 运维](#nginx-安装)
- [Fastdfs 安装](#fastdfs-安装)
- [Docker 安装](#docker-安装)

<!-- /TOC -->

## oh-my-zsh 安装

说明：

安装 [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

使用方法

执行以下任意命令即可执行安装脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/zsh-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/zsh-install.sh | bash
```

## JDK8 安装

说明：

JDK8 会被安装到 `/usr/lib/jvm/java` 路径。

使用方法：

执行以下任意命令即可执行安装脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/jdk8-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/jdk8-install.sh | bash
```

## Maven 安装配置

说明：

- 脚本会下载解压 maven `3.6.0` 到 `/opt/maven` 路径下。
- 备份并替换 `settings.xml`，使用 aliyun 镜像加速 maven。

使用方法：

执行以下任意命令即可执行安装脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/maven-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/maven-install.sh | bash
```

## Node.js 安装

说明：

脚本会先安装 nvm（nodejs 版本管理器），并通过 nvm 安装 nodejs `10.15.2`。

使用方法：

执行以下任意命令即可执行安装脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/nodejs-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/nodejs-install.sh | bash
```

## MongoDB 安装

说明：

下载 mongodb `4.0.9` 并解压安装到 `/opt/mongodb` 路径下。

使用方法：

执行以下任意命令即可执行安装脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/mongodb-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/mongodb-install.sh | bash
```

## Redis 安装配置

**安装说明**

- 采用编译方式安装 Redis, 并将其注册为 systemd 服务
- 安装路径为：`/usr/local/redis`
- 默认下载安装 `5.0.4` 版本，端口号为：`6379`，密码为空

**使用方法**

- 默认安装 - 执行以下任意命令即可：

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/redis-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/redis-install.sh | bash
```

- 自定义安装 - 下载脚本到本地，并按照以下格式执行：


```shell
sh redis-install.sh [version] [port] [password]
```

参数说明：

- `version` - redis 版本号
- `port` - redis 服务端口号
- `password` - 访问密码

## Tomcat8 安装

说明：

下载 tomcat `8.5.28` 并解压安装到 `/opt/tomcat` 路径下。

使用方法：

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/tomcat8-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/tomcat8-install.sh | bash
```

## Kafka 安装

说明：

下载 kafka `2.2.0` 并解压安装到 `/opt/kafka` 路径下。

使用方法：执行以下任意命令即可执行脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/kafka-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/kafka-install.sh | bash
```

## RocketMQ 安装

说明：

下载 rocketmq `4.5.0` 并解压安装到 `/opt/rocketmq` 路径下。

使用方法：执行以下任意命令即可执行脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/rocketmq-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/rocketmq-install.sh | bash
```

## Nacos 安装

说明：

下载 Nacos `1.0.0` 并解压安装到 `/opt/nacos` 路径下。

使用方法：执行以下任意命令即可执行脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/nacos-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/nacos-install.sh | bash
```

## ZooKeeper 安装

说明：

下载 zookeeper `3.4.12` 并解压安装到 `/opt/zookeeper` 路径下。

使用方法：执行以下任意命令即可执行脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/zookeeper-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/zookeeper-install.sh | bash
```

## Nginx 运维

**安装说明**

- 采用编译方式安装 Nginx, 并将其注册为 systemd 服务
- 安装路径为：`/usr/local/nginx`
- 默认下载安装 `1.16.0` 版本

**使用方法**

- 默认安装 - 执行以下任意命令即可：


```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/nginx-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/nginx-install.sh | bash
```

- 自定义安装 - 下载脚本到本地，并按照以下格式执行：

```bash
sh nginx-install.sh [version]
```

## Fastdfs 安装

说明：

采用编译方式安装 Fastdfs

下载 Fastdfs 并解压安装到 `/opt/fdfs` 路径下。

使用方法：执行以下任意命令即可执行脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/fastdfs-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/fastdfs-install.sh | bash
```

## Docker 安装

说明：

使用方法：执行以下任意命令即可执行脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/docker-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/docker-install.sh | bash
```

## FastDFS 安装

说明：

使用方法：执行以下任意命令即可执行脚本。

```shell
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/fastdfs-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/fastdfs-install.sh | bash
```
