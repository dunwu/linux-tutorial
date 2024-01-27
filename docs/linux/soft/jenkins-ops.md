# Jenkins 运维

> 环境要求
>
> - JDK：JDK7+，官网推荐是 JDK 8
> - Jenkins：2.190.1

## Jenkins 简介

### Jenkins 是什么

Jenkins 是一款开源 CI&CD 软件，用于自动化各种任务，包括构建、测试和部署软件。

Jenkins 支持各种运行方式，可通过系统包、Docker 或者通过一个独立的 Java 程序。

### CI/CD 是什么

CI(Continuous integration，中文意思是持续集成)是一种软件开发时间。持续集成强调开发人员提交了新代码之后，立刻进行构建、（单元）测试。根据测试结果，我们可以确定新代码和原有代码能否正确地集成在一起。借用网络图片对 CI 加以理解。

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20200310174528.png)

CD(Continuous Delivery， 中文意思持续交付)是在持续集成的基础上，将集成后的代码部署到更贴近真实运行环境(类生产环境)中。比如，我们完成单元测试后，可以把代码部署到连接数据库的 Staging 环境中更多的测试。如果代码没有问题，可以继续手动部署到生产环境。下图反应的是 CI/CD 的大概工作模式。

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20200310174544.png)

## Jenkins 安装

> 更详细内容请参考：[Jenkins 官方安装文档](https://jenkins.io/zh/doc/book/installing/)

### War 包部署

安装步骤如下：

（1）下载并解压到本地

进入[官网下载地址](https://jenkins.io/zh/download/)，选择合适的版本下载。

我选择的是最新稳定 war 版本 2.89.4：http://mirrors.jenkins.io/war-stable/latest/jenkins.war

我个人喜欢存放在：`/opt/software/jenkins`

```bash
mkdir -p /opt/software/jenkins
wget -O /opt/software/jenkins/jenkins.war http://mirrors.jenkins.io/war-stable/latest/jenkins.wa
```

（2）启动

如果你和我一样，选择 war 版本，那么你可以将 war 移到 Tomcat 的 webapps 目录下，通过 Tomcat 来启动。

当然，也可以通过 `java -jar` 方式来启动。

```bash
cd /opt/software/jenkins
nohup java -jar jenkins.war --httpPort=8080 >> nohup.out 2>&1 &
```

### rpm 包部署

（1）下载安装

```bash
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins
```

（2）启动

```bash
systemctl start jenkins
```

### 访问

1. 打开浏览器进入链接 `http://localhost:8080`.
2. 按照说明完成安装.

## Jenkins 基本使用

Jenkins 是一个强大的 CI 工具，虽然本身使用 Java 开发，但也能用来做其他语言开发的项目 CI。下面讲解如何使用 Jenkins 创建一个构建任务。

登录 Jenkins， 点击左侧的新建，创建新的构建任务。

![img](https:////upload-images.jianshu.io/upload_images/6464255-22b3c49af599565d.png?imageMogr2/auto-orient/strip|imageView2/2/w/374/format/webp)

跳转到如下界面。任务名称可以自行设定，但需要全局唯一。输入名称后选择构建一个自由风格的软件项目(其他选项不作介绍)。并点击下方的确定按钮即创建了一个构建任务。之后会自动跳转到该 job 的配置页面。

![img](https:////upload-images.jianshu.io/upload_images/6464255-0febc0bc4ca3cadd.png?imageMogr2/auto-orient/strip|imageView2/2/w/1044/format/webp)

新建自由风格的软件项目

下图是构建任务设置界面，可以看到上方的几个选项**"General", "源码管理"， "构建触发器"，"构建环境"， "构建"， "构建后操作"**。下面逐一介绍。

![img](https:////upload-images.jianshu.io/upload_images/6464255-77998a3e6a70b83f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1032/format/webp)

### General

General 是构建任务的一些基本配置。名称，描述之类的。

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20200310221814.png)

重要配置项：

- **Description**：对构建任务的描述。
- **Discard old builds**：服务器资源是有限的，有时候保存了太多的历史构建，会导致 Jenkins 速度变慢，并且服务器硬盘资源也会被占满。当然下方的"保持构建天数" 和 保持构建的最大个数是可以自定义的，需要根据实际情况确定一个合理的值。

点击右方的问号图标可以查看帮助信息。

### Source Code Management

**Source Code Management**，即源码管理，就是配置你代码的存放位置。

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20200310222110.png)

- **Git:** 支持主流的 Github 和 Gitlab 代码仓库。因我们的研发团队使用的是 gitlab，所以下面我只会对该项进行介绍。
- **Repository URL**：仓库地址。
- **Credentials**：凭证。可以使用 HTTP 方式的用户名密码，也可以是 RSA 文件。 但要通过后面的"ADD"按钮添加凭证。
- **Branches to build**：构建的分支。`*/master` 表示 master 分支，也可以设置为其他分支。
- **Repository browser**：你所使用的代码仓库管理工具，如 Github、Gitlab.
- **Subversion**：即 SVN，这里不作介绍。

### Build Triggers

**Build Triggers**，即构建触发器，用于构建任务的触发器。

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20200310222608.png)

配置说明：

- **Trigger builds remotely (e.g., from scripts)**：触发远程构建(例如，使用脚本)。该选项会提供一个接口，可以用来在代码层面触发构建。
- **Build after other projects are built**：该选项意思是"在其他项目构建后再构建"。
- **Build periodically**：周期性的构建。就是每隔一段时间进行构建。日程表类似 linux crontab 书写格式。如：`H/30 * * * *`，表示每隔 30 分钟进行一次构建。
- **Build when a change is pushed to GitLab：**当有 git push 到 Gitlab 仓库，即触发构建。后面会有一个触发构建的地址，一般被称为 webhooks。需要将这个地址配置到 gitlab 中，webhooks 如何配置后面介绍。这个是常用的构建触发器。
- **Poll SCM：**该选项是配合上面这个选项使用的。当代码仓库发生改动，jenkins 并不知道。需要配置这个选项，周期性的去检查代码仓库是否发生改动。

### Build Environment

**Build Environment**，即构建环境，配置构建前的一些准备工作，如指定构建工具。

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20200310223004.png)

### Build

Build，即构建。

点击下图中的 Add build step 按钮，会弹出一个构建任务菜单，可以根据实际需要来选择。

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20200310223241.png)

