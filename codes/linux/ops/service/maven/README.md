# 脚本使用说明

## 安装 Maven

使用方法：执行以下任意命令即可执行脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/service/maven/install-maven3.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/os-tutorial/master/codes/linux/ops/service/maven/install-maven3.sh | bash
```

脚本会下载解压 maven 到 `/opt/maven` 路径下。

备份并替换 settings.xml（本目录中的 settings-aliyun.xml），使用 aliyun 镜像加速 maven
