# Nodejs 安装

<!-- TOC depthFrom:2 depthTo:3 -->

- [安装方法](#安装方法)
    - [先安装 nvm](#先安装-nvm)
    - [安装 Nodejs](#安装-nodejs)
- [脚本](#脚本)

<!-- /TOC -->

## 安装方法

### 先安装 nvm

推荐安装 nvm(Node Version Manager) ，来管理 node.js 版本。

安装步骤如下：

（1）执行安装脚本

```
rm -rf ~/.nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
. ~/.nvm/nvm.sh
```

（2）检验是否安装成功

执行 `nvm --version` 命令。

注意：如果出现 `nvm: command not found` ，关闭终端，然后再打开终端试试。

### 安装 Nodejs

安装步骤如下：

（1）使用 nvm 安装 nodejs 指定版本

执行以下命令：

```
nvm install 8.9.4
nvm use 8.9.4
```

（2）检验是否安装成功

执行 `node --version` 命令。

注意：如果出现 `node: command not found` ，关闭终端，然后再打开终端试试。

## 脚本

| [安装脚本](https://github.com/dunwu/linux-tutorial/tree/master/codes/linux/soft) |

## 更多内容

- **引申**
  - [操作系统、运维部署总结系列](https://github.com/dunwu/OS)