【说明】

- **Copy artifacts from another project**：从其他项目获取构建。一般当本任务有上游任务，需要获取上游任务的构件时使用。比如：有个 Java Web 项目，需要依赖于上一个前端构建任务输出的静态文件压缩包。
- Eexcute NodeJS script：执行 Nodejs 脚本。默认支持 nodejs、npm 命令。
- **Eexcute shell**： 执行 shell 脚本。用于 Linux 环境。
- **Execute Windows batch command**：执行 batch 脚本。用于 Windows 环境。
- **Invoke Ant**：Ant 是一款 java 项目构建工具。
- **Invoke Gradle script**：Gradle 构建项目。
- **Invoke top-level Maven targets**：Maven 构建项目。

### Post-build Actions

**Post-build Actions**，即构建后操作，用于构建完本项目的一些后续操作，比如生成相应的代码测试报告。

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20200310224106.png)

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20200310224254.png)

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20200310224331.png)

个人较常用的配置：

- **Archive the artifacts**：归档构件。
- **Build other projects**：构建其他项目。
- **Trigger parameterized build on other projects**：构建其他项目，并传输构建参数。
- **Publish JUnit test result report**：发布 Junit 测试报告。
- **E-mail Notification**：邮件通知，构建完成后发邮件到指定的邮箱。

---

**以上配置完成后，点击保存即可。**

