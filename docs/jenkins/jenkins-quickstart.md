<!-- TOC -->

- [Jenkins 快速指南](#jenkins-%E5%BF%AB%E9%80%9F%E6%8C%87%E5%8D%97)
    - [概念](#%E6%A6%82%E5%BF%B5)
        - [Pipeline](#pipeline)
        - [Jenkinsfile](#jenkinsfile)
    - [创建 Pipeline](#%E5%88%9B%E5%BB%BA-pipeline)
        - [Jenkinsfile 简单实例](#jenkinsfile-%E7%AE%80%E5%8D%95%E5%AE%9E%E4%BE%8B)
    - [运行多步骤](#%E8%BF%90%E8%A1%8C%E5%A4%9A%E6%AD%A5%E9%AA%A4)
        - [简单实例](#%E7%AE%80%E5%8D%95%E5%AE%9E%E4%BE%8B)
            - [Linux, BSD, and Mac OS](#linux-bsd-and-mac-os)
            - [Windows](#windows)
            - [Timeouts, retries and more](#timeouts-retries-and-more)
            - [整理](#%E6%95%B4%E7%90%86)
    - [定义执行环境](#%E5%AE%9A%E4%B9%89%E6%89%A7%E8%A1%8C%E7%8E%AF%E5%A2%83)

<!-- /TOC -->

# Jenkins 快速指南

## 概念

### Pipeline

[Pipeline](https://jenkins.io/doc/book/pipeline/) 是一套插件，用来支持在 Jenkins 中实现和集成持续交付通道。

持续交付渠道是您从软件版本控制到用户和客户流程的自动化表达。

Pipeline 提供了一组可扩展的工具，通过 [Pipeline DSL](https://jenkins.io/doc/book/pipeline/syntax) 将“简单到复杂”的交付管道“作为代码”建模。

### Jenkinsfile

Jenkins Pipeline 的定义通常写入一个文本文件，称为 Jenkinsfile，该文件又被检入到项目的源代码控制库中。

## 创建 Pipeline

1. 在代码仓库中创建 `Jenkinsfile`，内容参考 [Jenkinsfile 简单实例](#jenkinsfile-%E7%AE%80%E5%8D%95%E5%AE%9E%E4%BE%8B)。

2. 点击 Jenkins 菜单中的**新建（New Item）**按钮。

3. 输入一个任务名称并选择 **Multibranch Pipeline**

4. 点击**增加源（Add Source）**按钮，选择代码仓库类型。

5. 点击**保存（Save）**按钮，然后观察第一个 Pipeline 运行。

### Jenkinsfile 简单实例

**Java**

```
pipeline {
    agent { docker { image 'maven:3.3.3' } }
    stages {
        stage('build') {
            steps {
                sh 'mvn --version'
            }
        }
    }
}
```

**Node.js / JavaScript**

```
pipeline {
    agent { docker { image 'node:6.3' } }
    stages {
        stage('build') {
            steps {
                sh 'npm --version'
            }
        }
    }
}
```

**Ruby**

```
pipeline {
    agent { docker { image 'ruby' } }
    stages {
        stage('build') {
            steps {
                sh 'ruby --version'
            }
        }
    }
}
```

**Python**

```
pipeline {
    agent { docker { image 'python:3.5.1' } }
    stages {
        stage('build') {
            steps {
                sh 'python --version'
            }
        }
    }
}
```

**PHP**

```
pipeline {
    agent { docker { image 'php' } }
    stages {
        stage('build') {
            steps {
                sh 'php --version'
            }
        }
    }
}
```

## 运行多步骤

Pipelines 由多个步骤组成，允许您构建、测试和部署应用程序。Jenkins Pipeline 允许您以简单的方式撰写多个步骤，可以帮助您对任何类型的自动化过程建模。

想象一个“步骤”就像执行单个动作的单个命令一样。当一个步骤成功时，它将转到下一步。当一个步骤未能正确执行时，Pipeline 将失败。

当 Pipeline 中的所有步骤都成功完成， Pipeline 就被视作执行成功。

### 简单实例

#### Linux, BSD, and Mac OS

在 Linux，BSD 和 Mac OS（Unix-like）系统中，`sh` 步骤用于在管道中执行 shell 命令。

```
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'echo "Hello World"'
                sh '''
                    echo "Multiline shell steps works too"
                    ls -lah
                '''
            }
        }
    }
}
```

#### Windows

基于 Windows 的系统应该使用 `bat` 步骤来执行批处理命令。

```
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                bat 'set'
            }
        }
    }
}
```

#### Timeouts, retries and more

有一些有用的步骤可以“包装”其他步骤，这些步骤可以轻松解决复杂问题，例如重试（`retry`）步骤直至成功或退出步骤需要很长时间（`timeout`）。

```
pipeline {
    agent any
    stages {
        stage('Deploy') {
            steps {
                retry(3) {
                    sh './flakey-deploy.sh'
                }

                timeout(time: 3, unit: 'MINUTES') {
                    sh './health-check.sh'
                }
            }
        }
    }
}
```

`Deploy` 阶段重试 flakey-deploy.sh 脚本 3 次，然后等待最多 3 分钟执行 health-check.sh 脚本。如果运行状况检查脚本在 3 分钟内未完成，管道将在“部署”阶段被标记为失败。

子步骤（如 `retry` 和 `timeout`）可能包含其他步骤，包括 `retry` 或 `timeout`。

我们可以组合这些步骤。例如，如果我们想重试我们的部署 5 次，但从未想过总共花费超过3分钟，然后才能进入阶段：

```
pipeline {
    agent any
    stages {
        stage('Deploy') {
            steps {
                timeout(time: 3, unit: 'MINUTES') {
                    retry(5) {
                        sh './flakey-deploy.sh'
                    }
                }
            }
        }
    }
}
```

#### 整理

当管道完成执行时，您可能需要运行清理步骤或根据管道的结果执行一些操作。这些操作可以在 post 部分中执行。

```
pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                sh 'echo "Fail!"; exit 1'
            }
        }
    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if successful'
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }
    }
}
```

## 定义执行环境

在上一节中，您可能已经注意到每个示例中的 agent 指令。agent 指令告诉 Jenkins 在哪里以及如何执行 Pipeline 或其子集。正如您所预料的那样，所有 Pipeline 都需要 `agent`。

在引擎盖下面，代理原因发生了一些事情：

* 块中包含的所有步骤均由 Jenkins 排队等待执行。只要执行者可用，这些步骤就会开始执行。
* 将分配一个工作空间，该工作空间将包含从源代码管理检出的文件以及 Pipeline 的任何其他工作文件。

Pipeline 旨在轻松使用 Docker 镜像和容器在内部运行。这允许 Pipeline 定义所需的环境和工具，而无需手动配置各种系统工具和代理依赖关系。这种方法使您可以使用任何可以打包在 Docker 容器中的工具。