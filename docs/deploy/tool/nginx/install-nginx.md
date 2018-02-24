# Nginx 安装

## 安装方法

### 安装编译工具及库文件

```
yum -y install make zlib zlib-devel gcc-c++ libtool  openssl openssl-devel
```

### 先安装 PCRE

安装步骤如下：

（1）下载解压到本地

进入官网下载地址：https://sourceforge.net/projects/pcre/files/pcre/ ，选择合适的版本下载。

我选择的是 8.35 版本：http://downloads.sourceforge.net/project/pcre/pcre/8.35/pcre-8.35.tar.gz

```
wget -O /opt/software/pcre/pcre-8.35.tar.gz http://downloads.sourceforge.net/project/pcre/pcre/8.35/pcre-8.35.tar.gz
cd /opt/software/pcre
tar zxvf pcre-8.35.tar.gz
```

（2）编译安装

执行以下命令：

```
cd /opt/software/pcre/pcre-8.35
./configure
make && make install
```

（3）检验是否安装成功

执行 `pcre-config --version` 命令。

### 安装 Nginx

安装步骤如下：

（1）下载解压到本地

进入官网下载地址：http://nginx.org/en/download.html ，选择合适的版本下载。

我选择的是 1.12.2 版本：http://downloads.sourceforge.net/project/pcre/pcre/8.35/pcre-8.35.tar.gz

```
wget -O /opt/software/nginx/nginx-1.12.2.tar.gz http://nginx.org/download/nginx-1.12.2.tar.gz
cd /opt/software/nginx
tar zxvf nginx-1.12.2.tar.gz
```

（2）编译安装

执行以下命令：

```
cd /opt/software/nginx/nginx-1.12.2
./configure --with-http_stub_status_module --with-http_ssl_module --with-pcre=/opt/software/pcre/pcre-8.35
```

（3）检验是否安装成功

执行 `nginx -v` 命令。

### 启动 Nginx

安装成功后，直接执行 `nginx` 命令即可启动 nginx。

启动后，访问站点：

![nginx-install.png](nginx-install.png)

## 脚本

| [安装脚本](https://github.com/dunwu/linux/tree/master/codes/deploy/tool/nginx) |