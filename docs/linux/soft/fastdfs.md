# FastDFS

## 简介

FastDFS 是一个开源的轻量级分布式文件系统，它对文件进行管理，功能包括：文件存储、文件同步、文件访问（文件上传、文件下载）等，解决了大容量存储和负载均衡的问题。特别适合以文件为载体的在线服务，如相册网站、视频网站等等。
FastDFS 为互联网量身定制，充分考虑了冗余备份、负载均衡、线性扩容等机制，并注重高可用、高性能等指标，使用 FastDFS 很容易搭建一套高性能的文件服务器集群提供文件上传、下载等服务。

## 概念

FastDFS 服务端有三个角色：跟踪服务器（tracker server）、存储服务器（storage server）和客户端（client）。

**tracker server**：跟踪服务器，主要做调度工作，起负载均衡的作用。在内存中记录集群中所有存储组和存储服务器的状态信息，是客户端和数据服务器交互的枢纽。相比 GFS 中的 master 更为精简，不记录文件索引信息，占用的内存量很少。

Tracker 是 FastDFS 的协调者，负责管理所有的 storage server 和 group，每个 storage 在启动后会连接 Tracker，告知自己所属的 group 等信息，并保持周期性的心跳，tracker 根据 storage 的心跳信息，建立 group==>[storage server list]的映射表。

Tracker 需要管理的元信息很少，会全部存储在内存中；另外 tracker 上的元信息都是由 storage 汇报的信息生成的，本身不需要持久化任何数据，这样使得 tracker 非常容易扩展，直接增加 tracker 机器即可扩展为 tracker cluster 来服务，cluster 里每个 tracker 之间是完全对等的，所有的 tracker 都接受 stroage 的心跳信息，生成元数据信息来提供读写服务。

**storage server**：存储服务器（又称：存储节点或数据服务器），文件和文件属性（meta data）都保存到存储服务器上。Storage server 直接利用 OS 的文件系统调用管理文件。

Storage server（后简称 storage）以组（卷，group 或 volume）为单位组织，一个 group 内包含多台 storage 机器，数据互为备份，存储空间以 group 内容量最小的 storage 为准，所以建议 group 内的多个 storage 尽量配置相同，以免造成存储空间的浪费。

以 group 为单位组织存储能方便的进行应用隔离、负载均衡、副本数定制（group 内 storage server 数量即为该 group 的副本数），比如将不同应用数据存到不同的 group 就能隔离应用数据，同时还可根据应用的访问特性来将应用分配到不同的 group 来做负载均衡；缺点是 group 的容量受单机存储容量的限制，同时当 group 内有机器坏掉时，数据恢复只能依赖 group 内地其他机器，使得恢复时间会很长。

group 内每个 storage 的存储依赖于本地文件系统，storage 可配置多个数据存储目录，比如有 10 块磁盘，分别挂载在`/data/disk1-/data/disk10`，则可将这 10 个目录都配置为 storage 的数据存储目录。

storage 接受到写文件请求时，会根据配置好的规则（后面会介绍），选择其中一个存储目录来存储文件。为了避免单个目录下的文件数太多，在 storage 第一次启动时，会在每个数据存储目录里创建 2 级子目录，每级 256 个，总共 65536 个文件，新写的文件会以 hash 的方式被路由到其中某个子目录下，然后将文件数据直接作为一个本地文件存储到该目录中。

**client**：客户端，作为业务请求的发起方，通过专有接口，使用 TCP/IP 协议与跟踪器服务器或存储节点进行数据交互。FastDFS 向使用者提供基本文件访问接口，比如 upload、download、append、delete 等，以客户端库的方式提供给用户使用。

另外两个概念：

**group** ：组， 也可称为卷。 同组内服务器上的文件是完全相同的 ，同一组内的 storage server 之间是对等的， 文件上传、 删除等操作可以在任意一台 storage server 上进行 。

**meta data** ：文件相关属性，键值对（ Key Value Pair） 方式，如：width=1024,heigth=768 。

![img](http://www.ityouknow.com/assets/images/2018/fastdfs/fastdfs_arch.png)





Tracker 相当于 FastDFS 的大脑，不论是上传还是下载都是通过 tracker 来分配资源；客户端一般可以使用 ngnix 等静态服务器来调用或者做一部分的缓存；存储服务器内部分为卷（或者叫做组），卷于卷之间是平行的关系，可以根据资源的使用情况随时增加，卷内服务器文件相互同步备份，以达到容灾的目的。

## 参考资料

- [FastDFS 官方 Github](https://github.com/happyfish100/fastdfs)
- [FastDFS 官方 wiki](https://github.com/happyfish100/fastdfs/wiki)
- [分布式文件系统 FastDFS 详解](https://www.cnblogs.com/ityouknow/p/8240976.html)
