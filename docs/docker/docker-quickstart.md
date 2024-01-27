# Docker 快速入门

<!-- TOC depthFrom:2 depthTo:2 -->

- [一、Docker 的简介](#一docker-的简介)
- [二、Docker 的运维](#二docker-的运维)
- [三、hello world 实例](#三hello-world-实例)
- [四、制作 Docker 容器](#四制作-docker-容器)
- [参考资料](#参考资料)

<!-- /TOC -->

## 一、Docker 的简介

### 什么是 Docker

> **Docker 属于 Linux 容器的一种封装，提供简单易用的容器使用接口。**

它是目前最流行的 Linux 容器解决方案。

Docker 将应用程序与该程序的依赖，打包在一个文件里面。运行这个文件，就会生成一个虚拟容器。程序在这个虚拟容器里运行，就好像在真实的物理机上运行一样。有了 Docker，就不用担心环境问题。

总体来说，Docker 的接口相当简单，用户可以方便地创建和使用容器，把自己的应用放入容器。容器还可以进行版本管理、复制、分享、修改，就像管理普通的代码一样。

### 为什么需要 Docker

- **更高效的利用系统资源** - 由于容器不需要进行硬件虚拟以及运行完整操作系统等额外开销，`Docker` 对系统资源的利用率更高。无论是应用执行速度、内存损耗或者文件存储速度，都要比传统虚拟机技术更高效。因此，相比虚拟机技术，一个相同配置的主机，往往可以运行更多数量的应用。
- **更快速的启动时间** - 传统的虚拟机技术启动应用服务往往需要数分钟，而 `Docker` 容器应用，由于直接运行于宿主内核，无需启动完整的操作系统，因此可以做到秒级、甚至毫秒级的启动时间。大大的节约了开发、测试、部署的时间。
- **一致的运行环境** - 开发过程中一个常见的问题是环境一致性问题。由于开发环境、测试环境、生产环境不一致，导致有些 bug 并未在开发过程中被发现。而 `Docker` 的镜像提供了除内核外完整的运行时环境，确保了应用运行环境一致性，从而不会再出现 _「这段代码在我机器上没问题啊」_ 这类问题。
- **持续交付和部署** - 对开发和运维（[DevOps](https://zh.wikipedia.org/wiki/DevOps)）人员来说，最希望的就是一次创建或配置，可以在任意地方正常运行。使用 `Docker` 可以通过定制应用镜像来实现持续集成、持续交付、部署。开发人员可以通过 [Dockerfile](https://yeasy.gitbooks.io/docker_practice/image/dockerfile) 来进行镜像构建，并结合 [持续集成(Continuous Integration)](https://en.wikipedia.org/wiki/Continuous_integration) 系统进行集成测试，而运维人员则可以直接在生产环境中快速部署该镜像，甚至结合 [持续部署(Continuous Delivery/Deployment)](https://en.wikipedia.org/wiki/Continuous_delivery) 系统进行自动部署。而且使用 [`Dockerfile`](https://yeasy.gitbooks.io/docker_practice/image/build.html) 使镜像构建透明化，不仅仅开发团队可以理解应用运行环境，也方便运维团队理解应用运行所需条件，帮助更好的生产环境中部署该镜像。
- **更轻松的迁移** - 由于 `Docker` 确保了执行环境的一致性，使得应用的迁移更加容易。`Docker` 可以在很多平台上运行，无论是物理机、虚拟机、公有云、私有云，甚至是笔记本，其运行结果是一致的。因此用户可以很轻易的将在一个平台上运行的应用，迁移到另一个平台上，而不用担心运行环境的变化导致应用无法正常运行的情况。
- **更轻松的维护和扩展** - `Docker` 使用的分层存储以及镜像的技术，使得应用重复部分的复用更为容易，也使得应用的维护更新更加简单，基于基础镜像进一步扩展镜像也变得非常简单。此外，`Docker` 团队同各个开源项目团队一起维护了一大批高质量的 [官方镜像](https://hub.docker.com/search/?type=image&image_filter=official)，既可以直接在生产环境使用，又可以作为基础进一步定制，大大的降低了应用服务的镜像制作成本。

![img](https://raw.githubusercontent.com/dunwu/images/master/cs/os/docker/containers-and-vm.png)

### Docker 的主要用途

Docker 提供了被称为容器的松散隔离环境，在环境中可以打包和运行应用程序。隔离和安全性允许您在给定主机上同时运行多个容器。容器是轻量级的，因为它们不需要管理程序的额外负载，而是直接在主机的内核中运行。这意味着您可以在给定的硬件组合上运行更多容器，而不是使用虚拟机。你甚至可以在实际上是虚拟机的主机中运行 Docker 容器！

Docker 的主要用途，目前有三大类。

- **提供一次性的环境。**比如，本地测试他人的软件、持续集成的时候提供单元测试和构建的环境。
- **提供弹性的云服务。**因为 Docker 容器可以随开随关，很适合动态扩容和缩容。
- **组建微服务架构。**通过多个容器，一台机器可以跑多个服务，因此在本机就可以模拟出微服务架构。

### Docker 的核心概念

#### 镜像

Docker 把应用程序及其依赖，打包在镜像（Image）文件里面。

我们都知道，操作系统分为内核和用户空间。对于 Linux 而言，内核启动后，会挂载 root 文件系统为其提供用户空间支持。而 Docker 镜像（Image），就相当于是一个 root 文件系统。比如官方镜像 ubuntu:18.04 就包含了完整的一套 Ubuntu 18.04 最小系统的 root 文件系统。

Docker 镜像是一个特殊的文件系统，除了提供容器运行时所需的程序、库、资源、配置等文件外，还包含了一些为运行时准备的一些配置参数（如匿名卷、环境变量、用户等）。镜像不包含任何动态数据，其内容在构建之后也不会被改变。

**分层存储**

因为镜像包含操作系统完整的 root 文件系统，其体积往往是庞大的，因此在 Docker 设计时，就充分利用 Union FS 的技术，将其设计为分层存储的架构。所以严格来说，镜像并非是像一个 ISO 那样的打包文件，镜像只是一个虚拟的概念，其实际体现并非由一个文件组成，而是由一组文件系统组成，或者说，由多层文件系统联合组成。

镜像构建时，会一层层构建，前一层是后一层的基础。每一层构建完就不会再发生改变，后一层上的任何改变只发生在自己这一层。比如，删除前一层文件的操作，实际不是真的删除前一层的文件，而是仅在当前层标记为该文件已删除。在最终容器运行的时候，虽然不会看到这个文件，但是实际上该文件会一直跟随镜像。因此，在构建镜像的时候，需要额外小心，每一层尽量只包含该层需要添加的东西，任何额外的东西应该在该层构建结束前清理掉。

分层存储的特征还使得镜像的复用、定制变的更为容易。甚至可以用之前构建好的镜像作为基础层，然后进一步添加新的层，以定制自己所需的内容，构建新的镜像。

#### 容器

镜像（`Image`）和容器（`Container`）的关系，就像是面向对象程序设计中的 `类` 和 `实例` 一样，镜像是静态的定义，容器是镜像运行时的实体。容器可以被创建、启动、停止、删除、暂停等。

容器的实质是进程，但与直接在宿主执行的进程不同，容器进程运行于属于自己的独立的 [命名空间](https://en.wikipedia.org/wiki/Linux_namespaces)。因此容器可以拥有自己的 `root` 文件系统、自己的网络配置、自己的进程空间，甚至自己的用户 ID 空间。容器内的进程是运行在一个隔离的环境里，使用起来，就好像是在一个独立于宿主的系统下操作一样。这种特性使得容器封装的应用比直接在宿主运行更加安全。也因为这种隔离的特性，很多人初学 Docker 时常常会混淆容器和虚拟机。

前面讲过镜像使用的是分层存储，容器也是如此。每一个容器运行时，是以镜像为基础层，在其上创建一个当前容器的存储层，我们可以称这个为容器运行时读写而准备的存储层为**容器存储层**。

容器存储层的生存周期和容器一样，容器消亡时，容器存储层也随之消亡。因此，任何保存于容器存储层的信息都会随容器删除而丢失。

按照 Docker 最佳实践的要求，容器不应该向其存储层内写入任何数据，容器存储层要保持无状态化。所有的文件写入操作，都应该使用 [数据卷（Volume）](https://yeasy.gitbooks.io/docker_practice/content/data_management/volume.html)、或者绑定宿主目录，在这些位置的读写会跳过容器存储层，直接对宿主（或网络存储）发生读写，其性能和稳定性更高。

数据卷的生存周期独立于容器，容器消亡，数据卷不会消亡。因此，使用数据卷后，容器删除或者重新运行之后，数据却不会丢失。

#### 仓库

镜像构建完成后，可以很容易的在当前宿主机上运行，但是，如果需要在其它服务器上使用这个镜像，我们就需要一个集中的存储、分发镜像的服务，[Docker Registry](https://yeasy.gitbooks.io/docker_practice/content/repository/registry.html) 就是这样的服务。

一个 **Docker Registry** 中可以包含多个**仓库**（`Repository`）；每个仓库可以包含多个**标签**（`Tag`）；每个标签对应一个镜像。

通常，一个仓库会包含同一个软件不同版本的镜像，而标签就常用于对应该软件的各个版本。我们可以通过 `<仓库名>:<标签>` 的格式来指定具体是这个软件哪个版本的镜像。如果不给出标签，将以 `latest` 作为默认标签。

以 [Ubuntu 镜像](https://store.docker.com/images/ubuntu) 为例，`ubuntu` 是仓库的名字，其内包含有不同的版本标签，如，`16.04`, `18.04`。我们可以通过 `ubuntu:14.04`，或者 `ubuntu:18.04` 来具体指定所需哪个版本的镜像。如果忽略了标签，比如 `ubuntu`，那将视为 `ubuntu:latest`。

仓库名经常以 _两段式路径_ 形式出现，比如 `jwilder/nginx-proxy`，前者往往意味着 Docker Registry 多用户环境下的用户名，后者则往往是对应的软件名。但这并非绝对，取决于所使用的具体 Docker Registry 的软件或服务。

## 二、Docker 的运维

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

## 三、Hello World 实例

下面，我们通过最简单的 image 文件"[hello world"](https://hub.docker.com/r/library/hello-world/)，感受一下 Docker。

需要说明的是，国内连接 Docker 的官方仓库很慢，还会断线，需要将默认仓库改成国内的镜像网站，具体的修改方法在[下一篇文章](http://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html)的第一节。有需要的朋友，可以先看一下。

首先，运行下面的命令，将 image 文件从仓库抓取到本地。

> ```bash
> $ docker image pull library/hello-world
> ```

上面代码中，`docker image pull`是抓取 image 文件的命令。`library/hello-world`是 image 文件在仓库里面的位置，其中`library`是 image 文件所在的组，`hello-world`是 image 文件的名字。

由于 Docker 官方提供的 image 文件，都放在[`library`](https://hub.docker.com/r/library/)组里面，所以它的是默认组，可以省略。因此，上面的命令可以写成下面这样。

> ```bash
> $ docker image pull hello-world
> ```

抓取成功以后，就可以在本机看到这个 image 文件了。

> ```bash
> $ docker image ls
> ```

现在，运行这个 image 文件。

> ```bash
> $ docker container run hello-world
> ```

`docker container run`命令会从 image 文件，生成一个正在运行的容器实例。

注意，`docker container run`命令具有自动抓取 image 文件的功能。如果发现本地没有指定的 image 文件，就会从仓库自动抓取。因此，前面的`docker image pull`命令并不是必需的步骤。

如果运行成功，你会在屏幕上读到下面的输出。

> ```bash
> $ docker container run hello-world
>
> Hello from Docker!
> This message shows that your installation appears to be working correctly.
>
> ... ...
> ```

输出这段提示以后，`hello world`就会停止运行，容器自动终止。

有些容器不会自动终止，因为提供的是服务。比如，安装运行 Ubuntu 的 image，就可以在命令行体验 Ubuntu 系统。

> ```bash
> $ docker container run -it ubuntu bash
> ```

对于那些不会自动终止的容器，必须使用[`docker container kill`](https://docs.docker.com/engine/reference/commandline/container_kill/) 命令手动终止。

> ```bash
> $ docker container kill [containID]
> ```

## 四、制作 Docker 容器

下面我以 [koa-demos](http://www.ruanyifeng.com/blog/2017/08/koa.html) 项目为例，介绍怎么写 Dockerfile 文件，实现让用户在 Docker 容器里面运行 Koa 框架。

作为准备工作，请先[下载源码](https://github.com/ruanyf/koa-demos/archive/master.zip)。

> ```bash
> $ git clone https://github.com/ruanyf/koa-demos.git
> $ cd koa-demos
> ```

### 编写 Dockerfile 文件

首先，在项目的根目录下，新建一个文本文件`.dockerignore`，写入下面的[内容](https://github.com/ruanyf/koa-demos/blob/master/.dockerignore)。

> ```bash
> .git
> node_modules
> npm-debug.log
> ```

上面代码表示，这三个路径要排除，不要打包进入 image 文件。如果你没有路径要排除，这个文件可以不新建。

然后，在项目的根目录下，新建一个文本文件 Dockerfile，写入下面的[内容](https://github.com/ruanyf/koa-demos/blob/master/Dockerfile)。

> ```bash
> FROM node:8.4
> COPY . /app
> WORKDIR /app
> RUN npm install --registry=https://registry.npm.taobao.org
> EXPOSE 3000
> ```

上面代码一共五行，含义如下。

> - `FROM node:8.4`：该 image 文件继承官方的 node image，冒号表示标签，这里标签是`8.4`，即 8.4 版本的 node。
> - `COPY . /app`：将当前目录下的所有文件（除了`.dockerignore`排除的路径），都拷贝进入 image 文件的`/app`目录。
> - `WORKDIR /app`：指定接下来的工作路径为`/app`。
> - `RUN npm install`：在`/app`目录下，运行`npm install`命令安装依赖。注意，安装后所有的依赖，都将打包进入 image 文件。
> - `EXPOSE 3000`：将容器 3000 端口暴露出来， 允许外部连接这个端口。

### 创建 image 文件

有了 Dockerfile 文件以后，就可以使用`docker image build`命令创建 image 文件了。

> ```bash
> $ docker image build -t koa-demo .
> # 或者
> $ docker image build -t koa-demo:0.0.1 .
> ```

上面代码中，`-t`参数用来指定 image 文件的名字，后面还可以用冒号指定标签。如果不指定，默认的标签就是`latest`。最后的那个点表示 Dockerfile 文件所在的路径，上例是当前路径，所以是一个点。

如果运行成功，就可以看到新生成的 image 文件`koa-demo`了。

> ```bash
> $ docker image ls
> ```

### 生成容器

`docker container run`命令会从 image 文件生成容器。

> ```bash
> $ docker container run -p 8000:3000 -it koa-demo /bin/bash
> # 或者
> $ docker container run -p 8000:3000 -it koa-demo:0.0.1 /bin/bash
> ```

上面命令的各个参数含义如下：

> - `-p`参数：容器的 3000 端口映射到本机的 8000 端口。
> - `-it`参数：容器的 Shell 映射到当前的 Shell，然后你在本机窗口输入的命令，就会传入容器。
> - `koa-demo:0.0.1`：image 文件的名字（如果有标签，还需要提供标签，默认是 latest 标签）。
> - `/bin/bash`：容器启动以后，内部第一个执行的命令。这里是启动 Bash，保证用户可以使用 Shell。

如果一切正常，运行上面的命令以后，就会返回一个命令行提示符。

> ```bash
> root@66d80f4aaf1e:/app#
> ```

这表示你已经在容器里面了，返回的提示符就是容器内部的 Shell 提示符。执行下面的命令。

> ```bash
> root@66d80f4aaf1e:/app# node demos/01.js
> ```

这时，Koa 框架已经运行起来了。打开本机的浏览器，访问 http://127.0.0.1:8000，网页显示"Not Found"，这是因为这个 [demo](https://github.com/ruanyf/koa-demos/blob/master/demos/01.js) 没有写路由。

这个例子中，Node 进程运行在 Docker 容器的虚拟环境里面，进程接触到的文件系统和网络接口都是虚拟的，与本机的文件系统和网络接口是隔离的，因此需要定义容器与物理机的端口映射（map）。

现在，在容器的命令行，按下 Ctrl + c 停止 Node 进程，然后按下 Ctrl + d （或者输入 exit）退出容器。此外，也可以用`docker container kill`终止容器运行。

> ```bash
> # 在本机的另一个终端窗口，查出容器的 ID
> $ docker container ls
>
> # 停止指定的容器运行
> $ docker container kill [containerID]
> ```

容器停止运行之后，并不会消失，用下面的命令删除容器文件。

> ```bash
> # 查出容器的 ID
> $ docker container ls --all
>
> # 删除指定的容器文件
> $ docker container rm [containerID]
> ```

也可以使用`docker container run`命令的`--rm`参数，在容器终止运行后自动删除容器文件。

> ```bash
> $ docker container run --rm -p 8000:3000 -it koa-demo /bin/bash
> ```

### CMD 命令

上一节的例子里面，容器启动以后，需要手动输入命令`node demos/01.js`。我们可以把这个命令写在 Dockerfile 里面，这样容器启动以后，这个命令就已经执行了，不用再手动输入了。

> ```bash
> FROM node:8.4
> COPY . /app
> WORKDIR /app
> RUN npm install --registry=https://registry.npm.taobao.org
> EXPOSE 3000
> CMD node demos/01.js
> ```

上面的 Dockerfile 里面，多了最后一行`CMD node demos/01.js`，它表示容器启动后自动执行`node demos/01.js`。

你可能会问，`RUN`命令与`CMD`命令的区别在哪里？简单说，`RUN`命令在 image 文件的构建阶段执行，执行结果都会打包进入 image 文件；`CMD`命令则是在容器启动后执行。另外，一个 Dockerfile 可以包含多个`RUN`命令，但是只能有一个`CMD`命令。

注意，指定了`CMD`命令以后，`docker container run`命令就不能附加命令了（比如前面的`/bin/bash`），否则它会覆盖`CMD`命令。现在，启动容器可以使用下面的命令。

> ```bash
> $ docker container run --rm -p 8000:3000 -it koa-demo:0.0.1
> ```

### 发布 image 文件

容器运行成功后，就确认了 image 文件的有效性。这时，我们就可以考虑把 image 文件分享到网上，让其他人使用。

首先，去 [hub.docker.com](https://hub.docker.com/) 或 [cloud.docker.com](https://cloud.docker.com/) 注册一个账户。然后，用下面的命令登录。

> ```bash
> $ docker login
> ```

接着，为本地的 image 标注用户名和版本。

> ```bash
> $ docker image tag [imageName] [username]/[repository]:[tag]
> # 实例
> $ docker image tag koa-demos:0.0.1 ruanyf/koa-demos:0.0.1
> ```

也可以不标注用户名，重新构建一下 image 文件。

> ```bash
> $ docker image build -t [username]/[repository]:[tag] .
> ```

最后，发布 image 文件。

> ```bash
> $ docker image push [username]/[repository]:[tag]
> ```

发布成功以后，登录 hub.docker.com，就可以看到已经发布的 image 文件。

## 参考资料

- [Docker 入门教程](https://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html)
- [Docker — 从入门到实践](https://github.com/yeasy/docker_practice)
