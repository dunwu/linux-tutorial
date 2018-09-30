# Docker

<!-- TOC depthFrom:2 depthTo:2 -->

- [镜像(Images)](#镜像images)
- [容器(Container)](#容器container)
- [网络(Networks)](#网络networks)
- [仓管中心和仓库(Registry & Repository)](#仓管中心和仓库registry--repository)
- [Dockerfile](#dockerfile)
- [卷标(Volumes)](#卷标volumes)

<!-- /TOC -->

## 镜像(Images)

- [`docker image ls`](https://github.com/yeasy/docker_practice/blob/master/image/list.md) - 查看所有镜像。
- [`docker image rm`](https://github.com/yeasy/docker_practice/blob/master/image/rm.md) - 删除本地镜像。
- `docker import` - 从压缩文件中创建镜像。
- `docker export` - 导出既有容器。
- `docker build` - 从 Dockerfile 创建镜像。
- `docker commit` - 为容器创建镜像，如果容器正在运行则会临时暂停。
- `docker rmi` - 删除镜像。
- `docker load` - 通过 STDIN 从压缩包加载镜像，包括镜像和标签(images and tags) (0.7 起).
- `docker save` - 通过 STDOUT 保存镜像到压缩包，包括所有的父层，标签和版本(parent layers, tags & versions) (0.7 起).
- `docker history` - 查看镜像历史记录。
- `docker tag` - 给镜像命名打标(tags) (本地或者仓库)。

## 容器(Container)

### 生命周期

- `docker create` - 创建一个容器但是不启动。
- `docker rename` - 允许重命名容器。
- `docker run` - 在同一个操作中创建并启动一个容器。
- `docker rm` - 删除容器。
- `docker update` - 更新容器的资源限制。

### 启动和停止

- `docker start` - 启动容器。
- `docker stop` - 停止运行中的容器。
- `docker restart` - 停止之后再启动容器。
- `docker pause` - 暂停运行中的容器，将其 "冻结" 在当前状态。
- `docker unpause` - 结束容器暂停状态。
- `docker wait` - 阻塞，到运行中的容器停止为止。
- `docker kill` - 向运行中容器发送 SIGKILL 指令。
- `docker attach` - 链接到运行中容器。

### 信息

- `docker ps` - 查看运行中的所有容器。
- `docker logs` - 从容器中获取日志。(你也可以使用自定义日志驱动，不过在 1.10 中，它只支持 json-file 和 journald)
- `docker inspect` - 查看某个容器的所有信息(包括 IP 地址)。
- `docker events` - 从容器中获取事件(events)。
- `docker port` - 查看容器的公开端口。
- `docker top` - 查看容器中活动进程。
- `docker stats` - 查看容器的资源使用情况统计信息。
- `docker diff` - 查看容器的 FS 中有变化文件信息。

### 导入 / 导出

docker cp 在容器和本地文件系统之间复制文件或文件夹。
docker export 将容器的文件系统切换为压缩包(tarball archive stream)输出到 STDOUT。

### 执行命令

docker exec 在容器中执行命令。

## 网络(Networks)

### 生命周期

- `docker network create`
- `docker network rm`

### 信息

- `docker network ls`
- `docker network inspect`

### 链接

- `docker network connect`
- `docker network disconnect`

## 仓管中心和仓库(Registry & Repository)

- `docker login` - 登入仓管中心。
- `docker logout` - 登出仓管中心。
- `docker search` - 从仓管中心检索镜像。
- `docker pull` - 从仓管中心拉去镜像到本地。
- `docker push` - 从本地推送镜像到仓管中心。

## Dockerfile

- .dockerignore
- FROM 为其他指令设置基础镜像(Base Image)。
- MAINTAINER 为生成的镜像设置作者字段。
- RUN 在当前镜像的基础上生成一个新层并执行命令。
- CMD 设置容器默认执行命令。
- EXPOSE 告知 Docker 容器在运行时所要监听的网络端口。注意：并没有实际上将端口设置为可访问。
- ENV 设置环境变量。
- ADD 将文件，文件夹或者远程文件复制到容器中。缓存无效。尽量用 COPY 代替 ADD。
- COPY 将文件或文件夹复制到容器中。
- ENTRYPOINT 将一个容器设置为可执行。
- VOLUME 为外部挂载卷标或其他容器设置挂载点(mount point)。
- USER 设置执行 RUN / CMD / ENTRYPOINT 命令的用户名。
- WORKDIR 设置工作目录。
- ARG 定义编译时(build-time)变量。
- ONBUILD 添加触发指令，当该镜像被作为其他镜像的基础镜像时该指令会被触发。
- STOPSIGNAL 设置通过系统向容器发出退出指令。
- LABEL 将键值对元数据(key/value metadata)应用到你的镜像，容器，或者守护进程。

## 卷标(Volumes)

### 生命周期

- `docker volume create`
- `docker volume rm`

### 信息

- `docker volume ls`
- `docker volume inspect`
