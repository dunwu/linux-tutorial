# Docker 教程

## [简介](docker-introduction.md)

> **Docker 属于 Linux 容器的一种封装，提供简单易用的容器使用接口。**
>
> Docker 将应用程序与该程序的依赖，打包在一个文件里面。运行这个文件，就会生成一个虚拟容器。程序在这个虚拟容器里运行，就好像在真实的物理机上运行一样。有了 Docker，就不用担心环境问题。

<br><div align="center"><img src="https://raw.githubusercontent.com/dunwu/images/master/images/os/docker/containers-and-vm.png"/></div><br>

## [入门篇](docker-quickstart.md)

## 基础篇

### 安装

Docker 分为 CE 和 EE 两大版本。

- CE 即社区版（免费，支持周期 7 个月）。Docker CE 分为 `stable`, `test`, 和 `nightly` 三个更新频道。每六个月发布一个 stable 版本。
- EE 即企业版，强调安全，付费使用，支持周期 24 个月。

Docker CE 可以安装在 Linux 、Windows 10 (PC) 和 MAC 上。

> 参考：
>
> - [官方安装指南](https://docs.docker.com/install/)
> - [Docker 中文教程安装指南](https://yeasy.gitbooks.io/docker_practice/content/install/)

### [Docker 镜像](basics/docker-image.md)

### [Docker 容器](basics/docker-container.md)

### [Dockerfile](basics/docker-dockerfile.md)

- FROM(指定基础镜像)
- RUN(执行命令)
- COPY(复制文件)
- ADD(更高级的复制文件)
- CMD(容器启动命令)
- ENTRYPOINT(入口点)
- ENV(设置环境变量)
- ARG(构建参数)
- VOLUME(定义匿名卷)
- EXPOSE(暴露端口)
- WORKDIR(指定工作目录)
- USER(指定当前用户)
- HEALTHCHECK(健康检查)
- ONBUILD(为他人作嫁衣裳)

## 进阶篇

### 设计

## 实战篇

## 常见问题

## 附录

### [命令](appendix/docker-cli.md)

### [资源](appendix/docker-resources.md)

### 术语

### 技巧

### 版本

### 反馈
