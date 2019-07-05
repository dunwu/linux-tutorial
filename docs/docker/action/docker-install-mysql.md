# Docker 安装 MySQL

> 实测环境：Centos

## 查看可下载镜像

```docker
# docker search mysql
INDEX       NAME                                                             DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
docker.io   docker.io/mysql                                                  MySQL is a widely used, open-source relati...   5757      [OK]       
docker.io   docker.io/mariadb                                                MariaDB is a community-developed fork of M...   1863      [OK]       
docker.io   docker.io/mysql/mysql-server                                     Optimized MySQL Server Docker images. Crea...   397                  [OK]
...
```

## 选择下载官方镜像

比如，我想下载最新版本，则执行如下命令：

```docker
docker pull mysql
```

## 使用镜像

```docker
docker run -p 3306:3306 --name mysql -v /opt/docker_v/mysql/conf:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=123456 -d mysql
```

## 资源

* https://hub.docker.com/_/mysql/
