# Docker 镜像使用

## 列出镜像列表

`docker images` 命令可用来列出本地主机上的镜像。

```
# docker images
REPOSITORY                  TAG                 IMAGE ID            CREATED             SIZE
docker.io/maven             latest              76c9ab5df55b        7 days ago          737 MB
friendlyhello               latest              0c6d91e71733        8 days ago          148 MB
<none>                      <none>              d1eab98cf3bd        11 days ago         311 MB
docker.io/python            2.7-slim            5541369755c4        13 days ago         139 MB
docker.io/hello-world       latest              f2a91732366c        4 months ago        1.85 kB
docker.io/java              8-jre               e44d62cf8862        14 months ago       311 MB
docker.io/training/webapp   latest              6fae60ef3446        2 years ago         349 MB
```

选项说明：

* REPOSITORY：表示镜像的仓库源
* TAG：镜像的标签
* IMAGE ID：镜像ID
* CREATED：镜像创建时间
* SIZE：镜像大小

同一仓库源可以有多个 TAG，代表这个仓库源的不同个版本，如ubuntu仓库源里，有15.10、14.04等多个不同的版本，我们使用 REPOSITORY:TAG 来定义不同的镜像。

如果要使用版本为14.04的ubuntu系统镜像来运行容器时，命令如下：

```
docker run -t -i ubuntu:14.04 /bin/bash 
```

如果你不指定一个镜像的版本标签，例如你只使用 ubuntu，docker 将默认使用 ubuntu:latest 镜像。

## 查找镜像

可以从 Docker Hub 网站来搜索镜像，Docker Hub 网址为： https://hub.docker.com/

我们也可以使用 `docker search` 命令来搜索镜像。比如我们需要一个httpd的镜像来作为我们的web服务。我们可以通过 docker search 命令搜索 httpd 来寻找适合我们的镜像。

```
docker search httpd
```

## 拉取镜像

当我们在本地主机上使用一个不存在的镜像时 Docker 就会自动下载这个镜像。如果我们想预先下载这个镜像，我们可以使用 `docker pull` 命令来下载它。

```
# docker pull ubuntu:13.10
13.10: Pulling from library/ubuntu
6599cadaf950: Pull complete 
23eda618d451: Pull complete 
f0be3084efe9: Pull complete 
52de432f084b: Pull complete 
a3ed95caeb02: Pull complete 
Digest: sha256:15b79a6654811c8d992ebacdfbd5152fcf3d165e374e264076aa435214a947a3
Status: Downloaded newer image for ubuntu:13.10
```

下载完成后，我们可以直接使用这个镜像来运行容器。

## 创建镜像

