# 服务安装配置

## oh-my-zsh 安装

说明：

安装 [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

使用方法

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/zsh-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/zsh-install.sh | bash
```

## JDK8 安装

说明：

JDK8 会被安装到 `/usr/lib/jvm/java` 路径。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/jdk8-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/jdk8-install.sh | bash
```

## Maven 安装配置

说明：

- 脚本会下载解压 maven `3.6.0` 到 `/opt/maven` 路径下。
- 备份并替换 `settings.xml`，使用 aliyun 镜像加速 maven。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/maven-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/maven-install.sh | bash
```

## Node.js 安装

说明：

脚本会先安装 nvm（nodejs 版本管理器），并通过 nvm 安装 nodejs `10.15.2`。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/nodejs-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/nodejs-install.sh | bash
```

## MongoDB 安装

说明：

下载 mongodb `4.0.9` 并解压安装到 `/opt/mongodb` 路径下。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/mongodb-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/mongodb-install.sh | bash
```

## Redis 安装配置

说明：

- 下载 redis `5.0.4` 并解压安装到 `/opt/redis` 路径下。
- 替换配置，使得 Redis 可以远程访问，并设置默认密码为 123456。
- 注册 redis 服务，并设置为开机自启动

使用方法：

执行以下任意命令即可按照默认配置安装脚本。

```sh
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/redis-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/redis-install.sh | bash
```

定制化配置

```sh
# 下载脚本到本地
wget https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/redis-install.sh
chmod +x redis-install.sh
./redis-install.sh 5.0.4 /opt/redis 6379 123456
```

说明：

- 第一个参数是 redis 版本号；
- 第二个参数是 redis 安装路径；
- 第三个参数是 redis 服务端口号；
- 第四个参数是访问密码

## Tomcat8 安装

说明：

下载 tomcat `8.5.28` 并解压安装到 `/opt/tomcat` 路径下。

使用方法：

```sh
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/tomcat8-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/tomcat8-install.sh | bash
```

## Kafka 安装

说明：

下载 kafka `2.2.0` 并解压安装到 `/opt/kafka` 路径下。

使用方法：执行以下任意命令即可执行脚本。

```sh
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/kafka-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/kafka-install.sh | bash
```

## RocketMQ 安装

说明：

下载 rocketmq `4.5.0` 并解压安装到 `/opt/rocketmq` 路径下。

使用方法：执行以下任意命令即可执行脚本。

```sh
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/rocketmq-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/rocketmq-install.sh | bash
```

## Nacos 安装

说明：

下载 Nacos `1.0.0` 并解压安装到 `/opt/nacos` 路径下。

使用方法：执行以下任意命令即可执行脚本。

```sh
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/nacos-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/nacos-install.sh | bash
```

## ZooKeeper 安装

说明：

下载 zookeeper `3.4.12` 并解压安装到 `/opt/zookeeper` 路径下。

使用方法：执行以下任意命令即可执行脚本。

```sh
curl -o- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/zookeeper-install.sh | bash
wget -qO- https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/zookeeper-install.sh | bash
```

