# Docker Compose

>  [compose](https://github.com/docker/compose) 项目是 Docker 官方的开源项目，负责实现对 Docker 容器集群的快速编排。从功能上看，跟 `OpenStack` 中的 `Heat` 十分类似。 

## 一、Compose 简介

**`Compose` 的定位是：定义和运行多个 Docker 容器的应用**。 使用一个 `Dockerfile` 模板文件，可以让用户很方便的定义一个单独的应用容器。然而，在日常工作中，经常会碰到需要多个容器相互配合来完成某项任务的情况。例如要实现一个 Web 项目，除了 Web 服务容器本身，往往还需要再加上后端的数据库服务容器，甚至还包括负载均衡容器等。 

`Compose` 恰好满足了这样的需求。它允许用户通过一个单独的 `docker-compose.yml` 模板文件（YAML 格式）来定义一组相关联的应用容器为一个项目（project）。 

`Compose` 中有两个重要的概念：

- **服务 (`service`)**：一个应用的容器，实际上可以包括若干运行相同镜像的容器实例。
- **项目 (`project`)**：由一组关联的应用容器组成的一个完整业务单元，在 `docker-compose.yml` 文件中定义。

 `Compose` 的默认管理对象是项目，通过子命令对项目中的一组容器进行便捷地生命周期管理。 

## 二、安装卸载

`Compose` 支持 Linux、macOS、Windows10 三大平台。 

Linux 安装方式：

```bash
sudo curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

> :bell: 详情请参考：[Install Docker Compose](https://docs.docker.com/compose/install/)

## 三、快速入门

### web 应用

新建文件夹，在该目录中编写 `app.py` 文件

```python
from flask import Flask
from redis import Redis

app = Flask(__name__)
redis = Redis(host='redis', port=6379)

@app.route('/')
def hello():
    count = redis.incr('hits')
    return 'Hello World! 该页面已被访问 {} 次。\n'.format(count)

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
```

### Dockerfile

编写 `Dockerfile` 文件，内容为

```docker
FROM python:3.6-alpine
ADD . /code
WORKDIR /code
RUN pip install redis flask
CMD ["python", "app.py"]
```

### docker-compose.yml

编写 `docker-compose.yml` 文件，这个是 Compose 使用的主模板文件。

```yaml
version: '3'
services:

  web:
    build: .
    ports:
     - "5000:5000"

  redis:
    image: "redis:alpine"
```

### 运行 compose 项目

```bash
$ docker-compose up
```

此时访问本地 `5000` 端口，每次刷新页面，计数就会加 1。

## 四、命令

> :bell: 请参考：
>
> - [Compose 官方命令说明文档](https://docs.docker.com/compose/reference/)
> - [Compose 命令说明中文文档](https://yeasy.gitbooks.io/docker_practice/content/compose/commands.html)

## 五、模板文件

> `docker-compose.yml` 文件是 Docker Compose 的模板文件，其作用类似于 Dockerfile 和 Docker。

[docker-compose.yml 支持的默认环境变量官方文档](https://docs.docker.com/compose/env-file/)

## 参考资料

- **官方**
  - [Docker Compose Github](https://github.com/docker/compose)
  - [Docker Compose 官方文档](https://docs.docker.com/compose/)
- **教程**
  - [Docker — 从入门到实践 - Docker Compose 项目]( https://yeasy.gitbooks.io/docker_practice/content/compose/ )

