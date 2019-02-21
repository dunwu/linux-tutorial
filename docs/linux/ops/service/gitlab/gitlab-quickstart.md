# Gitlab 快速教程

> 准备
>
> Git - 如果不熟悉 Git ，可以先阅读：[Git 教程](https://github.com/dunwu/OS/tree/master/docs/git)

## 创建你的 SSH key

1. 使用 Gitlab 的第一步是生成你自己的 SSH 密钥对（Github 也类似）。

2. 登录 Gitlab

3. 打开 **Profile settings**.

   ![Profile settings dropdown](https://docs.gitlab.com/ce/gitlab-basics/img/profile_settings.png)

4. 跳转到 **SSH keys** tab 页

   ![SSH Keys](https://docs.gitlab.com/ce/gitlab-basics/img/profile_settings_ssh_keys.png)

5. 黏贴你的 SSH 公钥内容到 Key 文本框

   ![Paste SSH public key](https://docs.gitlab.com/ce/gitlab-basics/img/profile_settings_ssh_keys_paste_pub.png)

6. 为了便于识别，你可以为其命名

   ![SSH key title](https://docs.gitlab.com/ce/gitlab-basics/img/profile_settings_ssh_keys_title.png)

7. 点击 **Add key** 将 SSH 公钥添加到 GitLab

   ![SSH key single page](https://docs.gitlab.com/ce/gitlab-basics/img/profile_settings_ssh_keys_single_key.png)

## 创建项目

![](http://dunwu.test.upcdn.net/snap/20190131150658.png)

输入项目信息，点击 Create project 按钮，在 Gitlab 创建项目。

![](http://dunwu.test.upcdn.net/snap/20190131150759.png)

## 克隆项目到本地

可以选择 SSH 或 HTTPS 方式克隆项目到本地（推荐 SSH）

拷贝项目地址，然后在本地执行 `git clone <url>`

![1548919326929](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\1548919326929.png)

## 创建 Issue

依次点击 **Project’s Dashboard** > **Issues** > **New Issue** 可以新建 Issue

![New issue from the issue list view](https://docs.gitlab.com/ce/user/project/issues/img/new_issue_from_tracker_list.png)

在项目中直接添加 issue

![New issue from the issues list](https://docs.gitlab.com/ce/user/project/issues/img/new_issue.png)

在未关闭 issue 中，点击 **New Issue** 添加 issue

![New issue from an open issue](https://docs.gitlab.com/ce/user/project/issues/img/new_issue_from_open_issue.png)

通过项目面板添加 issue

![New issue from a project's dashboard](https://docs.gitlab.com/ce/user/project/issues/img/new_issue_from_projects_dashboard.png)

通过 issue 面板添加 issue

![From the issue board](https://docs.gitlab.com/ce/user/project/issues/img/new_issue_from_issue_board.png)

## 引申和引用

- **引申**
  - [操作系统、运维部署总结系列](https://github.com/dunwu/OS)
- **引用**
  - [官网](https://about.gitlab.com/)
