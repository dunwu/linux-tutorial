# 服务安装配置

## oh-my-zsh 安装

说明：

安装 [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

使用方法

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/zsh-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/zsh-install.sh | bash
```

## JDK8 安装

说明：

JDK8 会被安装到 `/usr/lib/jvm/java` 路径。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/jdk8-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/jdk8-install.sh | bash
```

## Maven 安装配置

说明：

- 脚本会下载解压 maven `3.6.0` 到 `/opt/maven` 路径下。
- 备份并替换 `settings.xml`，使用 aliyun 镜像加速 maven。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/maven-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/maven-install.sh | bash
```

## Node.js 安装

说明：

脚本会先安装 nvm（nodejs 版本管理器），并通过 nvm 安装 nodejs `10.15.2`。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/nodejs-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/nodejs-install.sh | bash
```

## MongoDB 安装

说明：

下载 mongodb `4.0.9` 并解压安装到 `/opt/mongodb` 路径下。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/mongodb-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/mongodb-install.sh | bash
```

## Redis 安装

说明：

下载 redis `5.0.4` 并解压安装到 `/opt/redis` 路径下。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/redis-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/redis-install.sh | bash
```

## Tomcat8 安装

说明：

下载 tomcat `8.5.28` 并解压安装到 `/opt/tomcat` 路径下。

使用方法：

```sh
curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/tomcat8-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/tomcat8-install.sh | bash
```

## Kafka 安装

说明：

下载 kafka `2.2.0` 并解压安装到 `/opt/kafka` 路径下。

使用方法：执行以下任意命令即可执行脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/kafka-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/kafka-install.sh | bash
```

## RocketMQ 安装

说明：

下载 rocketmq `4.5.0` 并解压安装到 `/opt/rocketmq` 路径下。

使用方法：执行以下任意命令即可执行脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/rocketmq-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/rocketmq-install.sh | bash
```

## ZooKeeper 安装

说明：

下载 zookeeper `3.4.12` 并解压安装到 `/opt/zookeeper` 路径下。

使用方法：执行以下任意命令即可执行脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/zookeeper-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/soft/zookeeper-install.sh | bash
```

