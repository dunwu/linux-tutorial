# Docker 技巧

## 命令技巧

### 停止所有的 docker container

_这样才能够删除其中的images_

```
docker stop $(docker ps -a -q)
```

### 删除所有的 docker container

```
docker rm $(docker ps -a -q)
```

### 删除所有的 docker images

```
docker rmi $(docker images -q)
```
