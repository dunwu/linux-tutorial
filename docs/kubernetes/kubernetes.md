# Kubernetes

> Kubernetes 是用于自动部署，扩展和管理 Docker 应用程序的开源系统。简称 K8S
>
> 关键词： `docker`

<!-- TOC depthFrom:2 depthTo:2 -->

- [功能](#功能)
- [简介](#简介)
- [基础](#基础)
- [进阶](#进阶)
- [命令](#命令)
- [引用和引申](#引用和引申)

<!-- /TOC -->

## 功能

- 基于容器的应用部署、维护和滚动升级
- 负载均衡和服务发现
- 跨机器和跨地区的集群调度
- 自动伸缩
- 无状态服务和有状态服务
- 广泛的 Volume 支持
- 插件机制保证扩展性

## 简介

Kubernetes 主控组件（Master） 包含三个进程，都运行在集群中的某个节上，通常这个节点被称为 master 节点。这些进程包括：`kube-apiserver`、`kube-controller-manager` 和 `kube-scheduler`。

集群中的每个非 master 节点都运行两个进程：

- kubelet，和 master 节点进行通信。
- kube-proxy，一种网络代理，将 Kubernetes 的网络服务代理到每个节点上。

### Kubernetes 对象

Kubernetes 包含若干抽象用来表示系统状态，包括：已部署的容器化应用和负载、与它们相关的网络和磁盘资源以及有关集群正在运行的其他操作的信息。


- Pod - kubernetes 对象模型中最小的单元，它代表集群中一个正在运行的进程。
- Service
- Volume
- Namespace

<br><div align="center"><img src="https://raw.githubusercontent.com/dunwu/images/master/images/os/kubernetes/pod.svg"/></div><br>

高级对象

- ReplicaSet
- Deployment
- StatefulSet
- DaemonSet
- Job

## 基础

## 进阶

## 命令

### 客户端配置

```bash
# Setup autocomplete in bash; bash-completion package should be installed first
source <(kubectl completion bash)

# View Kubernetes config
kubectl config view

# View specific config items by json path
kubectl config view -o jsonpath='{.users[?(@.name == "k8s")].user.password}'

# Set credentials for foo.kuberntes.com
kubectl config set-credentials kubeuser/foo.kubernetes.com --username=kubeuser --password=kubepassword
```

### 查找资源

```bash
# List all services in the namespace
kubectl get services

# List all pods in all namespaces in wide format
kubectl get pods -o wide --all-namespaces

# List all pods in json (or yaml) format
kubectl get pods -o json

# Describe resource details (node, pod, svc)
kubectl describe nodes my-node

# List services sorted by name
kubectl get services --sort-by=.metadata.name

# List pods sorted by restart count
kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'

# Rolling update pods for frontend-v1
kubectl rolling-update frontend-v1 -f frontend-v2.json

# Scale a replicaset named 'foo' to 3
kubectl scale --replicas=3 rs/foo

# Scale a resource specified in "foo.yaml" to 3
kubectl scale --replicas=3 -f foo.yaml

# Execute a command in every pod / replica
for i in 0 1; do kubectl exec foo-$i -- sh -c 'echo $(hostname) > /usr/share/nginx/html/index.html'; done
```

### 资源管理

```bash
# Get documentation for pod or service
kubectl explain pods,svc

# Create resource(s) like pods, services or daemonsets
kubectl create -f ./my-manifest.yaml

# Apply a configuration to a resource
kubectl apply -f ./my-manifest.yaml

# Start a single instance of Nginx
kubectl run nginx --image=nginx

# Create a secret with several keys
cat <<EOF | kubectl create -f -
apiVersion: v1
kind: Secret
metadata:
 name: mysecret
type: Opaque
data:
 password: $(echo "s33msi4" | base64)
 username: $(echo "jane"| base64)
EOF

# Delete a resource
kubectl delete -f ./my-manifest.yaml
```

### 监控和日志

```bash
# Deploy Heapster from Github repository
kubectl create -f deploy/kube-config/standalone/

# Show metrics for nodes
kubectl top node

# Show metrics for pods
kubectl top pod

# Show metrics for a given pod and its containers
kubectl top pod pod_name --containers

# Dump pod logs (stdout)
kubectl logs pod_name

# Stream pod container logs (stdout, multi-container case)
kubectl logs -f pod_name -c my-container
```

## 引用和引申

- 官方
  - [Github](https://github.com/kubernetes/kubernetes)
  - [官网](https://kubernetes.io/)
- 教程
  - [Kubernetes 中文指南](https://jimmysong.io/kubernetes-handbook/)
- 文章
  - https://github.com/LeCoupa/awesome-cheatsheets/blob/master/tools/kubernetes.sh
- 更多资源
  - [awesome-kubernetes](https://github.com/ramitsurana/awesome-kubernetes)
