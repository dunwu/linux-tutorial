# Linux 傻瓜式运维脚本

> **本项目脚本代码用于在 [CentOS](https://www.centos.org/) 机器上安装常用命令工具或开发软件。**

使用说明：

（1）下载脚本

```sh
curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/download.sh | bash
```

（2）执行脚本

```sh
cd /tmp/dunwu-ops
./dunwu-ops.sh
```

（3）清除脚本

```sh
curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/clear.sh | bash
```

本项目总结、收集 Linux 环境下运维常用到的脚本工具，大致分为三类：

- [系统运维脚本](sys)
- [服务、应用运维脚本](soft)
- [构建、编译项目脚本（目前支持 Java、Javascript 应用）](build)
