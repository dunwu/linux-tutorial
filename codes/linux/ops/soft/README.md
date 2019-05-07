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

- 脚本会下载解压 maven `3.6.0` 到 `/opt/maven` 路径下。
- 备份并替换 `settings.xml`，使用 aliyun 镜像加速 maven。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/maven-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/maven-install.sh | bash
```

## Node.js 安装

说明：

脚本会先安装 nvm（nodejs 版本管理器），并通过 nvm 安装 nodejs `10.15.2`。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/nodejs-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/soft/nodejs-install.sh | bash
```

## Redis 安装

说明：

下载 redis  `5.0.4` 并解压安装到 `/opt/redis` 路径下。

使用方法：

执行以下任意命令即可执行安装脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/service/redis-install.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/service/redis-install.sh | bash
```


