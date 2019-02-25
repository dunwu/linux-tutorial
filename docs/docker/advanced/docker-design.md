<!-- TOC -->

- [Docker 的设计](#docker-%E7%9A%84%E8%AE%BE%E8%AE%A1)
    - [Docker 架构](#docker-%E6%9E%B6%E6%9E%84)
        - [Docker 守护进程（docker daemon）](#docker-%E5%AE%88%E6%8A%A4%E8%BF%9B%E7%A8%8B%EF%BC%88docker-daemon%EF%BC%89)
        - [Docker 客户端](#docker-%E5%AE%A2%E6%88%B7%E7%AB%AF)
        - [Docker 注册中心](#docker-%E6%B3%A8%E5%86%8C%E4%B8%AD%E5%BF%83)
        - [Docker 对象](#docker-%E5%AF%B9%E8%B1%A1)
            - [镜像](#%E9%95%9C%E5%83%8F)
            - [容器](#%E5%AE%B9%E5%99%A8)
            - [服务](#%E6%9C%8D%E5%8A%A1)
    - [底层技术](#%E5%BA%95%E5%B1%82%E6%8A%80%E6%9C%AF)
        - [命名空间](#%E5%91%BD%E5%90%8D%E7%A9%BA%E9%97%B4)
        - [控制组](#%E6%8E%A7%E5%88%B6%E7%BB%84)
        - [联合文件系统](#%E8%81%94%E5%90%88%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F)
        - [容器格式](#%E5%AE%B9%E5%99%A8%E6%A0%BC%E5%BC%8F)
    - [资料](#%E8%B5%84%E6%96%99)

<!-- /TOC -->

# Docker 的设计

## Docker 架构

Docker 使用 C/S 体系结构。Docker 守护进程，负责构建、运行和分发 Docker 容器；Docker 客户端与 Docker 守护进程通信。Docker 客户端和守护进程可以在同一个系统上运行，也可以将 Docker 客户端连接到远程 Docker 守护进程。Docker 客户端和守护进程使用 REST API，并通过 UNIX 套接字或网络接口进行通信。

<br><div align="center"><img src="https://docs.docker.com/engine/images/architecture.svg"/></div><br>

### Docker 守护进程（docker daemon）

Docker 守护进程（`dockerd`）监听 Docker API 请求并管理 Docker 对象（如镜像，容器，网络和卷）。守护进程还可以与其他守护进程通信来管理 Docker 服务。

### Docker 客户端

Docker 客户端（`docker`）是许多 Docker 用户与 Docker 进行交互的主要方式。当你使用诸如 `docker run` 之类的命令时，客户端将这些命令发送到 `dockerd`，`dockerd` 执行这些命令。 `docker` 命令使用 Docker API。 Docker 客户端可以与多个守护进程进行通信。

### Docker 注册中心

Docker 注册中心存储 Docker 镜像。Docker Hub 和 Docker Cloud 是任何人都可以使用的公共注册中心，并且 Docker 默认配置为在 Docker Hub 上查找镜像。你甚至可以运行你自己的私人注册中心。如果您使用 Docker Datacenter（DDC），它包括 Docker Trusted Registry（DTR）。

当您使用 `docker pull` 或 `docker run` 命令时，所需的镜像将从配置的注册中心中提取。当您使用 `docker push` 命令时，您的镜像将被推送到您配置的注册中心。

[Docker 商店](http://store.docker.com/) 允许您购买和销售 Docker 镜像或免费发布。例如，您可以购买包含来自软件供应商的应用程序或服务的 Docker 镜像，并使用该镜像将应用程序部署到您的测试，临时和生产环境中。您可以通过拉取新版本的镜像并重新部署容器来升级应用程序。

### Docker 对象

#### 镜像

镜像是一个只读模板，带有创建 Docker 容器的说明。通常，镜像基于另一个镜像，并具有一些额外的自定义功能。例如，您可以构建基于 ubuntu 镜像的镜像，但会安装 Apache Web 服务器和应用程序，以及使应用程序运行所需的配置细节。

您可能会创建自己的镜像，或者您可能只能使用其他人创建并在注册中心中发布的镜像。为了构建您自己的镜像，您可以使用简单的语法创建 `Dockerfile`，以定义创建镜像并运行所需的步骤。  `Dockerfile` 中的每条指令都会在镜像中创建一个图层。当您更改 `Dockerfile` 并重建镜像时，只重建那些已更改的图层。与其他虚拟化技术相比，这是使镜像轻量，小巧，快速的一部分。

#### 容器

容器是镜像的可运行实例。您可以使用 Docker API 或 CLI 创建、启动、停止、移动或删除容器。您可以将容器连接到一个或多个网络，将存储器连接到它，甚至可以根据其当前状态创建新镜像。

默认情况下，容器与其他容器及其主机相对隔离。您可以控制容器的网络、存储或其他底层子系统与其他容器或主机的隔离程度。

容器由其镜像以及您在创建或启动时提供给它的任何配置选项来定义。当一个容器被移除时，其未被存储在永久存储器中的状态将消失。

#### 服务

通过服务，您可以跨多个 Docker 守护进程扩展容器，这些守护进程可以作为一个群组与多个管理人员、工作人员一起工作。集群中的每个成员都是 Docker 守护进程，守护进程都使用 Docker API 进行通信。服务允许您定义所需的状态，例如在任何给定时间必须可用的服务的副本数量。默认情况下，该服务在所有工作节点之间进行负载平衡。对于消费者来说，Docker 服务似乎是一个单一的应用程序。Docker 引擎在 Docker 1.12 及更高版本中支持集群模式。

## 底层技术

Docker 使用 Go 编写，利用 Linux 内核的几个特性来提供其功能。

### 命名空间

Docker 使用名为 `namespaces` 的技术来提供独立工作空间（即容器）。当你运行一个容器时，Docker 会为该容器创建一组命名空间。

这些命名空间提供了一个隔离层。容器的每个方面都在单独的命名空间中运行，并且其访问权限限于该命名空间。

Docker 引擎在 Linux 上使用如下的命名空间：

* `pid` 命名空间：进程隔离（PID：进程ID）。
* `net` 命名空间：管理网络接口（NET：网络）。
* `ipc` 命名空间：管理对IPC资源的访问（IPC：InterProcess Communication）。
* `mnt` 命名空间：管理文件系统挂载点（MNT：挂载）。
* `uts` 命名空间：隔离内核和版本标识符。 （UTS：Unix分时系统）。

### 控制组

Linux 上的 Docker Engine 也依赖于另一种称为控制组（`cgroups`）的技术。 cgroup 将应用程序限制为一组特定的资源。控制组允许 Docker 引擎将可用硬件资源共享给容器，并可选地强制实施限制和约束。例如，您可以限制可用于特定容器的内存。

### 联合文件系统

联合文件系统（UnionFS）是通过创建图层进行操作的文件系统，这使它们非常轻巧和快速。 Docker 引擎使用 UnionFS 为容器提供构建块。Docker 引擎可以使用多种 UnionFS 变体，包括 AUFS，btrfs，vfs 和 DeviceMapper。

### 容器格式

Docker 引擎将命名空间，控制组和 UnionFS 组合成一个名为容器格式的包装器。默认的容器格式是`libcontainer`。将来，Docker 可以通过与诸如 BSD Jails 或 Solaris Zones 等技术集成来支持其他容器格式。

## 资料

* https://docs.docker.com/engine/docker-overview/
