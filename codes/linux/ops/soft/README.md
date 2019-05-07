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

## Maven 安装

说明：

- 脚本会下载解压 maven3 到 `/opt/maven` 路径下。
- 备份并替换 `settings.xml`，使用 aliyun 镜像加速 maven。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/maven-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/maven-install.sh | bash
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


