# Docker 入门

<!-- TOC depthFrom:2 depthTo:3 -->

- [Hello World 示例](#hello-world-示例)

<!-- /TOC -->

## Hello World 示例

（1）拉取镜像

```
docker image pull library/hello-world
```

`docker image pull` 是抓取 image 文件的命令。`library/hello-world` 是 image 文件在仓库里面的位置，其中 `library` 是 image 文件所在的组，`hello-world` 是 image 文件的名字。

由于 Docker 官方提供的 image 文件，都放在[`library`](https://hub.docker.com/r/library/)组里面，所以它的是默认组，可以省略。因此，上面的命令可以写成下面这样。

```
docker image pull hello-world
```

（2）查看镜像

```sh
~ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              4ab4c602aa5e        3 months ago        1.84kB
```

（3）运行镜像

```
docker container run hello-world
```

`docker container run` 命令会从 image 文件，生成一个正在运行的容器实例。

注意，`docker container run` 命令具有自动抓取 image 文件的功能。如果发现本地没有指定的 image 文件，就会从仓库自动抓取。因此，前面的 `docker image pull` 命令并不是必需的步骤。

如果运行成功，你会在屏幕上读到下面的输出。
