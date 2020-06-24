# Redis 集群配置

## 使用方式

集群拓扑：

- 三主六从，每个主节点有两个从节点。
- 三哨兵，分别监听其中一个主节点。

启动方式：

- 先执行 start-cluster.sh，会自动根据 6381 ~ 6389 目录启动服务器，并将其配置为集群。
- 再执行 start-sentinel.sh，会根据 26381 ~ 26383 目录启动哨兵，监听集群中的三个主节点。

## 配置

（1）集群服务器配置 redis.conf

```
port 6381
bind 0.0.0.0
daemonize yes

cluster-enabled yes
cluster-config-file /usr/local/redis/conf/6381/6381.conf
cluster-node-timeout 10000

appendonly yes
dir /usr/local/redis/conf/6381
pidfile /usr/local/redis/conf/6381/6381.pid
logfile /usr/local/redis/conf/6381/6381.log
```

端口号、配置目录（`/usr/local/redis/conf`）根据实际情况修改。

（2）哨兵服务器配置 sentinel.conf

```
port 26383
daemonize yes
sentinel monitor redis-master 172.22.6.3 6383 2
sentinel down-after-milliseconds redis-master 5000
sentinel failover-timeout redis-master 900000
sentinel parallel-syncs redis-master 1
#sentinel auth-pass redis-master 123456
logfile /usr/local/redis/conf/26383/26383.log
```

端口号、配置目录（`/usr/local/redis/conf`）根据实际情况修改。

最重要的配置在于：sentinel monitor redis-master 172.22.6.3 6383 2

表示监听的服务器集群名叫 redis-master，当前哨兵监听的服务器节点是：172.22.6.3:6383，这个节点如果是主节点，一旦宕机，选举新的主节点，需要至少 2 个哨兵同意。