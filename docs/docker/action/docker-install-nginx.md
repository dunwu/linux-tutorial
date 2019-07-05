# Docker 安装 Nginx

> 实测环境：Centos

## 查看可用镜像

执行 `docker search nginx` 命令查看可用镜像：

```docker
# docker search nginx
INDEX       NAME                                                             DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
docker.io   docker.io/nginx                                                  Official build of Nginx.                        8272      [OK]       
docker.io   docker.io/jwilder/nginx-proxy                                    Automated Nginx reverse proxy for docker c...   1300                 [OK]
docker.io   docker.io/richarvey/nginx-php-fpm                                Container running Nginx + PHP-FPM capable ...   540                  [OK]
docker.io   docker.io/jrcs/letsencrypt-nginx-proxy-companion                 LetsEncrypt container to use with nginx as...   336                  [OK]
...
```

## 选择下载镜像

执行 `docker pull nginx` 命令下载镜像

## 运行镜像

```
docker run -p 80:80 --name mynginx -d nginx
```

