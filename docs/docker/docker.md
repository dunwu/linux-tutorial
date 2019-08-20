# Docker 应用指南

## 简介

### Docker 是什么

> **Docker 属于 Linux 容器的一种封装，提供简单易用的容器使用接口。**

Docker 是目前最流行的 Linux 容器解决方案。

Docker 将应用程序与该程序的依赖，打包在一个文件里面。运行这个文件，就会生成一个虚拟容器。程序在这个虚拟容器里运行，就好像在真实的物理机上运行一样。有了 Docker，就不用担心环境问题。

总体来说，Docker 的接口相当简单，用户可以方便地创建和使用容器，把自己的应用放入容器。容器还可以进行版本管理、复制、分享、修改，就像管理普通的代码一样。

### Docker 的用途

Docker 的主要用途，目前有三大类。

- **提供一次性的环境** - 比如，本地测试他人的软件、持续集成的时候提供单元测试和构建的环境。
- **提供弹性的云服务** - 因为 Docker 容器可以随开随关，很适合动态扩容和缩容。
- **组建微服务架构** - 通过多个容器，一台机器可以跑多个服务，因此在本机就可以模拟出微服务架构。

### 虚拟机和 Docker

虚拟机（virtual machine）就是带环境安装的一种解决方案。它可以在一种操作系统里面运行另一种操作系统，比如在 Windows 系统里面运行 Linux 系统。应用程序对此毫无感知，因为虚拟机看上去跟真实系统一模一样，而对于底层系统来说，虚拟机就是一个普通文件，不需要了就删掉，对其他部分毫无影响。

**资源占用多** - 虚拟机会独占一部分内存和硬盘空间。它运行的时候，其他程序就不能使用这些资源了。哪怕虚拟机里面的应用程序，真正使用的内存只有 1MB，虚拟机依然需要几百 MB 的内存才能运行。

**冗余步骤多** - 虚拟机是完整的操作系统，一些系统级别的操作步骤，往往无法跳过，比如用户登录。

**启动慢** - 启动操作系统需要多久，启动虚拟机就需要多久。可能要等几分钟，应用程序才能真正运行。

<br><div align="center"><img src="http://dunwu.test.upcdn.net/images/os/docker/containers-and-vm.png!zp"/></div><br>

### Docker 平台

Docker 提供了被称为容器的松散隔离环境，在环境中可以打包和运行应用程序。隔离和安全性允许您在给定主机上同时运行多个容器。容器是轻量级的，因为它们不需要管理程序的额外负载，而是直接在主机的内核中运行。这意味着您可以在给定的硬件组合上运行更多容器，而不是使用虚拟机。你甚至可以在实际上是虚拟机的主机中运行 Docker 容器！

Docker 提供工具和平台来管理容器的生命周期：

- 使用容器开发您的应用程序及其支持组件。
- 容器成为分发和测试你的应用程序的单元。
- 准备好后，将您的应用程序部署到生产环境中，作为容器或协调服务。无论您的生产环境是本地数据中心，云提供商还是两者的混合，这都是一样的。

## 核心概念

### 引擎

Docker 引擎是一个 C/S 架构的应用，它有这些主要的组件：

服务器是一个长期运行的程序，被称为守护进程。

REST API 指定程序可用于与守护进程进行通信并指示其执行操作的接口。

命令行客户端。

<br><div align="center"><img src="https://docs.docker.com/engine/images/engine-components-flow.png"/></div><br>

CLI 使用 Docker REST API 通过脚本或直接 CLI 命令来控制 Docker 守护进程或与其进行交互。许多其他 Docker 应用程序使用底层的 API 和 CLI。

守护进程创建并管理 Docker 对象，如镜像，容器，网络和卷。

### 镜像

我们都知道，操作系统分为内核和用户空间。对于 Linux 而言，内核启动后，会挂载 root 文件系统为其提供用户空间支持。而 Docker 镜像（Image），就相当于是一个 root 文件系统。比如官方镜像 ubuntu:18.04 就包含了完整的一套 Ubuntu 18.04 最小系统的 root 文件系统。

Docker 镜像是一个特殊的文件系统，除了提供容器运行时所需的程序、库、资源、配置等文件外，还包含了一些为运行时准备的一些配置参数（如匿名卷、环境变量、用户等）。镜像不包含任何动态数据，其内容在构建之后也不会被改变。

**分层存储**

因为镜像包含操作系统完整的 root 文件系统，其体积往往是庞大的，因此在 Docker 设计时，就充分利用 Union FS 的技术，将其设计为分层存储的架构。所以严格来说，镜像并非是像一个 ISO 那样的打包文件，镜像只是一个虚拟的概念，其实际体现并非由一个文件组成，而是由一组文件系统组成，或者说，由多层文件系统联合组成。

镜像构建时，会一层层构建，前一层是后一层的基础。每一层构建完就不会再发生改变，后一层上的任何改变只发生在自己这一层。比如，删除前一层文件的操作，实际不是真的删除前一层的文件，而是仅在当前层标记为该文件已删除。在最终容器运行的时候，虽然不会看到这个文件，但是实际上该文件会一直跟随镜像。因此，在构建镜像的时候，需要额外小心，每一层尽量只包含该层需要添加的东西，任何额外的东西应该在该层构建结束前清理掉。

分层存储的特征还使得镜像的复用、定制变的更为容易。甚至可以用之前构建好的镜像作为基础层，然后进一步添加新的层，以定制自己所需的内容，构建新的镜像。

### 容器

