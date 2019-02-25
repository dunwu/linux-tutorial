# Docker 之 Hello World

## 前提

确保你的环境上已经成功安装 Docker。

## Hello World 实例

1. 使用 `docker version` 命令确保你的环境已成功安装 Docker。

```
# docker version
Client:
 Version:         1.13.1
 API version:     1.26
 Package version: <unknown>
 Go version:      go1.8.3
 Git commit:      774336d/1.13.1
 Built:           Wed Mar  7 17:06:16 2018
 OS/Arch:         linux/amd64

Server:
 Version:         1.13.1
 API version:     1.26 (minimum version 1.12)
 Package version: <unknown>
 Go version:      go1.8.3
 Git commit:      774336d/1.13.1
 Built:           Wed Mar  7 17:06:16 2018
 OS/Arch:         linux/amd64
 Experimental:    false
```

2. 使用 `docker run` 命令运行 Hello World 镜像。

```
docker run hello-world

Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
ca4f61b1923c: Pull complete
Digest: sha256:ca0eeb6fb05351dfc8759c20733c91def84cb8007aa89a5bf606bc8b315b9fc7
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

3. 使用 `docker image ls`命令查看镜像

```
docker image ls
REPOSITORY                  TAG                 IMAGE ID            CREATED             SIZE
docker.io/maven             latest              76c9ab5df55b        7 days ago          737 MB
docker.io/python            2.7-slim            5541369755c4        13 days ago         139 MB
docker.io/hello-world       latest              f2a91732366c        4 months ago        1.85 kB
docker.io/java              8-jre               e44d62cf8862        14 months ago       311 MB
docker.io/training/webapp   latest              6fae60ef3446        2 years ago         349 MB
```

4. 使用 `docker container ls --all` 命令查看容器

如果查看正在运行的容器，不需要添加 `--all` 参数。

```
docker container ls --all
CONTAINER ID        IMAGE                   COMMAND             CREATED             STATUS                     PORTS               NAMES
a661d957c6fa        hello-world             "/hello"            2 minutes ago       Exited (0) 2 minutes ago                       mystifying_swartz
3098f24a1064        docker.io/hello-world   "/hello"            6 minutes ago       Exited (0) 6 minutes ago                       sad_yonath
4c98c4f18a39        hello-world             "/hello"            8 minutes ago       Exited (0) 8 minutes ago                       admiring_banach
```
