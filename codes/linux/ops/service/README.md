# 服务安装配置

## JDK 安装

说明：

JDK8 会被安装到 `/usr/lib/jvm/java` 路径。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/service/jdk8-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/service/jdk8-install.sh | bash
```

## Redis 安装

说明：

下载 `5.0.4` 版本的 redis 并解压安装到 `/opt/redis` 路径下。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/service/redis-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/service/redis-install.sh | bash
```


