/opt/redis/src/redis-server /usr/local/redis/conf/6381/redis.conf

/opt/redis/src/redis-server /usr/local/redis/conf/6382/redis.conf

/opt/redis/src/redis-server /usr/local/redis/conf/6383/redis.conf

/opt/redis/src/redis-server /usr/local/redis/conf/6384/redis.conf

/opt/redis/src/redis-server /usr/local/redis/conf/6385/redis.conf

/opt/redis/src/redis-server /usr/local/redis/conf/6386/redis.conf

/opt/redis/src/redis-server /usr/local/redis/conf/6387/redis.conf

/opt/redis/src/redis-server /usr/local/redis/conf/6388/redis.conf

/opt/redis/src/redis-server /usr/local/redis/conf/6389/redis.conf

/opt/redis/src/redis-cli --cluster create 172.22.6.3:6381 172.22.6.3:6382 172.22.6.3:6383 172.22.6.3:6384 172.22.6.3:6385 172.22.6.3:6386 172.22.6.3:6387 172.22.6.3:6388 172.22.6.3:6389 --cluster-replicas 2
