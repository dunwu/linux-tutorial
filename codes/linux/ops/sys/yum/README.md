# 脚本使用说明

## 替换 yum repo 源

由于 CentOS 默认 yum 源，访问速度很慢，所以推荐使用国内镜像。

使用方法：执行以下任意命令即可执行脚本。

```sh
curl -o- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/sys/yum/change-yum-repo.sh | bash
wget -qO- https://raw.githubusercontent.com/dunwu/linux-tutorial/master/codes/linux/ops/sys/yum/change-yum-repo.sh | bash
```
