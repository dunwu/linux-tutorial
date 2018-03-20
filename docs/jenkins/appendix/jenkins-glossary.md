# Jenkins 术语

## 专业术语

### 持续集成

即 Continuous Integration (CI)。持续集成强调开发人员提交了新代码之后，立刻进行构建、（单元）测试。根据测试结果，我们可以确定新代码和原有代码能否正确地集成在一起。

### 持续交付

即 Continuous Delivery (CD)。持续交付在持续集成的基础上，将集成后的代码部署到更贴近真实运行环境的「类生产环境」（production-like environments）中。比如，我们完成单元测试后，可以把代码部署到连接数据库的 Staging 环境中更多的测试。如果代码没有问题，可以继续手动部署到生产环境中。

### 持续部署

即 Continuous Deployment。持续部署则是在持续交付的基础上，把部署到生产环境的过程自动化。

## 关键字

### Agent

Agent通常是一个机器或容器，它连接到Jenkins主机，并在主控器指导时执行任务。

### Artifact

在Build或Pipeline 运行期间生成的不可变文件，该文件归档到Jenkins Master上以供用户随后检索。

### Build

项目 单次执行的结果

### Cloud

提供动态代理 配置和分配的系统配置，例如由Azure VM Agents 或 Amazon EC2插件提供的配置和分配 。

### Core

主要的Jenkins应用程序（jenkins.war）提供了 可以构建Plugins的基本Web UI，配置和基础。

### Downstream

配置Pipeline或项目时被触发作为一个单独的Pipeline或项目的执行的一部分。

### Executor

用于执行由节点上的Pipeline或项目定义的工作的插槽。节点可以具有零个或多个配置的执行器，其对应于在该节点上能够执行多少并发项目或Pipeline。

### Fingerprint

考虑全局唯一性的哈希追踪跨多个Pipeline或项目的工件或其他实体的使用。

### Folder

类似于文件系统上的文件夹的Pipeline和/或项目的组织容器。

### Item

Web UI中的实体对应于：Folder, Pipeline, or Project.

### Job

一个不推荐的术语，与项目同义。

### Label

用于分组代理的用户定义的文本，通常具有类似的功能或功能。例如linux对于基于Linux的代理或 docker适用于支持Docker的代理。

### Master

存储配置，加载插件以及为Jenkins呈现各种用户界面的中央协调过程。

### Node

作为Jenkins环境的一部分并能够执行Pipeline或项目的机器。无论是the Master还是Agents都被认为是Nodes。

### Project

用户配置的Jenkins应该执行的工作描述，如构建软件等。

### Pipeline

用户定义的连续输送Pipeline模型，以便更多阅读本手册中的“ Pipeline”一章。

### Plugin

与Jenkins Core分开提供的Jenkins功能扩展。

### Publisher

完成发布报告，发送通知等的所有配置步骤后的构建的一部分。

### Stage

stage是Pipeline的一部分，用于定义整个Pipeline的概念上不同的子集，例如：“构建”，“测试”和“部署”，许多插件用于可视化或呈现Jenkins Pipeline状态/进度。

### Step

单一任务从根本上讲，指的是Jenkins 在Pipeline或项目中做了什么。

### Trigger

触发新Pipeline运行或构建的标准。

### Update Center

托管插件和插件元数据的库存，以便在Jenkins内部进行插件安装。

### Upstream

配置的Pipeline或项目，其触发单独的Pipeline或项目作为其执行的一部分。

### Workspace

Noede文件系统上的一次性目录， 可以由Pipeline或项目完成工作。在Build或 Pipeline运行完成后，工作区通常会保留原样，除非在Jenkins Master上已经设置了特定的Workspace清理策略。