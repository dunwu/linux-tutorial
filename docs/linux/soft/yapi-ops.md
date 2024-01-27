# YApi 运维

> [YApi](https://github.com/YMFE/yapi) 是一个可本地部署的、打通前后端及 QA 的、可视化的接口管理平台。
>
> 本文目的在于记录 svn 的安装、配置、使用。

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/1562814562978.png)

<!-- TOC depthFrom:2 depthTo:3 -->

- [1. 普通部署](#1-普通部署)
  - [1.1. 环境要求](#11-环境要求)
  - [1.2. 部署](#12-部署)
  - [1.3. 升级](#13-升级)
- [2. Docker 部署](#2-docker-部署)
  - [2.1. 环境要求](#21-环境要求)
  - [2.2. 部署](#22-部署)
- [3. 参考资料](#3-参考资料)

<!-- /TOC -->

## 1. 普通部署

### 1.1. 环境要求

- nodejs（7.6+)
- mongodb（2.6+）
- git

### 1.2. 部署

#### 方式一. 可视化部署[推荐]

执行 yapi server 启动可视化部署程序，输入相应的配置和点击开始部署，就能完成整个网站的部署。部署完成之后，可按照提示信息，执行 node/{网站路径/server/app.js} 启动服务器。在浏览器打开指定 url, 点击登录输入您刚才设置的管理员邮箱，默认密码(ymfe.org) 登录系统（默认密码可在个人中心修改）。

```bash
$ npm install -g yapi-cli --registry https://registry.npm.taobao.org
$ yapi server
```

#### 方式二. 命令行部署

如果 github 压缩文件无法下载，或需要部署到一些特殊的服务器，可尝试此方法

```bash
mkdir yapi
cd yapi
git clone https://github.com/YMFE/yapi.git vendors //或者下载 zip 包解压到 vendors 目录（clone 整个仓库大概 140+ M，可以通过 `git clone --depth=1 https://github.com/YMFE/yapi.git vendors` 命令减少，大概 10+ M）
cp vendors/config_example.json ./config.json //复制完成后请修改相关配置
cd vendors
npm install --production --registry https://registry.npm.taobao.org
npm run install-server //安装程序会初始化数据库索引和管理员账号，管理员账号名可在 config.json 配置
node server/app.js //启动服务器后，请访问 127.0.0.1:{config.json配置的端口}，初次运行会有个编译的过程，请耐心等候
```

安装后的目录结构如下：

```
|-- config.json
|-- init.lock
|-- log
`-- vendors
    |-- CHANGELOG.md
    |-- LICENSE
    |-- README.md
    |-- client
    |-- common
    |-- config_example.json
    |-- doc
    |-- exts
    |-- nodemon.json
    |-- npm-debug.log
    |-- package.json
    |-- plugin.json
    |-- server
    |-- static
    |-- test
    |-- webpack.alias.js
    |-- yapi-base-flow.jpg
    |-- ydocfile.js
    `-- ykit.config.js
```

### 1.3. 升级

升级项目版本是非常容易的，并且不会影响已有的项目数据，只会同步 vendors 目录下的源码文件。

```
cd  {项目目录}
yapi ls //查看版本号列表
yapi update //升级到最新版本
yapi update -v v1.1.0 //升级到指定版本
```

## 2. Docker 部署

### 2.1. 环境要求

- 系统：`CentOS 7.4`
- 硬件要求：`1 GB RAM minimum`
- ip：`http://192.168.1.121`
- docker version：`17.12.1-ce, build 7390fc6`
- docker-compose version：`1.18.0, build 8dd22a9`

> 建议部署成 http 站点，因 chrome 浏览器安全限制，部署成 https 会导致测试功能在请求 http 站点时文件上传功能异常。--[来源](https://yapi.ymfe.org/devops.html)

### 2.2. 部署

- 一个好心人的维护：<https://github.com/branchzero/yapi-docker>
- 使用方法： - work path：`mkdir -p /opt/git-data` - clone：`cd /opt/git-data && git clone https://github.com/branchzero/yapi-docker.git` - permission：`chmod -R 777 /opt/git-data` - run command：`cd /opt/git-data/yapi-docker && docker-compose up -d` - open chrome：`http://192.168.1.121:3000`
- 初始化管理员账号名：`admin@admin.com`，密码：`ymfe.org`

## 3. 参考资料

- [官方 Github](https://github.com/YMFE/yapi)
- [官网在线演示](http://yapi.demo.qunar.com/)
- [官方使用手册](https://hellosean1025.github.io/yapi/index.html)
