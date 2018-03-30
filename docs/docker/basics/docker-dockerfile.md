# Dockerfile

## 格式

Dockerfile 中，对于指令不区分大小写，但是推荐使用大写，来区别于参数。

Dockerfile 中，将按照指令（instruction）出现次序依次执行。**注意：Dockerfile 必须从 `FROM` 指令开始。**

Dockerfile 中，将 `#` 开头的行作为注释，除非该行是有效的解析指令（parser directives）。一行中的 `#` 标记被视为参数。注释中不支持换行符。

示例：

```
# Comment
RUN echo 'we are running some # of cool things'
```

## 解析指令（parser directives）

解析指令是可选的，并且会影响 Dockerfile 中后续行的处理方式。解析指令不会将图层添加到构建中，并且不会显示为构建步骤。解析指令以 `# directive=value` 的形式写入特殊类型的注释。单个指令只能使用一次。

一旦注释，空行或构建指令已被处理，Docker 不再查找解析指令。相反，它将任何符合解析指令格式的内容视为注释，不会尝试验证它是否可能是解析指令。因此，所有解析指令都必须位于Dockerfile 的最顶端。

解析指令不区分大小写。但是，约定是小写。约定还包括在任何解析指令之后的空白行。解析指令不支持续行符。

以下列举几个不合规范的示例。

因为续行符而无效：

```
# direc \
tive=value
```

因为出现两次解析指令而无效：

```
# directive=value1
# directive=value2

FROM ImageName
```

解析指令由于出现在构建指令后，而被视为注释：

```
FROM ImageName
# directive=value
```

解析指令由于出现在注释后，而被视为注释：

```
# About my dockerfile
# directive=value
FROM ImageName
```

因为无法识别，未知的指令被视为注释。此外，因为前一个未知指定被视为注释，后一个指令相当于出现在注释后，而也被视为了注释：

```
# unknowndirective=value
# knowndirective=value
```

解析器指令中允许使用非分行空白。因此，以下几行都是一致对待的：

```
#directive=value
# directive =value
#	directive= value
# directive = value
#	  dIrEcTiVe=value
```

### escape

```
# escape=\ (backslash)
```

```
# escape=` (backtick)
```

在 Dockerfile 中，