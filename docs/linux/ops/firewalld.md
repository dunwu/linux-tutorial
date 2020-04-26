# 防火墙 - Firewalld

## 一、firewalld 服务命令

```shell
systemctl enable firewalld.service  # 开启服务（开机自动启动服务）
systemctl disable firewalld.service # 关闭服务（开机不会自动启动服务）
systemctl start firewalld.service   # 启动服务
systemctl stop firewalld.service    # 停止服务
systemctl restart firewalld.service # 重启服务
systemctl reload firewalld.service  # 重新载入配置
systemctl status firewalld.service  # 查看服务状态
```

## 二、firewall-cmd 命令

`firewall-cmd` 命令用于配置防火墙。

```shell
firewall-cmd --version                    # 查看版本
firewall-cmd --help                       # 查看帮助
firewall-cmd --state                      # 显示状态
firewall-cmd --reload                     # 更新防火墙规则
firewall-cmd --get-active-zones           # 查看区域信息
firewall-cmd --get-zone-of-interface=eth0 # 查看指定接口所属区域
firewall-cmd --panic-on                   # 拒绝所有包
firewall-cmd --panic-off                  # 取消拒绝状态
firewall-cmd --query-panic                # 查看是否拒绝

firewall-cmd --zone=public --list-ports   # 查看所有打开的端口
firewall-cmd --zone=public --query-port=80/tcp # 查看是否有开放的 80 TCP 端口
firewall-cmd --zone=public --add-port=8080/tcp --permanent # 添加开放端口（--permanent永久生效，没有此参数重启后失效）
firewall-cmd --zone=public --remove-port=80/tcp --permanent # 永久删除开放的 80 TCP 端口
```

## 参考资料

- [CentOS7 使用 firewalld 打开关闭防火墙与端口](https://www.cnblogs.com/moxiaoan/p/5683743.html)