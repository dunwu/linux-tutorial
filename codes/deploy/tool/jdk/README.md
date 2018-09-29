# 安装 JDK

## linux 安装JDK通用脚本

使用方法：

```sh
wget --no-check-certificate --no-cookies https://raw.githubusercontent.com/dunwu/linux/master/codes/deploy/tool/jdk/install-jdk8.sh
chmod -R 777 install-jdk8.sh
./install-jdk8.sh
```

脚本会下载解压 jdk8 到 `/opt/java` 路径下。

## Centos 安装JDK脚本

使用方法：

```sh
wget --no-check-certificate --no-cookies https://raw.githubusercontent.com/dunwu/linux/master/codes/deploy/tool/jdk/install-jdk8-by-yum.sh
chmod -R 777 install-jdk8-by-yum.sh
./install-jdk8-by-yum.sh
```
脚本会下载解压 jdk8 到 `/usr/lib/jvm/java` 路径下。