镜像（`Image`）和容器（`Container`）的关系，就像是面向对象程序设计中的 `类` 和 `实例` 一样，镜像是静态的定义，容器是镜像运行时的实体。容器可以被创建、启动、停止、删除、暂停等。

容器的实质是进程，但与直接在宿主执行的进程不同，容器进程运行于属于自己的独立的 [命名空间](https://en.wikipedia.org/wiki/Linux_namespaces)。因此容器可以拥有自己的 `root` 文件系统、自己的网络配置、自己的进程空间，甚至自己的用户 ID 空间。容器内的进程是运行在一个隔离的环境里，使用起来，就好像是在一个独立于宿主的系统下操作一样。这种特性使得容器封装的应用比直接在宿主运行更加安全。也因为这种隔离的特性，很多人初学 Docker 时常常会混淆容器和虚拟机。

前面讲过镜像使用的是分层存储，容器也是如此。每一个容器运行时，是以镜像为基础层，在其上创建一个当前容器的存储层，我们可以称这个为容器运行时读写而准备的存储层为**容器存储层**。

容器存储层的生存周期和容器一样，容器消亡时，容器存储层也随之消亡。因此，任何保存于容器存储层的信息都会随容器删除而丢失。

按照 Docker 最佳实践的要求，容器不应该向其存储层内写入任何数据，容器存储层要保持无状态化。所有的文件写入操作，都应该使用 [数据卷（Volume）](https://yeasy.gitbooks.io/docker_practice/content/data_management/volume.html)、或者绑定宿主目录，在这些位置的读写会跳过容器存储层，直接对宿主（或网络存储）发生读写，其性能和稳定性更高。

数据卷的生存周期独立于容器，容器消亡，数据卷不会消亡。因此，使用数据卷后，容器删除或者重新运行之后，数据却不会丢失。

### 仓库

镜像构建完成后，可以很容易的在当前宿主机上运行，但是，如果需要在其它服务器上使用这个镜像，我们就需要一个集中的存储、分发镜像的服务，[Docker Registry](https://yeasy.gitbooks.io/docker_practice/content/repository/registry.html) 就是这样的服务。

一个 **Docker Registry** 中可以包含多个**仓库**（`Repository`）；每个仓库可以包含多个**标签**（`Tag`）；每个标签对应一个镜像。

通常，一个仓库会包含同一个软件不同版本的镜像，而标签就常用于对应该软件的各个版本。我们可以通过 `<仓库名>:<标签>` 的格式来指定具体是这个软件哪个版本的镜像。如果不给出标签，将以 `latest` 作为默认标签。

以 [Ubuntu 镜像](https://store.docker.com/images/ubuntu) 为例，`ubuntu` 是仓库的名字，其内包含有不同的版本标签，如，`16.04`, `18.04`。我们可以通过 `ubuntu:14.04`，或者 `ubuntu:18.04` 来具体指定所需哪个版本的镜像。如果忽略了标签，比如 `ubuntu`，那将视为 `ubuntu:latest`。

仓库名经常以 _两段式路径_ 形式出现，比如 `jwilder/nginx-proxy`，前者往往意味着 Docker Registry 多用户环境下的用户名，后者则往往是对应的软件名。但这并非绝对，取决于所使用的具体 Docker Registry 的软件或服务。

## 安装配置

不同操作系统环境下安装 Docker 的方式有所不同，详情可以参：

- [Docker 官方安装指南](https://docs.docker.com/install/)
- [安装 Docker（中文）](https://docker_practice.gitee.io/install/)

国内访问 Docker 比较慢，如果需要提速，可以参考 [镜像加速器](https://docker_practice.gitee.io/install/mirror.html)

安装完成后，运行下面的命令，验证是否安装成功。

- `docker version`
- `docker info`

Docker 需要用户具有 sudo 权限，为了避免每次命令都输入`sudo`，可以把用户加入 Docker 用户组（[官方文档](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user)）。

```bash
$ sudo usermod -aG docker $USER
```

Docker 是服务器----客户端架构。命令行运行`docker`命令的时候，需要本机有 Docker 服务。如果这项服务没有启动，可以用下面的命令启动（[官方文档](https://docs.docker.com/config/daemon/systemd/)）。

```bash
# service 命令的用法
$ sudo service docker start

# systemctl 命令的用法
$ sudo systemctl start docker
```

## 参考资料

- Docker 官方资源
  - [Docker 官网](http://www.docker.com)
  - [Docker Github](https://github.com/moby/moby)
  - [Docker 官方文档](https://docs.docker.com/)
  - [Docker Hub](https://hub.docker.com/)
  - [Docker 开源](https://www.docker.com/community/open-source)
- 资源整理
  - [Awesome Docker](https://github.com/veggiemonk/awesome-docker)
- Docker 中文资源
  - [Docker 中文网站](https://www.docker-cn.com/)
  - [Docker 安装手册](https://docs.docker-cn.com/engine/installation/)
  - [Docker — 从入门到实践](https://docker_practice.gitee.io/)
- Docker 国内镜像
  - [时速云镜像仓库](https://hub.tenxcloud.com/)
  - [网易云镜像服务](https://c.163.com/hub#/m/library/)
  - [DaoCloud 镜像市场](https://hub.daocloud.io/)
  - [阿里云镜像库](https://cr.console.aliyun.com/)
- 文章
  - [Docker 入门教程](http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html)
  - [Docker Cheat Sheet](https://github.com/wsargent/docker-cheat-sheet/tree/master/zh-cn)
