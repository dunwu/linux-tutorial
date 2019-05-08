# Jenkins 安装

> 环境要求
>
> - JDK：JDK7+，官网推荐是 JDK 8

<!-- TOC depthFrom:2 depthTo:3 -->

- [安装](#安装)
- [启动](#启动)
- [脚本](#脚本)
- [FAQ](#faq)
    - [登录密码](#登录密码)
    - [忘记密码](#忘记密码)
    - [卡在 check 页面](#卡在-check-页面)
    - [卡在 getting startted 页面](#卡在-getting-startted-页面)
- [参考资料](#参考资料)

<!-- /TOC -->

## 安装

安装步骤如下：

（1）下载并解压到本地

进入官网下载地址：https://jenkins.io/download/ ，选择合适的版本下载。

我选择的是最新稳定 war 版本 2.89.4：http://mirrors.jenkins.io/war-stable/latest/jenkins.war

我个人喜欢存放在：`/opt/software/jenkins`

```
mkdir -p /opt/software/jenkins
wget -O /opt/software/jenkins/jenkins.war http://mirrors.jenkins.io/war-stable/latest/jenkins.war
```

## 启动

如果你和我一样，选择 war 版本，那么你可以将 war 移到 Tomcat 的 webapps 目录下，通过 Tomcat 来启动。

当然，也可以通过 `java -jar` 方式来启动。

**启动 jenkins 服务**

```
cd /opt/software/jenkins
nohup java -jar jenkins.war --httpPort=8080 >> nohup.out 2>&1 &
```

## 脚本

| [安装脚本](https://github.com/dunwu/OS/tree/master/codes/deploy/tool/jenkins) |

## FAQ

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

<br><div align="center"><img src="images/jenkins-checking.png"/></div><br>

**原因**：jenkins 在安装插件前总是尝试连接 www.google.com，来判断网络是否连通。谷歌的网站在大陆是连不上的，所以会出现这个问题。

**解决方案**：执行`vim /root/.jenkins/updates/default.json`，将 `connectionCheckUrl` 后的 `www.google.com` 改为 `www.baidu.com` 。然后重启即可。

或者直接执行命令：

```sh
sed -i 's/www.google.com/www.baidu.com/g' /root/.jenkins/updates/default.json
```

### 卡在 getting startted 页面

**现象**：卡在 getting startted 页面

**原因**：jenkins 默认的插件下载服务器地址在国外，如果不翻墙下载不了。

**解决方案**：执行`vim /root/.jenkins/hudson.model.UpdateCenter.xml`，将 `<url>` 改为 `http://mirror.xmission.com/jenkins/updates/update-center.json` 。然后重启即可。

或者直接执行命令：

```sh
sed -i '/^<url>/s/.*/<url>http:\/\/mirror.xmission.com\/jenkins\/updates\/update-center.json<\/url>/g' /root/.jenkins/hudson.model.UpdateCenter.xml
```

## 更多内容

- **引申**
  - [操作系统、运维部署总结系列](https://github.com/dunwu/OS)
- **引用**
  - https://jenkins.io/doc/pipeline/tour/getting-started/
  - https://www.cnblogs.com/austinspark-jessylu/p/6894944.html
  - http://blog.csdn.net/jlminghui/article/details/54952148
