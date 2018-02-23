# JDK 安装

## CentOS 下安装

安装方法有两种：压缩包安装和 yum 安装

### 压缩包安装

安装步骤如下：

（1）下载

进入官网下载地址：http://www.oracle.com/technetwork/java/javase/downloads/index.html ，选择合适的版本下载。

我选择的是最新 JDK8 版本：http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.tar.gz

（2）解压到本地

我个人喜欢存放在：`/opt/software/java`

（3）设置环境变量

输入 `vi /etc/profile` ，添加环境变量如下：

```
# JDK 的根路径
export JAVA_HOME=/opt/software/java/jdk1.8.0_162
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
```

执行 `source /etc/profile` ，立即生效

（4）检验是否安装成功，执行 `java -version` 命令

### yum 安装

安装步骤如下：

（1）查看可以安装的JDK版本

执行下面命令查看当前 linux 发型版本可以下载安装的 JDK 版本。

```
yum search java | grep openjdk
```

（2）选择一个合适的版本安装

```
yum -y install java-1.8.0-openjdk-devel-debug.x86_64
```

安装成功后，默认安装路径在 `/usr/lib/jvm/java`

（3）设置环境变量，同压缩包安装。

（4）检验是否安装成功，执行 `java -version` 命令

## 脚本

以上两种安装方式，我都写了脚本去执行：

| [安装脚本](https://github.com/dunwu/linux/tree/master/codes/deploy/tool/jdk) |