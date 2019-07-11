# 部署并使用 Nexus 作为 Maven 私服

> 关键词：maven, nexus
>
> 部署环境
>
> - Nexus 3.13.0
> - JDK 1.8
> - Maven 3.5.4

<!-- TOC depthFrom:2 depthTo:3 -->

- [下载安装 Nexus](#下载安装-nexus)
- [启动停止 Nexus](#启动停止-nexus)
- [使用 Nexus](#使用-nexus)
    - [配置 settings.xml](#配置-settingsxml)
    - [配置 pom.xml](#配置-pomxml)
    - [执行 maven 构建](#执行-maven-构建)
- [参考资料](#参考资料)

<!-- /TOC -->

## 下载安装 Nexus

进入[官方下载地址](https://www.sonatype.com/download-oss-sonatype)，选择合适版本下载。

<div align="center"><img src="http://dunwu.test.upcdn.net/snap/20181127203029.png"/></div>

本人希望将 Nexus 部署在 Linux 机器，所以选用的是 Unix 版本。

这里，如果想通过命令方式直接下载（比如用脚本安装），可以在[官方历史发布版本页面](https://help.sonatype.com/repomanager3/download/download-archives---repository-manager-3)中找到合适版本，然后执行以下命令：

```sh
wget -O /opt/maven/nexus-unix.tar.gz http://download.sonatype.com/nexus/3/nexus-3.13.0-01-unix.tar.gz
tar -zxf nexus-unix.tar.gz
```

解压后，有两个目录：

- nexus-3.13.0-01 - 包含了 Nexus 运行所需要的文件。是 Nexus 运行必须的。
- sonatype-work - 包含了 Nexus 生成的配置文件、日志文件、仓库文件等。当我们需要备份 Nexus 的时候默认备份此目录即可。

## 启动停止 Nexus

进入 nexus-3.13.0-01/bin 目录，有一个可执行脚本 nexus。

执行 `./nexus`，可以查看允许执行的参数，如下所示，含义可谓一目了然：

```sh
$ ./nexus
Usage: ./nexus {start|stop|run|run-redirect|status|restart|force-reload}
```

- 启动 nexus - `./nexus start`
- 停止 nexus -

启动成功后，在浏览器中访问 `http://<ip>:8081`，欢迎页面如下图所示：

<div align="center"><img src="http://dunwu.test.upcdn.net/snap/20181127203131.png"/></div>

点击右上角 Sign in 登录，默认用户名/密码为：admin/admin123。

有必要提一下的是，在 Nexus 的 Repositories 管理页面，展示了可用的 maven 仓库，如下图所示：

<div align="center"><img src="http://dunwu.test.upcdn.net/snap/20181127203156.png"/></div>

> 说明：
>
> - maven-central - maven 中央库（如果没有配置 mirror，默认就从这里下载 jar 包），从 https://repo1.maven.org/maven2/ 获取资源
> - maven-releases - 存储私有仓库的发行版 jar 包
> - maven-snapshots - 存储私有仓库的快照版（调试版本） jar 包
> - maven-public - 私有仓库的公共空间，把上面三个仓库组合在一起对外提供服务，在本地 maven 基础配置 settings.xml 中使用。

## 使用 Nexus

如果要使用 Nexus，还必须在 settings.xml 和 pom.xml 中配置认证信息。

### 配置 settings.xml

一份完整的 `settings.xml`：

```xml
<?xml version="1.0" encoding="UTF-8"?>

<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <pluginGroups>
    <pluginGroup>org.sonatype.plugins</pluginGroup>
  </pluginGroups>

  <!-- Maven 私服账号信息 -->
  <servers>
    <server>
      <id>releases</id>
      <username>admin</username>
      <password>admin123</password>
    </server>
    <server>
      <id>snapshots</id>
      <username>admin</username>
      <password>admin123</password>
    </server>
  </servers>

  <!-- jar 包下载地址 -->
  <mirrors>
    <mirror>
      <id>public</id>
      <mirrorOf>*</mirrorOf>
      <url>http://10.255.255.224:8081/repository/maven-public/</url>
    </mirror>
  </mirrors>

  <profiles>
    <profile>
      <id>zp</id>
      <repositories>
        <repository>
          <id>central</id>
          <url>http://central</url>
          <releases>
            <enabled>true</enabled>
          </releases>
          <snapshots>
            <enabled>true</enabled>
          </snapshots>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <id>central</id>
          <url>http://central</url>
          <releases>
            <enabled>true</enabled>
          </releases>
          <snapshots>
            <enabled>true</enabled>
            <updatePolicy>always</updatePolicy>
          </snapshots>
        </pluginRepository>
      </pluginRepositories>
    </profile>
  </profiles>

  <activeProfiles>
    <activeProfile>zp</activeProfile>
  </activeProfiles>
</settings>
```

### 配置 pom.xml

在 pom.xml 中添加如下配置：

```xml
  <distributionManagement>
    <repository>
      <id>releases</id>
      <name>Releases</name>
      <url>http://10.255.255.224:8081/repository/maven-releases</url>
    </repository>
    <snapshotRepository>
      <id>snapshots</id>
      <name>Snapshot</name>
      <url>http://10.255.255.224:8081/repository/maven-snapshots</url>
    </snapshotRepository>
  </distributionManagement>
```

> 注意：
>
> - `<repository>` 和 `<snapshotRepository>` 的 id 必须和 `settings.xml` 配置文件中的 `<server>` 标签中的 id 匹配。
> - `<url>` 标签的地址需要和 maven 私服的地址匹配。

### 执行 maven 构建

如果要使用 settings.xml 中的私服配置，必须通过指定 `-P zp` 来激活 profile。

示例：

```sh
# 编译并打包 maven 项目
$ mvn clean package -Dmaven.skip.test=true -P zp

# 编译并上传 maven 交付件（jar 包）
$ mvn clean deploy -Dmaven.skip.test=true -P zp
```

## 参考资料

- https://www.cnblogs.com/hoobey/p/6102382.html
- https://blog.csdn.net/wzygis/article/details/49276779
- https://blog.csdn.net/clj198606061111/article/details/52200928
