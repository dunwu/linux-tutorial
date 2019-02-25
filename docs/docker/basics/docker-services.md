# Docker 服务

## 关于服务

在分布式应用程序中，应用程序的不同部分被称为“服务”。例如，如果您想象一个视频共享网站，它可能包含用于将应用程序数据存储在数据库中的服务，用户上传文件后在后台传输的服务，前端应用服务等等。

服务实际上只是“生产环境中的容器”。一个服务只运行一个镜像，但它需要制定镜像的运行方式 - 应该使用哪个端口，容器应该运行多少副本，以便服务具有所需的容量，以及等等。缩放服务会更改运行该软件的容器实例的数量，从而为流程中的服务分配更多计算资源。

幸运的是，使用 Docker 平台定义，运行和扩展服务非常简单 - 只需编写一个 docker-compose.yml 文件即可。

## docker-compose.yml 文件

它是一个YAML文件，它定义了Docker容器在生产中的行为方式。


```
version: "3"
services:
  web:
    # replace username/repo:tag with your name and image details
    image: username/repo:tag
    deploy:
      replicas: 5
      resources:
        limits:
          cpus: "0.1"
          memory: 50M
      restart_policy:
        condition: on-failure
    ports:
      - "80:80"
    networks:
      - webnet
networks:
  webnet:
```
