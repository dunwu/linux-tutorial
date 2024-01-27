# JDK 安装

> 关键词：JDK, JAVA_HOME, CLASSPATH, PATH

<!-- TOC depthFrom:2 depthTo:3 -->

- [JDK 安装步骤](#jdk-安装步骤)
- [Windows 系统安装方法](#windows-系统安装方法)
- [Linux 系统安装方法](#linux-系统安装方法)
  - [RedHat 发行版本使用 rpm 安装方法](#redhat-发行版本使用-rpm-安装方法)
- [参考资料](#参考资料)

<!-- /TOC -->

## JDK 安装步骤

JDK 安装步骤：

（1）下载 JDK

a. 进入 [Java 官网下载页面](https://www.oracle.com/technetwork/java/javase/downloads/index.html)；

b. 选择需要的版本：

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20180920181010164121.png)

c. 选择对应操作系统的安装包：

Windows 系统选择 exe 安装包；Mac 系统选择 dmp 安装包；Linux 系统选择 tar.gz 压缩包（RedHat 发行版可以安装 rpm 包）。

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20180920181010164308.png)

（2）运行安装包，按提示逐步安装

（3）配置系统环境变量：`JAVA_HOME`, `CLASSPATH`, `PATH`

（4）验证 Java 是否安装成功

## Windows 系统安装方法

（1）下载 JDK

需要根据 Windows 系统实际情况，选择 exe 安装文件：

- 32 位计算机选择 Windows x86
- 64 位计算机选择 Windows x64

（2）运行安装包，按提示逐步安装

（3）配置系统环境变量

a. 安装完成后，右击"我的电脑"，点击"属性"，选择"高级系统设置"；

![img](https://www.runoob.com/wp-content/uploads/2013/12/win-java1.png)

b. 选择"高级"选项卡，点击"环境变量"；

![img](https://www.runoob.com/wp-content/uploads/2013/12/java-win2.png)

然后就会出现如下图所示的画面：

在"系统变量"中设置 3 项属性，JAVA_HOME,PATH,CLASSPATH(大小写无所谓),若已存在则点击"编辑"，不存在则点击"新建"。

变量设置参数如下：

- 变量名：**JAVA_HOME**
- 变量值：**C:\Program Files (x86)\Java\jdk1.8.0_91** // 要根据自己的实际路径配置

- 变量名：**CLASSPATH**
- 变量值：**.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar;** //记得前面有个"."

- 变量名：**Path**
- 变量值：**%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;**

（4）验证 Java 是否安装成功

a. "开始"->"运行"，键入"cmd"；

b. 键入命令: **java -version**、**java**、**javac** 几个命令，出现以下信息，说明环境变量配置成功；

![img](https://www.runoob.com/wp-content/uploads/2013/12/java-win9.png)

## Linux 系统安装方法

（1）下载 JDK

需要根据 Linux 系统实际情况，选择 tar.gz 压缩包：

- 32 位计算机选择 Linux x86
- 64 位计算机选择 Linux x64

（2）解压压缩包到本地

```bash
$ tar -zxf jdk-8u162-linux-x64.tar.gz
```

（3）配置系统环境变量

执行 `/etc/profile` 命令，添加以下内容：

```bash
# JDK 的根路径
export JAVA_HOME=/opt/java/jdk1.8.0_162
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
```

执行 `source /etc/profile` ，立即生效

（4）验证 Java 是否安装成功

执行 `java -version` 命令，验证安装是否成功。

### RedHat 发行版本使用 rpm 安装方法

（1）下载 JDK

下载 rpm 安装包

（2）选择一个合适的版本安装

```bash
$ rpm -ivh jdk-8u181-linux-x64.rpm
```

安装成功后，默认安装路径在 `/usr/local` 下：

（3）设置环境变量，同压缩包安装。

（4）检验是否安装成功，执行 `java -version` 命令

## 更多内容

- **引申**
  - [操作系统、运维部署总结系列](https://github.com/dunwu/OS)
- **引用**
- http://www.runoob.com/java/java-environment-setup.html
- https://blog.csdn.net/deliciousion/article/details/78046007
