# Docker 术语

* **Docker 镜像(Images)**：Docker 镜像是用于创建 Docker 容器的模板。
* **Docker 容器(Container)**：容器是独立运行的一个或一组应用。
* **Docker 客户端(Client)**：Docker 客户端通过命令行或者其他工具使用 Docker API (https://docs.docker.com/reference/api/docker_remote_api) 与 Docker 的守护进程通信。
* **Docker 主机(Host)**：一个物理或者虚拟的机器用于执行 Docker 守护进程和容器。
* **Docker 仓库(Registry)**：Docker 仓库用来保存镜像，可以理解为代码控制中的代码仓库。：Docker Hub(https://hub.docker.com) 提供了庞大的镜像集合供使用。
* **Docker Machine**：Docker Machine是一个简化Docker安装的命令行工具，通过一个简单的命令行即可在相应的平台上安装Docker，比如VirtualBox、 Digital Ocean、Microsoft Azure。
* **Docker Machine**：Dockerfile是一个文本文档，其中包含您通常为了构建Docker镜像而手动执行的所有命令。 Docker可以通过从Dockerfile读取指令自动构建映像。