### 开始构建

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20200310224927.png)

如上图所示，一切配置好后，即可点击 **Build Now** 开始构建。

### 构建结果

![img](https://raw.githubusercontent.com/dunwu/images/master/snap/20200310225234.png)

- **构建状态**
  - **Successful 蓝色**：构建完成，并且被认为是稳定的。
  - **Unstable 黄色**：构建完成，但被认为是不稳定的。
  - **Failed 红色**：构建失败。
  - **Disable 灰色**：构建已禁用
- **构建稳定性**
  - 构建稳定性用天气表示：**晴、晴转多云、多云、小雨、雷阵雨**。天气越好表示构建越稳定，反之亦然。
- 构建历史界面
  - **console output**：输出构建的日志信息

## 其他相关配置

### SSH Server 配置

登录 jenkins -> 系统管理 -> 系统设置

配置请看下图：

![img](https:////upload-images.jianshu.io/upload_images/6464255-15476f9e273daa58.png?imageMogr2/auto-orient/strip|imageView2/2/w/1108/format/webp)

重要配置：

- **SSH Servers:** 由于 jenkins 服务器公钥文件我已经配置好，所以之后新增 SSH Servers 只需要配置这一项即可。
- **Name：** 自定义，需要全局唯一。

- **HostName:** 主机名，直接用 ip 地址即可。

- **Username:** 新增 Server 的用户名，这里配置的是 root。

- **Remote Directory:** 远程目录。jenkins 服务器发送文件给新增的 server 默认是在这个目录。

### 配置 Gitlab webhooks

在 gitlab 的 project 页面 打开**settings**，再打开 **web hooks** 。点击**"ADD WEB HOOK"** 添加 webhook。把之前 jenkins 配置中的那个 url 添加到这里，添加完成后，点击**"TEST HOOK"**进行测试，如果显示 SUCCESS 则表示添加成功。

![img](https:////upload-images.jianshu.io/upload_images/6464255-9f8d04a1400556f9.png?imageMogr2/auto-orient/strip|imageView2/2/w/246/format/webp)

![img](https:////upload-images.jianshu.io/upload_images/6464255-154a62db330c819b.png?imageMogr2/auto-orient/strip|imageView2/2/w/240/format/webp)

![img](https:////upload-images.jianshu.io/upload_images/6464255-e4d1ea1e1dbde812.png?imageMogr2/auto-orient/strip|imageView2/2/w/1036/format/webp)

![img](https:////upload-images.jianshu.io/upload_images/6464255-c7a687207b2c26fc.png?imageMogr2/auto-orient/strip|imageView2/2/w/1106/format/webp)

![img](https:////upload-images.jianshu.io/upload_images/6464255-ce8ae810bc2cb0d4.png?imageMogr2/auto-orient/strip|imageView2/2/w/1154/format/webp)

配置 phpunit.xml

phpunit.xml 是 phpunit 这个工具用来单元测试所需要的配置文件。这个文件的名称同样也是可以自定义的，但是要在"build.xml"中配置好名字就行。默认情况下，用"phpunit.xml", 则不需要在"build.xml"中配置文件名。

![img](https:////upload-images.jianshu.io/upload_images/6464255-aa212d3b3eaff548.png?imageMogr2/auto-orient/strip|imageView2/2/w/798/format/webp)

build.xml 中 phpunit 配置

fileset dir 指定单元测试文件所在路径，include 指定包含哪些文件，支持通配符匹配。当然也可以用 exclude 关键字指定不包含的文件。

![img](https:////upload-images.jianshu.io/upload_images/6464255-dbc0084f6d50a240.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

### jenkins 权限管理

由于 jenkins 默认的权限管理体系不支持用户组或角色的配置，因此需要安装第三发插件来支持角色的配置，本文将使用 Role Strategy Plugin。基于这个插件的权限管理设置请参考这篇文章:[http://blog.csdn.net/russ44/article/details/52276222](https://link.jianshu.com?t=http%3A%2F%2Fblog.csdn.net%2Fruss44%2Farticle%2Fdetails%2F52276222)，这里不作详细介绍。

至此，就可以用 jenkins 周而复始的进行 CI 了，当然 jenkins 是一个强大的工具，功能绝不仅仅是以上这些，其他方面要是以后用到，我会更新到这篇文章中。有疑问欢迎在下方留言。

## Jenkins FAQ

### 登录密码

如果不知道初始登录密码，可以通过以下方式查看：

执行命令 `cat /root/.jenkins/secrets/initialAdminPassword`，打印出来的即是初始登录密码。

### 忘记密码

1.执行 `vim /root/.jenkins/config.xml` ，删除以下内容

```xml
<useSecurity>true</useSecurity>
<authorizationStrategy class="hudson.security.FullControlOnceLoggedInAuthorizationStrategy">
  <denyAnonymousReadAccess>true</denyAnonymousReadAccess>
</authorizationStrategy>
<securityRealm class="hudson.security.HudsonPrivateSecurityRealm">
  <disableSignup>true</disableSignup>
  <enableCaptcha>false</enableCaptcha>
</securityRealm>
```

2.重启 Jenkins 服务；

3.进入首页>“系统管理”>“Configure Global Security”；

4.勾选“启用安全”；

5.点选“Jenkins 专有用户数据库”，并点击“保存”；

6.重新点击首页>“系统管理”,发现此时出现“管理用户”；

7.点击进入展示“用户列表”；

8.点击右侧进入修改密码页面，修改后即可重新登录。

### 卡在 check 页面

**现象**：输入密码后，卡在 check 页面

**原因**：jenkins 在安装插件前总是尝试连接 www.google.com，来判断网络是否连通。谷歌的网站在大陆是连不上的，所以会出现这个问题。

**解决方案**：执行`vim /root/.jenkins/updates/default.json`，将 `connectionCheckUrl` 后的 `www.google.com` 改为 `www.baidu.com` 。然后重启即可。

或者直接执行命令：

```bash
sed -i 's/www.google.com/www.baidu.com/g' /root/.jenkins/updates/default.json
```

### 卡在 getting startted 页面

**现象**：卡在 getting startted 页面

**原因**：jenkins 默认的插件下载服务器地址在国外，如果不翻墙下载不了。

**解决方案**：执行`vim /root/.jenkins/hudson.model.UpdateCenter.xml`，将 `<url>` 改为 `http://mirror.xmission.com/jenkins/updates/update-center.json` 。然后重启即可。

或者直接执行命令：

```bash
sed -i '/^<url>/s/.*/<url>http:\/\/mirror.xmission.com\/jenkins\/updates\/update-center.json<\/url>/g' /root/.jenkins/hudson.model.UpdateCenter.xml
```

### 以 root 用户运行

（1）修改 jenkins 用户

```bash
vim /etc/sysconfig/jenkins
```

修改用户

```bash
$JENKINS_USER="root"
```

（2）修改 `Jenkins` 相关文件夹用户权限

```bash
chown -R root:root /var/lib/jenkins
chown -R root:root /var/cache/jenkins
chown -R root:root /var/log/jenkins
```

（3）重启 Jenkins

```
systemctl restart jenkins
```

## 参考资料

- **官方**

  - [Jenkins 官网](https://jenkins.io/zh/)
  - [Jenkins 中文文档](https://jenkins.io/zh/doc/tutorials/)

- **引申**
  - [操作系统、运维部署总结系列](https://github.com/dunwu/OS)
- **文章**
  - https://jenkins.io/doc/pipeline/tour/getting-started/
  - https://www.cnblogs.com/austinspark-jessylu/p/6894944.html
  - http://blog.csdn.net/jlminghui/article/details/54952148
  - [Jenkins 详细教程](https://www.jianshu.com/p/5f671aca2b5a)
