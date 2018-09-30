
### 设置 Linux 启动模式

1. 停机(记得不要把 initdefault 配置为 0，因为这样会使 Linux 不能启动)
2. 单用户模式，就像 Win9X 下的安全模式
3. 多用户，但是没有 NFS
4. 完全多用户模式，准则的运行级
5. 通常不用，在一些特殊情况下可以用它来做一些事情
6. X11，即进到 X-Window 系统
7. 重新启动 (记得不要把 initdefault 配置为 6，因为这样会使 Linux 不断地重新启动)

设置方法：

```sh
$ sed -i 's/id:5:initdefault:/id:3:initdefault:/' /etc/inittab
```