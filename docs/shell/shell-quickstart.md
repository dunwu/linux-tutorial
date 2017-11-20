# Shell 快速指南

![image.png](http://upload-images.jianshu.io/upload_images/3101171-4b6e2a6b64bb4722.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 概述

Bash 是一个 Unix Shell，作为 [Bourne shell](https://en.wikipedia.org/wiki/Bourne_shell) 的 free software 替代品，由 [Brian Fox](https://en.wikipedia.org/wiki/Brian_Fox_(computer_programmer)) 为GNU项目编写。它发布于1989年，在很长一段时间，Linux 系统和 macOS 系统都把 Bash 作为默认的 shell。

那么，我们学习这个有着30多年历史的东西意义何在呢？答案很简单：这是当今最强大、可移植性最好的，为所有基于 Unix 的系统编写高效率脚本的工具之一。这就是你需要学习 bash 的原因。

## Shells与模式

bash shell有交互和非交互两种模式。

### 交互模式

Ubuntu用户都知道，在Ubuntu中有7个虚拟终端。 桌面环境接管了第7个虚拟终端，于是按下`Ctrl-Alt-F7`，可以进入一个操作友好的图形用户界面。

即便如此，还是可以通过`Ctrl-Alt-F1`，来打开shell。打开后，熟悉的图形用户界面消失了，一个虚拟终端展现出来。

看到形如下面的东西，说明shell处于交互模式下：

```
user@host:~$

```

接着，便可以输入一系列Unix命令，比如`ls`，`grep`，`cd`，`mkdir`，`rm`，来看它们的执行结果。

之所以把这种模式叫做交互式，是因为shell直接与用户交互。

直接使用虚拟终端其实并不是很方便。设想一下，当你想编辑一个文档，与此同时又想执行另一个命令，这种情况下，下面的虚拟终端模拟器可能更适合：

- [GNOME Terminal](https://en.wikipedia.org/wiki/GNOME_Terminal)
- [Terminator](https://en.wikipedia.org/wiki/Terminator_(terminal_emulator))
- [iTerm2](https://en.wikipedia.org/wiki/ITerm2)
- [ConEmu](https://en.wikipedia.org/wiki/ConEmu)

### 非交互模式

在非交互模式下，shell从文件或者管道中读取命令并执行。当shell解释器执行完文件中的最后一个命令，shell进程终止，并回到父进程。

可以使用下面的命令让shell以非交互模式运行：

```
sh /path/to/script.sh
bash /path/to/script.sh

```

上面的例子中，`script.sh`是一个包含shell解释器可以识别并执行的命令的普通文本文件，`sh`和`bash`是shell解释器程序。你可以使用任何喜欢的编辑器创建`script.sh`（vim，nano，Sublime Text, Atom等等）。

除此之外，你还可以通过`chmod`命令给文件添加可执行的权限，来直接执行脚本文件：

```
chmod +x /path/to/script.sh

```

这种方式要求脚本文件的第一行必须指明运行该脚本的程序，比如：

```
#!/bin/bash
echo "Hello, world!"
```

如果你更喜欢用`sh`，把`#!/bin/bash`改成`#!/bin/sh`即可。`#!`被称作[shebang](https://zh.wikipedia.org/wiki/Shebang)。之后，就能这样来运行脚本了：

```
/path/to/script.sh

```

上面的例子中，我们使用了一个很有用的命令`echo`来输出字符串到屏幕上。

我们还可以这样来使用shebang：

```
#!/usr/bin/env bash
echo "Hello, world!"
```

这样做的好处是，系统会自动在`PATH`环境变量中查找你指定的程序（本例中的`bash`）。相比第一种写法，你应该尽量用这种写法，因为程序的路径是不确定的。这样写还有一个好处，操作系统的`PATH`变量有可能被配置为指向程序的另一个版本。比如，安装完新版本的`bash`，我们可能将其路径添加到`PATH`中，来“隐藏”老版本。如果直接用`#!/bin/bash`，那么系统会选择老版本的`bash`来执行脚本，如果用`#!/usr/bin/env bash`，则会使用新版本。

### 返回值

每个命令都有一个**返回值**（**返回状态**或者**退出状态**）。命令执行成功的返回值总是`0`（零值），执行失败的命令，返回一个非0值（错误码）。错误码必须是一个1到255之间的整数。

在编写脚本时，另一个很有用的命令是`exit`。这个命令被用来终止当前的执行，并把返回值交给shell。当`exit`不带任何参数时，它会终止当前脚本的执行并返回在它之前最后一个执行的命令的返回值。

一个程序运行结束后，shell将其**返回值**赋值给`$?`环境变量。因此`$?`变量通常被用来检测一个脚本执行成功与否。

与使用`exit`来结束一个脚本的执行类似，我们可以使用`return`命令来结束一个函数的执行并将**返回值**返回给调用者。当然，也可以在函数内部用`exit`，这 *不但* 会中止函数的继续执行，*而且* 会终止整个程序的执行。

## Shell 编程

在 bash 脚本文件中的第一行被叫做 `shebang`。这一行决定了脚本可以像一个独立的可执行文件一样执行，而不用在终端之前输入`sh`, `bash`, `python`, `php`等。

```
#!/bin/bash
```

### 注释

脚本中可以包含 注释。注释是特殊的语句，会被 shell 解释器忽略。它们以 `#` 开头，到行尾结束。

示例：

```bash
#!/bin/bash
### This script will print your username.
whoami
```

> **Tip**: 用注释来说明你的脚本是干什么的，以及为什么这样写。

### 变量

跟许多程序设计语言一样，你可以在 bash 中创建变量。

Bash 中没有数据类型，bash 中的变量可以保存一个数字、一个字符、一个字符串等等。同时无需提前声明变量，给变量赋值会直接创建变量。

你可以创建三种变量：**局部变量**，**环境变量**以及作为**位置参数**的变量。

#### 局部变量

**局部变量**是仅在某个脚本内部有效的变量。它们不能被其他的程序和脚本访问。

局部变量可以用 `=` 声明（作为一种约定，变量名、`=`、变量的值之间**不应该**有空格），其值可以用`$` 访问到。举个例子：

```bash
username="zhangpeng"  ### 声明变量
echo $username          ### 输出变量的值
unset username          ### 删除变量
```

我们可以用 `local` 关键字声明属于某个函数的局部变量。这样声明的变量会在函数结束时消失。

```bash
local local_var="I'm a local value"
```

#### 环境变量

**环境变量**是对当前 shell 会话内所有的程序或脚本都可见的变量。创建它们跟创建局部变量类似，但使用的是 `export` 关键字。

```bash
export GLOBAL_VAR="I'm a global value"
```

bash 中有非常多的环境变量。你会非常频繁地遇到它们，这里有一张速查表，记录了在实践中最常见的环境变量。

| 变量        | 描述                          |
| --------- | --------------------------- |
| `$HOME`   | 当前用户的用户目录                   |
| `$PATH`   | 用分号分隔的目录列表，shell会到这些目录中查找命令 |
| `$PWD`    | 当前工作目录                      |
| `$RANDOM` | 0到32767之间的整数                |
| `$UID`    | 数值类型，当前用户的用户ID              |
| `$PS1`    | 主要系统输入提示符                   |
| `$PS2`    | 次要系统输入提示符                   |

[这里](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html###sect_03_02_04) 有一张更全面的 Bash 环境变量列表。

#### 位置参数

**位置参数**是在调用一个函数并传给它参数时创建的变量。下表列出了在函数中，位置参数变量和一些其它的特殊变量以及它们的意义。

| 变量             | 描述                |
| -------------- | ----------------- |
| `$0`           | 脚本名称              |
| `$1 … $9`      | 第1个到第9个参数列表       |
| `${10} … ${N}` | 第10个到N个参数列表       |
| `$*` or `$@`   | 除了`$0`外的所有位置参数    |
| `$#`           | 不包括`$0`在内的位置参数的个数 |
| `$FUNCNAME`    | 函数名称（仅在函数内部有值）    |

在下面的例子中，位置参数为：`$0='./script.sh'`，`$1='foo'`，`$2='bar'`：

```bash
$ ./script.sh foo bar
```

变量可以有**默认值**。我们可以用如下语法来指定默认值：

```bash
### 如果变量为空，赋给他们默认值
: ${VAR:='default'}
: ${1:='first'}
echo "\$1 : " $1
: ${2:='second'}
echo "\$2 : " $2

### 或者
FOO=${FOO:-'default'}
```

### Shell扩展

*扩展* 发生在一行命令被分成一个个的 *记号（tokens）* 之后。换言之，扩展是一种执行数学运算的机制，还可以用来保存命令的执行结果，等等。

感兴趣的话可以阅读[关于shell扩展的更多细节](https://www.gnu.org/software/bash/manual/bash.html###Shell-Expansions)。

#### 大括号扩展

大括号扩展让生成任意的字符串成为可能。它跟 *文件名扩展* 很类似，举个例子：

```bash
echo beg{i,a,u}n ### begin began begun
```

大括号扩展还可以用来创建一个可被循环迭代的区间。

```bash
echo {0..5} ### 0 1 2 3 4 5
echo {00..8..2} ### 00 02 04 06 08
```

#### 命令置换

命令置换允许我们对一个命令求值，并将其值置换到另一个命令或者变量赋值表达式中。当一个命令被````或`$()`包围时，命令置换将会执行。举个例子：

```bash
now=`date +%T`
### or
now=$(date +%T)

echo $now ### 19:08:26
```

#### 算数扩展

在bash中，执行算数运算是非常方便的。算数表达式必须包在`$(( ))`中。算数扩展的格式为：

```
result=$(( ((10 + 5*3) - 7) / 2 ))
echo $result ### 9
```

在算数表达式中，使用变量无需带上`$`前缀：

```
x=4
y=7
echo $(( x + y ))     ### 11
echo $(( ++x + y++ )) ### 12
echo $(( x + y ))     ### 13
```

#### 单引号和双引号

单引号和双引号之间有很重要的区别。在双引号中，变量引用或者命令置换是会被展开的。在单引号中是不会的。举个例子：

```
echo "Your home: $HOME" ### Your home: /Users/<username>
echo 'Your home: $HOME' ### Your home: $HOME
```

当局部变量和环境变量包含空格时，它们在引号中的扩展要格外注意。随便举个例子，假如我们用`echo`来输出用户的输入：

```
INPUT="A string  with   strange    whitespace."
echo $INPUT   ### A string with strange whitespace.
echo "$INPUT" ### A string  with   strange    whitespace.
```

调用第一个`echo`时给了它5个单独的参数 —— $INPUT被分成了单独的词，`echo`在每个词之间打印了一个空格。第二种情况，调用`echo`时只给了它一个参数（整个$INPUT的值，包括其中的空格）。

来看一个更严肃的例子：

```
FILE="Favorite Things.txt"
cat $FILE   ### 尝试输出两个文件: `Favorite` 和 `Things.txt`
cat "$FILE" ### 输出一个文件: `Favorite Things.txt`
```

尽管这个问题可以通过把FILE重命名成`Favorite-Things.txt`来解决，但是，假如这个值来自某个环境变量，来自一个位置参数，或者来自其它命令（`find`, `cat`, 等等）呢。因此，如果输入 *可能* 包含空格，务必要用引号把表达式包起来。

### 数组

跟其它程序设计语言一样，bash中的数组变量给了你引用多个值的能力。在bash中，数组下标也是从0开始，也就是说，第一个元素的下标是0。

跟数组打交道时，要注意一个特殊的环境变量`IFS`。**IFS**，全称 **Input Field Separator**，保存了数组中元素的分隔符。它的默认值是一个空格`IFS=' '`。

#### 创建数组

在 bash 中有好几种方法创建一个数组

```bash
array[0] = val
array[1] = val
array[2] = val
array=([2]=val [0]=val [1]=val)
array=(val val val)
```

#### 数组扩展

单个数组元素的扩展跟普通变量的扩展类似：

```bash
echo ${colors[1]} ### Green
```

整个数组可以通过把数字下标换成`*`或`@`来扩展：

```bash
echo ${colors[*]} ### Red Green Blue
echo ${colors[@]} ### Red Green Blue
```

上面两行有很重要（也很微妙）的区别，假设某数组元素中包含空格：

```bash
colors[0]=Red
colors[1]="Dark Green"
colors[2]=Blue
```

为了将数组中每个元素单独一行输出，我们用内建的`printf`命令：

```bash
printf "+ %s\n" ${colors[*]}

# 输出：
# + Red
# + Dark
# + Green
# + Blue
```

为什么`Desert`和`fig`各占了一行？尝试用引号包起来：

```bash
printf "+ %s\n" "${colors[*]}"

# 输出：
# + Red Dark Green Blue
```

现在所有的元素都跑去了一行 —— 这不是我们想要的！为了解决这个痛点，`${colors[@]}`闪亮登场：

```bash
printf "+ %s\n" "${colors[@]}"

# 输出：
+ Red
+ Dark Green
+ Blue
```

在引号内，`${colors[@]}`将数组中的每个元素扩展为一个单独的参数；数组元素中的空格得以保留。

#### 数组切片

除此之外，可以通过 *切片* 运算符来取出数组中的某一片元素：

```bash
echo ${colors[@]:0:2} ### Red Dark Green
```

在上面的例子中，`${colors[@]}`扩展为整个数组，`:0:2`取出了数组中从0开始，长度为2的元素。

#### 向数组中添加元素

向数组中添加元素也非常简单。复合赋值在这里显得格外有用。我们可以这样做：

```bash
colors=(Yellow "${colors[@]}" Pink Black)
echo ${colors[@]}

# 输出：
# Yellow Red Dark Green Blue Pink Black
```

上面的例子中，`${colors[@]}`扩展为整个数组，并被置换到复合赋值语句中，接着，对数组`colors`的赋值覆盖了它原来的值。

#### 从数组中删除元素

用`unset`命令来从数组中删除一个元素：

```bash
unset colors[0]
echo ${colors[@]}

# 输出：
# Red Dark Green Blue Pink Black
```

### 运算符

#### 算术运算符

下表列出了常用的算术运算符，假定变量 a 为 10，变量 b 为 20：

| 运算符  | 说明                        | 举例                        |
| ---- | ------------------------- | ------------------------- |
| +    | 加法                        | `expr $a + $b` 结果为 30。    |
| -    | 减法                        | `expr $a - $b` 结果为 -10。   |
| *    | 乘法                        | `expr $a \* $b` 结果为  200。 |
| /    | 除法                        | `expr $b / $a` 结果为 2。     |
| %    | 取余                        | `expr $b % $a` 结果为 0。     |
| =    | 赋值                        | a=$b 将把变量 b 的值赋给 a。       |
| ==   | 相等。用于比较两个数字，相同则返回 true。   | [ $a == $b ] 返回 false。    |
| !=   | 不相等。用于比较两个数字，不相同则返回 true。 | [ $a != $b ] 返回 true。     |

**注意：**条件表达式要放在方括号之间，并且要有空格，例如: **[$a==$b]** 是错误的，必须写成 **[ $a == $b ]**。

**示例：**

```bash
a=10
b=20

echo "a=$a, b=$b"

val=`expr $a + $b`
echo "a + b : $val"

val=`expr $a - $b`
echo "a - b : $val"

val=`expr $a \* $b`
echo "a * b : $val"

val=`expr $b / $a`
echo "b / a : $val"

val=`expr $b % $a`
echo "b % a : $val"

if [ $a == $b ]
then
  echo "a 等于 b"
fi
if [ $a != $b ]
then
  echo "a 不等于 b"
fi
```

#### 关系运算符

关系运算符只支持数字，不支持字符串，除非字符串的值是数字。

下表列出了常用的关系运算符，假定变量 a 为 10，变量 b 为 20：

| 运算符  | 说明                            | 举例                      |
| ---- | ----------------------------- | ----------------------- |
| -eq  | 检测两个数是否相等，相等返回 true。          | [ $a -eq $b ] 返回 false。 |
| -ne  | 检测两个数是否相等，不相等返回 true。         | [ $a -ne $b ] 返回 true。  |
| -gt  | 检测左边的数是否大于右边的，如果是，则返回 true。   | [ $a -gt $b ] 返回 false。 |
| -lt  | 检测左边的数是否小于右边的，如果是，则返回 true。   | [ $a -lt $b ] 返回 true。  |
| -ge  | 检测左边的数是否大于等于右边的，如果是，则返回 true。 | [ $a -ge $b ] 返回 false。 |
| -le  | 检测左边的数是否小于等于右边的，如果是，则返回 true。 | [ $a -le $b ] 返回 true。  |

**示例：**

```bash
a=10
b=20

if [ $a -eq $b ]
then
   echo "$a -eq $b : a 等于 b"
else
   echo "$a -eq $b: a 不等于 b"
fi
if [ $a -ne $b ]
then
   echo "$a -ne $b: a 不等于 b"
else
   echo "$a -ne $b : a 等于 b"
fi
if [ $a -gt $b ]
then
   echo "$a -gt $b: a 大于 b"
else
   echo "$a -gt $b: a 不大于 b"
fi
if [ $a -lt $b ]
then
   echo "$a -lt $b: a 小于 b"
else
   echo "$a -lt $b: a 不小于 b"
fi
if [ $a -ge $b ]
then
   echo "$a -ge $b: a 大于或等于 b"
else
   echo "$a -ge $b: a 小于 b"
fi
if [ $a -le $b ]
then
   echo "$a -le $b: a 小于或等于 b"
else
   echo "$a -le $b: a 大于 b"
fi
```

#### 布尔运算符

下表列出了常用的布尔运算符，假定变量 a 为 10，变量 b 为 20：

| 运算符  | 说明                                 | 举例                                    |
| ---- | ---------------------------------- | ------------------------------------- |
| !    | 非运算，表达式为 true 则返回 false，否则返回 true。 | [ ! false ] 返回 true。                  |
| -o   | 或运算，有一个表达式为 true 则返回 true。         | [ $a -lt 20 -o $b -gt 100 ] 返回 true。  |
| -a   | 与运算，两个表达式都为 true 才返回 true。         | [ $a -lt 20 -a $b -gt 100 ] 返回 false。 |

**示例：**

```bash
a=10
b=20

echo "a=$a, b=$b"

if [ $a != $b ]
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi
if [ $a -lt 100 -a $b -gt 15 ]
then
   echo "$a 小于 100 且 $b 大于 15 : 返回 true"
else
   echo "$a 小于 100 且 $b 大于 15 : 返回 false"
fi
if [ $a -lt 100 -o $b -gt 100 ]
then
   echo "$a 小于 100 或 $b 大于 100 : 返回 true"
else
   echo "$a 小于 100 或 $b 大于 100 : 返回 false"
fi
if [ $a -lt 5 -o $b -gt 100 ]
then
   echo "$a 小于 5 或 $b 大于 100 : 返回 true"
else
   echo "$a 小于 5 或 $b 大于 100 : 返回 false"
fi
```

#### 逻辑运算符

以下介绍 Shell 的逻辑运算符，假定变量 a 为 10，变量 b 为 20:

| 运算符  | 说明      | 举例                                      |
| ---- | ------- | --------------------------------------- |
| &&   | 逻辑的 AND | [[ $a -lt 100 && $b -gt 100 ]] 返回 false |
| \|\| | 逻辑的 OR  | [[ $a -lt 100 || $b -gt 100 ]] 返回 true  |

**示例：**

```bash
a=10
b=20

if [[ $a -lt 100 && $b -gt 100 ]]
then
   echo "返回 true"
else
   echo "返回 false"
fi

if [[ $a -lt 100 || $b -gt 100 ]]
then
   echo "返回 true"
else
   echo "返回 false"
fi
```

#### 字符串运算符

下表列出了常用的字符串运算符，假定变量 a 为 "abc"，变量 b 为 "efg"：

| 运算符  | 说明                      | 举例                    |
| ---- | ----------------------- | --------------------- |
| =    | 检测两个字符串是否相等，相等返回 true。  | [ $a = $b ] 返回 false。 |
| !=   | 检测两个字符串是否相等，不相等返回 true。 | [ $a != $b ] 返回 true。 |
| -z   | 检测字符串长度是否为0，为0返回 true。  | [ -z $a ] 返回 false。   |
| -n   | 检测字符串长度是否为0，不为0返回 true。 | [ -n $a ] 返回 true。    |
| str  | 检测字符串是否为空，不为空返回 true。   | [ $a ] 返回 true。       |

**示例：**

```bash
a="abc"
b="efg"

if [ $a = $b ]
then
   echo "$a = $b : a 等于 b"
else
   echo "$a = $b: a 不等于 b"
fi
if [ $a != $b ]
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi
if [ -z $a ]
then
   echo "-z $a : 字符串长度为 0"
else
   echo "-z $a : 字符串长度不为 0"
fi
if [ -n $a ]
then
   echo "-n $a : 字符串长度不为 0"
else
   echo "-n $a : 字符串长度为 0"
fi
if [ $a ]
then
   echo "$a : 字符串不为空"
else
   echo "$a : 字符串为空"
fi
```

#### 文件测试运算符

文件测试运算符用于检测 Unix 文件的各种属性。

属性检测描述如下：

| 操作符     | 说明                                       | 举例                     |
| ------- | ---------------------------------------- | ---------------------- |
| -b file | 检测文件是否是块设备文件，如果是，则返回 true。               | [ -b $file ] 返回 false。 |
| -c file | 检测文件是否是字符设备文件，如果是，则返回 true。              | [ -c $file ] 返回 false。 |
| -d file | 检测文件是否是目录，如果是，则返回 true。                  | [ -d $file ] 返回 false。 |
| -f file | 检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。 | [ -f $file ] 返回 true。  |
| -g file | 检测文件是否设置了 SGID 位，如果是，则返回 true。           | [ -g $file ] 返回 false。 |
| -k file | 检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回 true。   | [ -k $file ] 返回 false。 |
| -p file | 检测文件是否是有名管道，如果是，则返回 true。                | [ -p $file ] 返回 false。 |
| -u file | 检测文件是否设置了 SUID 位，如果是，则返回 true。           | [ -u $file ] 返回 false。 |
| -r file | 检测文件是否可读，如果是，则返回 true。                   | [ -r $file ] 返回 true。  |
| -w file | 检测文件是否可写，如果是，则返回 true。                   | [ -w $file ] 返回 true。  |
| -x file | 检测文件是否可执行，如果是，则返回 true。                  | [ -x $file ] 返回 true。  |
| -s file | 检测文件是否为空（文件大小是否大于0），不为空返回 true。          | [ -s $file ] 返回 true。  |
| -e file | 检测文件（包括目录）是否存在，如果是，则返回 true。             | [ -e $file ] 返回 true。  |

**示例：**

变量 file 表示文件"/var/www/runoob/test.sh"，它的大小为100字节，具有 rwx 权限。下面的代码，将检测该文件的各种属性：

```bash
file="./operatorDemo.sh"
if [ -r $file ]
then
   echo "文件可读"
else
   echo "文件不可读"
fi
if [ -w $file ]
then
   echo "文件可写"
else
   echo "文件不可写"
fi
if [ -x $file ]
then
   echo "文件可执行"
else
   echo "文件不可执行"
fi
if [ -f $file ]
then
   echo "文件为普通文件"
else
   echo "文件为特殊文件"
fi
if [ -d $file ]
then
   echo "文件是个目录"
else
   echo "文件不是个目录"
fi
if [ -s $file ]
then
   echo "文件不为空"
else
   echo "文件为空"
fi
if [ -e $file ]
then
   echo "文件存在"
else
   echo "文件不存在"
fi
```

### 语句

#### 条件语句

跟其它程序设计语言一样，Bash中的条件语句让我们可以决定一个操作是否被执行。结果取决于一个包在`[[ ]]`里的表达式。

条件表达式可以包含`&&`和`||`运算符，分别对应 *与* 和 *或* 。除此之外还有很多有用的[表达式](https://github.com/denysdovhan/bash-handbook/blob/master/translations/zh-CN/README.md#%E5%9F%BA%E5%85%83%E5%92%8C%E7%BB%84%E5%90%88%E8%A1%A8%E8%BE%BE%E5%BC%8F)。

共有两个不同的条件表达式：`if`和`case`。

##### 基元和组合表达式

由`[[ ]]`（`sh`中是`[ ]`）包起来的表达式被称作 **检测命令** 或 **基元**。这些表达式帮助我们检测一个条件的结果。在下面的表里，为了兼容`sh`，我们用的是`[ ]`。这里可以找到有关[bash中单双中括号区别](http://serverfault.com/a/52050)的答案。

**跟文件系统相关：**

| 基元                    | 含义                                   |
| --------------------- | ------------------------------------ |
| `[ -e FILE ]`         | 如果`FILE`存在 (**e**xists)，为真           |
| `[ -f FILE ]`         | 如果`FILE`存在且为一个普通文件（**f**ile），为真      |
| `[ -d FILE ]`         | 如果`FILE`存在且为一个目录（**d**irectory），为真   |
| `[ -s FILE ]`         | 如果`FILE`存在且非空（**s**ize 大于0），为真       |
| `[ -r FILE ]`         | 如果`FILE`存在且有读权限（**r**eadable），为真     |
| `[ -w FILE ]`         | 如果`FILE`存在且有写权限（**w**ritable），为真     |
| `[ -x FILE ]`         | 如果`FILE`存在且有可执行权限（e**x**ecutable），为真 |
| `[ -L FILE ]`         | 如果`FILE`存在且为一个符号链接（**l**ink），为真      |
| `[ FILE1 -nt FILE2 ]` | `FILE1`比`FILE2`新（**n**ewer **t**han） |
| `[ FILE1 -ot FILE2 ]` | `FILE1`比`FILE2`旧（**o**lder **t**han） |

**跟字符串相关：**

| 基元                 | 含义                         |
| ------------------ | -------------------------- |
| `[ -z STR ]`       | `STR`为空（长度为0，**z**ero）     |
| `[ -n STR ]`       | `STR`非空（长度非0，**n**on-zero） |
| `[ STR1 == STR2 ]` | `STR1`和`STR2`相等            |
| `[ STR1 != STR2 ]` | `STR1`和`STR2`不等            |

**算数二元运算符：**

| 基元                  | 含义                                       |
| ------------------- | ---------------------------------------- |
| `[ ARG1 -eq ARG2 ]` | `ARG1`和`ARG2`相等（**eq**ual）               |
| `[ ARG1 -ne ARG2 ]` | `ARG1`和`ARG2`不等（**n**ot **e**qual）       |
| `[ ARG1 -lt ARG2 ]` | `ARG1`小于`ARG2`（**l**ess **t**han）        |
| `[ ARG1 -le ARG2 ]` | `ARG1`小于等于`ARG2`（**l**ess than or **e**qual） |
| `[ ARG1 -gt ARG2 ]` | `ARG1`大于`ARG2`（**g**reater **t**han）     |
| `[ ARG1 -ge ARG2 ]` | `ARG1`大于等于`ARG2`（**g**reater than or **e**qual） |

条件语句可以跟 **组合表达式** 配合使用：

| Operation            | Effect                                   |
| -------------------- | ---------------------------------------- |
| `[ ! EXPR ]`         | 如果`EXPR`为假，为真                            |
| `[ (EXPR) ]`         | 返回`EXPR`的值                               |
| `[ EXPR1 -a EXPR2 ]` | 逻辑 *与*， 如果`EXPR1`和（**a**nd）`EXPR2`都为真，为真 |
| `[ EXPR1 -o EXPR2 ]` | 逻辑 *或*， 如果`EXPR1`或（**o**r）`EXPR2`为真，为真   |

当然，还有很多有用的基元，在[Bash的man页面](http://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html)能很容易找到它们。

##### 使用`if`

`if`在使用上跟其它语言相同。如果中括号里的表达式为真，那么`then`和`fi`之间的代码会被执行。`fi`标志着条件代码块的结束。

```bash
### 写成一行
if [[ 1 -eq 1 ]]; then echo "true"; fi

### 写成多行
if [[ 1 -eq 1 ]]; then
  echo "true"
fi
```

同样，我们可以使用`if..else`语句，例如：

```bash
### 写成一行
if [[ 2 -ne 1 ]]; then echo "true"; else echo "false"; fi

### 写成多行
if [[ 2 -ne 1 ]]; then
  echo "true"
else
  echo "false"
fi
```

有些时候，`if..else`不能满足我们的要求。别忘了`if..elif..else`，使用起来也很方便。

看下面的例子：

```bash
if [[ `uname` == "Adam" ]]; then
  echo "Do not eat an apple!"
elif [[ `uname` == "Eva" ]]; then
  echo "Do not take an apple!"
else
  echo "Apples are delicious!"
fi
```

##### 使用`case`

如果你需要面对很多情况，分别要采取不同的措施，那么使用`case`会比嵌套的`if`更有用。使用`case`来解决复杂的条件判断，看起来像下面这样：

```bash
echo "input param: " $1

case $1 in
  "jpg" | "jpeg")
    echo "It's image with jpeg extension."
  ;;
  "png")
    echo "It's image with png extension."
  ;;
  "gif")
    echo "Oh, it's a giphy!"
  ;;
  *)
    echo "Woops! It's not image!"
  ;;
esac
```

每种情况都是匹配了某个模式的表达式。`|`用来分割多个模式，`)`用来结束一个模式序列。第一个匹配上的模式对应的命令将会被执行。`*`代表任何不匹配以上给定模式的模式。命令块儿之间要用`;;`分隔。

#### 循环语句

循环其实不足为奇。跟其它程序设计语言一样，bash中的循环也是只要控制条件为真就一直迭代执行的代码块。

Bash中有四种循环：`for`，`while`，`until`和`select`。

##### `for`循环

`for`与它在C语言中的姊妹非常像。看起来是这样：

```bash
for arg in elem1 elem2 ... elemN
do
  ### 语句
done
```

在每次循环的过程中，`arg`依次被赋值为从`elem1`到`elemN`。这些值还可以是通配符或者[大括号扩展](https://github.com/denysdovhan/bash-handbook/blob/master/translations/zh-CN/README.md#%E5%A4%A7%E6%8B%AC%E5%8F%B7%E6%89%A9%E5%B1%95)。

当然，我们还可以把`for`循环写在一行，但这要求`do`之前要有一个分号，就像下面这样：

```bash
for i in {1..5}; do echo $i; done
```

还有，如果你觉得`for..in..do`对你来说有点奇怪，那么你也可以像C语言那样使用`for`，比如：

```bash
for (( i = 0; i < 10; i++ )); do
  echo $i
done
```

当我们想对一个目录下的所有文件做同样的操作时，`for`就很方便了。举个例子，如果我们想把所有的`.bash`文件移动到`script`文件夹中，并给它们可执行权限，我们的脚本可以这样写：

```bash
#!/bin/bash

for FILE in $HOME/*.bash; do
  mv "$FILE" "${HOME}/scripts"
  chmod +x "${HOME}/scripts/${FILE}"
done
```

##### `while`循环

`while`循环检测一个条件，只要这个条件为 *真*，就执行一段命令。被检测的条件跟`if..then`中使用的[基元](https://github.com/denysdovhan/bash-handbook/blob/master/translations/zh-CN/README.md#%E5%9F%BA%E5%85%83%E5%92%8C%E7%BB%84%E5%90%88%E8%A1%A8%E8%BE%BE%E5%BC%8F)并无二异。因此一个`while`循环看起来会是这样：

```bash
while [[ condition ]]
do
  ### 语句
done
```

跟`for`循环一样，如果我们把`do`和被检测的条件写到一行，那么必须要在`do`之前加一个分号。

比如下面这个例子：

```bash
#!/bin/bash

### 0到9之间每个数的平方
x=0
while [[ $x -lt 10 ]]; do ### x小于10
  echo $(( x * x ))
  x=$(( x + 1 )) ### x加1
done
```

##### `until`循环

`until`循环跟`while`循环正好相反。它跟`while`一样也需要检测一个测试条件，但不同的是，只要该条件为 *假* 就一直执行循环：

```bash
until [[ condition ]]; do
  ### 语句
done
```

##### `select`循环

`select`循环帮助我们组织一个用户菜单。它的语法几乎跟`for`循环一致：

```bash
select answer in elem1 elem2 ... elemN
do
  ### 语句
done
```

`select`会打印`elem1..elemN`以及它们的序列号到屏幕上，之后会提示用户输入。通常看到的是`$?`（`PS3`变量）。用户的选择结果会被保存到`answer`中。如果`answer`是一个在`1..N`之间的数字，那么`语句`会被执行，紧接着会进行下一次迭代 —— 如果不想这样的话我们可以使用`break`语句。

一个可能的实例可能会是这样：

```bash
#!/bin/bash

PS3="Choose the package manager: "
select ITEM in bower npm gem pip
do
  echo -n "Enter the package name: " && read PACKAGE
  case $ITEM in
    bower) bower install $PACKAGE ;;
    npm)   npm   install $PACKAGE ;;
    gem)   gem   install $PACKAGE ;;
    pip)   pip   install $PACKAGE ;;
  esac
  break ### 避免无限循环
done
```

这个例子，先询问用户他想使用什么包管理器。接着，又询问了想安装什么包，最后执行安装操作。

运行这个脚本，会得到如下输出：

```bash
$ ./my_script
1) bower
2) npm
3) gem
4) pip
Choose the package manager: 2
Enter the package name: bash-handbook
<installing bash-handbook>

```

##### 循环控制

我们会遇到想提前结束一个循环或跳过某次循环执行的情况。这些可以使用shell内建的`break`和`continue`语句来实现。它们可以在任何循环中使用。

`break`语句用来提前结束当前循环。我们之前已经见过它了。

`continue`语句用来跳过某次迭代。我们可以这么来用它：

```bash
for (( i = 0; i < 10; i++ )); do
  if [[ $(( i % 2 )) -eq 0 ]]; then continue; fi
  echo $i
done
```

运行上面的例子，会打印出所有0到9之间的奇数。

### 函数

在脚本中，我们可以定义并调用函数。跟其它程序设计语言类似，函数是一个代码块，但有所不同。

bash 中，函数是一个命令序列，这个命令序列组织在某个名字下面，即 *函数名* 。调用函数跟其它语言一样，写下函数名字，函数就会被 *调用* 。

我们可以这样声明函数：

```bash
my_func () {
  ### 语句
}

my_func ### 调用 my_func
```

我们必须在调用前声明函数。

函数可以接收参数并返回结果 —— 返回值。参数，在函数内部，跟[非交互式](https://github.com/denysdovhan/bash-handbook/blob/master/translations/zh-CN/README.md#%E9%9D%9E%E4%BA%A4%E4%BA%92%E6%A8%A1%E5%BC%8F)下的脚本参数处理方式相同 —— 使用[位置参数](https://github.com/denysdovhan/bash-handbook/blob/master/translations/zh-CN/README.md#%E4%BD%8D%E7%BD%AE%E5%8F%82%E6%95%B0)。返回值可以使用`return`命令 *返回* 。

下面这个函数接收一个名字参数，返回`0`，表示成功执行。

```bash
### 带参数的函数
greeting () {
  if [[ -n $1 ]]; then
    echo "Hello, $1!"
  else
    echo "Hello, unknown!"
  fi
  return 0
}

greeting Denys  ### Hello, Denys!
greeting        ### Hello, stranger!
```

我们之前已经介绍过[返回值](https://github.com/denysdovhan/bash-handbook/blob/master/translations/zh-CN/README.md#%E8%BF%94%E5%9B%9E%E5%80%BC)。不带任何参数的`return`会返回最后一个执行的命令的返回值。上面的例子，`return 0`会返回一个成功表示执行的值，`0`。

### 流，管道以及序列

Bash有很强大的工具来处理程序之间的协同工作。使用流，我们能将一个程序的输出发送到另一个程序或文件，因此，我们能方便地记录日志或做一些其它我们想做的事。

管道给了我们创建传送带的机会，控制程序的执行成为可能。

学习如何使用这些强大的、高级的工具是非常非常重要的。

#### 流

Bash接收输入，并以字符序列或 **字符流** 的形式产生输出。这些流能被重定向到文件或另一个流中。

有三个文件描述符：

| 代码   | 描述符      | 描述     |
| ---- | -------- | ------ |
| `0`  | `stdin`  | 标准输入   |
| `1`  | `stdout` | 标准输出   |
| `2`  | `stderr` | 标准错误输出 |

重定向让我们可以控制一个命令的输入来自哪里，输出结果到什么地方。这些运算符在控制流的重定向时会被用到：

| Operator | Description                              |
| -------- | ---------------------------------------- |
| `>`      | 重定向输出                                    |
| `&>`     | 重定向输出和错误输出                               |
| `&>>`    | 以附加的形式重定向输出和错误输出                         |
| `<`      | 重定向输入                                    |
| `<<`     | [Here文档](http://tldp.org/LDP/abs/html/here-docs.html) 语法 |
| `<<<`    | [Here字符串](http://www.tldp.org/LDP/abs/html/x17837.html) |

以下是一些使用重定向的例子：

```bash
### ls的结果将会被写到list.txt中
ls -l > list.txt

### 将输出附加到list.txt中
ls -a >> list.txt

### 所有的错误信息会被写到errors.txt中
grep da * 2> errors.txt

### 从errors.txt中读取输入
less < errors.txt
```

#### 管道

我们不仅能将流重定向到文件中，还能重定向到其它程序中。**管道** 允许我们把一个程序的输出当做另一个程序的输入。

在下面的例子中，`command1`把它的输出发送给了`command2`，然后输出被传递到`command3`：

```bash
command1 | command2 | command3
```

这样的结构被称作 **管道**。

在实际操作中，这可以用来在多个程序间依次处理数据。在下面的例子中，`ls -l`的输出被发送给了`grep`，来打印出扩展名是`.md`的文件，它的输出最终发送给了`less`：

```bash
ls -l | grep .md$ | less
```

管道的返回值通常是管道中最后一个命令的返回值。shell会等到管道中所有的命令都结束后，才会返回一个值。如果你想让管道中任意一个命令失败后，管道就宣告失败，那么需要用下面的命令设置pipefail选项：

```bash
set -o pipefail
```

#### 命令序列

命令序列是由`;`，`&`，`&&`或者`||`运算符分隔的一个或多个管道序列。

如果一个命令以`&`结尾，shell将会在一个子shell中异步执行这个命令。换句话说，这个命令将会在后台执行。

以`;`分隔的命令将会依次执行：一个接着一个。shell会等待直到每个命令执行完。

```bash
### command2 会在 command1 之后执行
command1 ; command2

### 等同于这种写法
command1
command2
```

以`&&`和`||`分隔的命令分别叫做 *与* 和 *或* 序列。

*与序列* 看起来是这样的：

```bash
### 当且仅当command1执行成功（返回0值）时，command2才会执行
command1 && command2
```

*或序列* 是下面这种形式：

```bash
### 当且仅当command1执行失败（返回错误码）时，command2才会执行
command1 || command2
```

*与* 或 *或* 序列的返回值是序列中最后一个执行的命令的返回值。

### Debugging

shell提供了用于debugging脚本的工具。如果我们想以debug模式运行某脚本，可以在其shebang中使用一个特殊的选项：

```
#!/bin/bash options
```

options是一些可以改变shell行为的选项。下表是一些可能对你有用的选项：

| Short | Name        | Description                       |
| ----- | ----------- | --------------------------------- |
| `-f`  | noglob      | 禁止文件名展开（globbing）                 |
| `-i`  | interactive | 让脚本以 *交互* 模式运行                    |
| `-n`  | noexec      | 读取命令，但不执行（语法检查）                   |
| `-t`  | —           | 执行完第一条命令后退出                       |
| `-v`  | verbose     | 在执行每条命令前，向`stderr`输出该命令           |
| `-x`  | xtrace      | 在执行每条命令前，向`stderr`输出该命令以及该命令的扩展参数 |

举个例子，如果我们在脚本中指定了`-x`例如：

```
#!/bin/bash -x

for (( i = 0; i < 3; i++ )); do
  echo $i
done
```

这会向`stdout`打印出变量的值和一些其它有用的信息：

```bash
$ ./my_script
+ (( i = 0 ))
+ (( i < 3 ))
+ echo 0
0
+ (( i++  ))
+ (( i < 3 ))
+ echo 1
1
+ (( i++  ))
+ (( i < 3 ))
+ echo 2
2
+ (( i++  ))
+ (( i < 3 ))

```

有时我们需要debug脚本的一部分。这种情况下，使用`set`命令会很方便。这个命令可以启用或禁用选项。使用`-`启用选项，`+`禁用选项：

```bash
#!/bin/bash

echo "xtrace is turned off"
set -x
echo "xtrace is enabled"
set +x
echo "xtrace is turned off again"
```

### 资料

- [awesome-shell](https://github.com/alebcay/awesome-shell)，shell 资源列表
- [awesome-bash](https://github.com/awesome-lists/awesome-bash)，bash 资源列表
- [bash-handbook](https://github.com/denysdovhan/bash-handbook)
- [bash-guide](https://github.com/vuuihc/bash-guide) ，bash 基本用法指南
- [bash-it](https://github.com/Bash-it/bash-it)，为你日常使用，开发以及维护 shell 脚本和自定义命令提供了一个可靠的框架
- [dotfiles.github.io](http://dotfiles.github.io/)，上面有bash和其它shell的各种dotfiles集合以及shell框架的链接
- [Runoob Shell 教程](http://www.runoob.com/linux/linux-shell.html)

最后，Stack Overflow上 [bash 标签下](https://stackoverflow.com/questions/tagged/bash)有很多你可以学习的问题，当你遇到问题时，也是一个提问的好地方。