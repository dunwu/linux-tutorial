---
title: Python
date: 2018-06-28
categories:
- linux
tags:
- linux
- python
---

# Python

<!-- TOC depthFrom:2 depthTo:3 -->

- [解释器](#解释器)
- [注释](#注释)
- [数据类型](#数据类型)
- [操作符](#操作符)
    - [算术运算符](#算术运算符)
    - [比较运算符](#比较运算符)
    - [赋值运算符](#赋值运算符)
    - [位运算符](#位运算符)
    - [逻辑运算符](#逻辑运算符)
    - [成员运算符](#成员运算符)
    - [身份运算符](#身份运算符)
    - [运算符优先级](#运算符优先级)
- [控制语句](#控制语句)
    - [条件语句](#条件语句)
    - [循环语句](#循环语句)
- [函数](#函数)
    - [函数变量作用域](#函数变量作用域)
    - [关键字参数](#关键字参数)
    - [可变参数列表](#可变参数列表)
    - [返回值](#返回值)
- [异常](#异常)
    - [异常处理](#异常处理)
    - [抛出异常](#抛出异常)
    - [自定义异常](#自定义异常)
- [面向对象](#面向对象)
    - [面向对象技术简介](#面向对象技术简介)
    - [类定义](#类定义)
    - [类对象](#类对象)
    - [类的方法](#类的方法)
    - [继承](#继承)
    - [多继承](#多继承)
    - [方法重写](#方法重写)
    - [类属性与方法](#类属性与方法)
- [标准库概览](#标准库概览)
    - [操作系统接口](#操作系统接口)
    - [文件通配符](#文件通配符)
    - [命令行参数](#命令行参数)
    - [错误输出重定向和程序终止](#错误输出重定向和程序终止)
    - [字符串正则匹配](#字符串正则匹配)
    - [数学](#数学)

<!-- /TOC -->

# Python 编程

## 解释器

Linux/Unix 的系统上，Python 解释器通常被安装在 `/usr/local/bin/python3.4` 这样的有效路径（目录）里。

我们可以将路径 `/usr/local/bin` 添加到您的 Linux/Unix 操作系统的环境变量中，这样您就可以通过 shell 终端输入下面的命令来启动 Python 。

在 Linux/Unix 系统中，你可以在脚本顶部添加以下命令让 Python 脚本可以像 SHELL 脚本一样可直接执行：

```python
#! /usr/bin/env python3.4
```

## 注释

Python 中的注释有三种形式：

- 以 `#` 开头
- 以 `'''` 开始，以 `'''` 结尾
- 以 `"""` 开始，以 `"""` 结尾

```python
# 单行注释

'''
这是多行注释，用三个单引号
这是多行注释，用三个单引号
这是多行注释，用三个单引号
'''

"""
这是多行注释，用三个双引号
这是多行注释，用三个双引号
这是多行注释，用三个双引号
"""
```

## 数据类型

Python3 中有六个标准的数据类型：

- Numbers（数字）
- String（字符串）
- List（列表）
- Tuple（元组）
- Sets（集合）
- Dictionaries（字典）

## 操作符

Python 语言支持以下类型的运算符:

- 算术运算符

- 比较（关系）运算符

- 赋值运算符

- 逻辑运算符

- 位运算符

- 成员运算符

- 身份运算符

- 运算符优先级

### 算术运算符

| 运算符 | 描述                                            | 实例                                    |
| ------ | ----------------------------------------------- | --------------------------------------- |
| +      | 加 - 两个对象相加                               | a + b 输出结果 31                       |
| -      | 减 - 得到负数或是一个数减去另一个数             | a - b 输出结果 -11                      |
| \*     | 乘 - 两个数相乘或是返回一个被重复若干次的字符串 | a \* b 输出结果 210                     |
| /      | 除 - x 除以 y                                   | b / a 输出结果 2.1                      |
| %      | 取模 - 返回除法的余数                           | b % a 输出结果 1                        |
| \*\*   | 幂 - 返回 x 的 y 次幂                           | a\*\*b 为 10 的 21 次方                 |
| //     | 取整除 - 返回商的整数部分                       | 9//2 输出结果 4 , 9.0//2.0 输出结果 4.0 |

### 比较运算符

| 运算符 | 描述                                                                                                                                  | 实例                  |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------- | --------------------- |
| ==     | 等于 - 比较对象是否相等                                                                                                               | (a == b) 返回 False。 |
| !=     | 不等于 - 比较两个对象是否不相等                                                                                                       | (a != b) 返回 True.   |
| >      | 大于 - 返回 x 是否大于 y                                                                                                              | (a > b) 返回 False。  |
| <      | 小于 - 返回 x 是否小于 y。所有比较运算符返回 1 表示真，返回 0 表示假。这分别与特殊的变量 True 和 False 等价。注意，这些变量名的大写。 | (a < b) 返回 True。   |
| >=     | 大于等于 - 返回 x 是否大于等于 y。                                                                                                    | (a >= b) 返回 False。 |
| <=     | 小于等于 - 返回 x 是否小于等于 y。                                                                                                    | (a <= b) 返回 True。  |

### 赋值运算符

| 运算符 | 描述             | 实例                                  |
| ------ | ---------------- | ------------------------------------- |
| =      | 简单的赋值运算符 | c = a + b 将 a + b 的运算结果赋值为 c |
| +=     | 加法赋值运算符   | c += a 等效于 c = c + a               |
| -=     | 减法赋值运算符   | c -= a 等效于 c = c - a               |
| \*=    | 乘法赋值运算符   | c _= a 等效于 c = c _ a               |
| /=     | 除法赋值运算符   | c /= a 等效于 c = c / a               |
| %=     | 取模赋值运算符   | c %= a 等效于 c = c % a               |
| \*\*=  | 幂赋值运算符     | c **= a 等效于 c = c ** a             |
| //=    | 取整除赋值运算符 | c //= a 等效于 c = c // a             |

### 位运算符

| 运算符 | 描述                                                                                             | 实例                                                                           |
| ------ | ------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ |
| &      | 按位与运算符：参与运算的两个值,如果两个相应位都为 1,则该位的结果为 1,否则为 0                    | (a & b) 输出结果 12 ，二进制解释： 0000 1100                                   |
| \|     | 按位或运算符：只要对应的二个二进位有一个为 1 时，结果位就为 1。                                  | (a \| b) 输出结果 61 ，二进制解释： 0011 1101                                  |
| ^      | 按位异或运算符：当两对应的二进位相异时，结果为 1                                                 | (a ^ b) 输出结果 49 ，二进制解释： 0011 0001                                   |
| \~      | 按位取反运算符：对数据的每个二进制位取反,即把 1 变为 0,把 0 变为 1                               | (\~a ) 输出结果 -61 ，二进制解释： 1100 0011， 在一个有符号二进制数的补码形式。 |
| <<     | 左移动运算符：运算数的各二进位全部左移若干位，由"<<"右边的数指定移动的位数，高位丢弃，低位补 0。 | a << 2 输出结果 240 ，二进制解释： 1111 0000                                   |
| >>     | 右移动运算符：把">>"左边的运算数的各二进位全部右移若干位，">>"右边的数指定移动的位数             | a >> 2 输出结果 15 ，二进制解释： 0000 1111                                    |

### 逻辑运算符

| 运算符 | 逻辑表达式 | 描述                                                                    | 实例                    |
| ------ | ---------- | ----------------------------------------------------------------------- | ----------------------- |
| and    | x and y    | 布尔"与" - 如果 x 为 False，x and y 返回 False，否则它返回 y 的计算值。 | (a and b) 返回 20。     |
| or     | x or y     | 布尔"或" - 如果 x 是 True，它返回 x 的值，否则它返回 y 的计算值。       | (a or b) 返回 10。      |
| not    | not x      | 布尔"非" - 如果 x 为 True，返回 False 。如果 x 为 False，它返回 True。  | not(a and b) 返回 False |

### 成员运算符

| 运算符 | 描述                                                    | 实例                                              |
| ------ | ------------------------------------------------------- | ------------------------------------------------- |
| in     | 如果在指定的序列中找到值返回 True，否则返回 False。     | x 在 y 序列中 , 如果 x 在 y 序列中返回 True。     |
| not in | 如果在指定的序列中没有找到值返回 True，否则返回 False。 | x 不在 y 序列中 , 如果 x 不在 y 序列中返回 True。 |

### 身份运算符

| 运算符 | 描述                                        | 实例                                                       |
| ------ | ------------------------------------------- | ---------------------------------------------------------- |
| is     | is 是判断两个标识符是不是引用自一个对象     | x is y, 如果 id(x) 等于 id(y) , **is** 返回结果 1          |
| is not | is not 是判断两个标识符是不是引用自不同对象 | x is not y, 如果 id(x) 不等于 id(y). **is not** 返回结果 1 |

### 运算符优先级

| 运算符                      | 描述                                                   |
| --------------------------- | ------------------------------------------------------ |
| \*\*                        | 指数 (最高优先级)                                      |
| \~ + -                       | 按位翻转, 一元加号和减号 (最后两个的方法名为 +@ 和 -@) |
| \* / % //                   | 乘，除，取模和取整除                                   |
| + -                         | 加法减法                                               |
| >> <<                       | 右移，左移运算符                                       |
| &                           | 位 'AND'                                               |
| ^ \|                        | 位运算符                                               |
| <= < > >=                   | 比较运算符                                             |
| <> == !=                    | 等于运算符                                             |
| = %= /= //= -= += \*= \*\*= | 赋值运算符                                             |
| is is not                   | 身份运算符                                             |
| in not in                   | 成员运算符                                             |
| not or and                  | 逻辑运算符                                             |

## 控制语句

### 条件语句

```python
if condition_1:
    statement_block_1
elif condition_2:
    statement_block_2
else:
    statement_block_3
```

### 循环语句

#### while

```python
while 判断条件：
    statements
```

#### for

```python
for <variable> in <sequence>:
  <statements>
```

#### range()

```python
for i in range(0, 10, 3) :
    print(i)
```

#### break 和 continue

- break 语句可以跳出 for 和 while 的循环体。
- continue 语句被用来告诉 Python 跳过当前循环块中的剩余语句，然后继续进行下一轮循环。

#### pass

pass 语句什么都不做。它只在语法上需要一条语句但程序不需要任何操作时使用.例如:

```python
while True:
    pass  # 等待键盘中断 (Ctrl+C)
```

## 函数

Python 定义函数使用 def 关键字，一般格式如下：

```python
def  函数名（参数列表）：
    函数体
```

### 函数变量作用域

```python
#!/usr/bin/env python3
a = 4  # 全局变量

def print_func1():
    a = 17 # 局部变量
    print("in print_func a = ", a)
def print_func2():
    print("in print_func a = ", a)
print_func1()
print_func2()
print("a = ", a)
```

以上实例运行结果如下：

```python
in print_func a =  17
in print_func a =  4
a =  4
```

### 关键字参数

函数也可以使用 kwarg=value 的关键字参数形式被调用.例如,以下函数:

```python
def parrot(voltage, state='a stiff', action='voom', type='Norwegian Blue'):
    print("-- This parrot wouldn't", action, end=' ')
    print("if you put", voltage, "volts through it.")
    print("-- Lovely plumage, the", type)
    print("-- It's", state, "!")
```

可以以下几种方式被调用:

```python
parrot(1000)                                          # 1 positional argument
parrot(voltage=1000)                                  # 1 keyword argument
parrot(voltage=1000000, action='VOOOOOM')             # 2 keyword arguments
parrot(action='VOOOOOM', voltage=1000000)             # 2 keyword arguments
parrot('a million', 'bereft of life', 'jump')         # 3 positional arguments
parrot('a thousand', state='pushing up the daisies')  # 1 positional, 1 keyword
```

以下为错误调用方法：

```
parrot()                     # required argument missing
parrot(voltage=5.0, 'dead')  # non-keyword argument after a keyword argument
parrot(110, voltage=220)     # duplicate value for the same argument
parrot(actor='John Cleese')  # unknown keyword argument
```

### 可变参数列表

最后,一个最不常用的选择是可以让函数调用可变个数的参数.这些参数被包装进一个元组(查看元组和序列).在这些可变个数的参数之前,可以有零到多个普通的参数:

```python
def arithmetic_mean(*args):
    sum = 0
    for x in args:
        sum += x
    return sum
```

### 返回值

Python 的函数的返回值使用 return 语句，可以将函数作为一个值赋值给指定变量：

```python
def return_sum(x,y):
    c = x + y
    return c
```

## 异常

### 异常处理

try 语句按照如下方式工作；

- 首先，执行 try 子句（在关键字 try 和关键字 except 之间的语句）
- 如果没有异常发生，忽略 except 子句，try 子句执行后结束。
- 如果在执行 try 子句的过程中发生了异常，那么 try 子句余下的部分将被忽略。如果异常的类型和 except 之后的名称相符，那么对应的 except 子句将被执行。最后执行 try 语句之后的代码。
- 如果一个异常没有与任何的 except 匹配，那么这个异常将会传递给上层的 try 中。
- 不管 try 子句里面有没有发生异常，finally 子句都会执行。

```python
import sys

try:
    f = open('myfile.txt')
    s = f.readline()
    i = int(s.strip())
except OSError as err:
    print("OS error: {0}".format(err))
except ValueError:
    print("Could not convert data to an integer.")
except:
    print("Unexpected error:", sys.exc_info()[0])
    raise
finally:
    # 清理行为
```

### 抛出异常

Python 使用 raise 语句抛出一个指定的异常。例如:

```python
>>> raise NameError('HiThere')
Traceback (most recent call last):
  File "<stdin>", line 1, in ?
NameError: HiThere
```

### 自定义异常

可以通过创建一个新的 exception 类来拥有自己的异常。异常应该继承自 Exception 类，或者直接继承，或者间接继承。

当创建一个模块有可能抛出多种不同的异常时，一种通常的做法是为这个包建立一个基础异常类，然后基于这个基础类为不同的错误情况创建不同的子类：

```python
class Error(Exception):
    """Base class for exceptions in this module."""
    pass

class InputError(Error):
    """Exception raised for errors in the input.

    Attributes:
        expression -- input expression in which the error occurred
        message -- explanation of the error
    """

    def __init__(self, expression, message):
        self.expression = expression
        self.message = message

class TransitionError(Error):
    """Raised when an operation attempts a state transition that's not
    allowed.

    Attributes:
        previous -- state at beginning of transition
        next -- attempted new state
        message -- explanation of why the specific transition is not allowed
    """

    def __init__(self, previous, next, message):
        self.previous = previous
        self.next = next
        self.message = message
```

大多数的异常的名字都以"Error"结尾，就跟标准的异常命名一样。

## 面向对象

### 面向对象技术简介

- **类(Class):** 用来描述具有相同的属性和方法的对象的集合。它定义了该集合中每个对象所共有的属性和方法。对象是类的实例。

- **类变量：**类变量在整个实例化的对象中是公用的。类变量定义在类中且在函数体之外。类变量通常不作为实例变量使用。

- **数据成员：**类变量或者实例变量用于处理类及其实例对象的相关的数据。

- **方法重写：**如果从父类继承的方法不能满足子类的需求，可以对其进行改写，这个过程叫方法的覆盖（override），也称为方法的重写。

- **实例变量：**定义在方法中的变量，只作用于当前实例的类。

- **继承：**即一个派生类（derived class）继承基类（base class）的字段和方法。继承也允许把一个派生类的对象作为一个基类对象对待。例如，有这样一个设计：一个 Dog 类型的对象派生自 Animal 类，这是模拟"是一个（is-a）"关系（例图，Dog 是一个 Animal）。

- **实例化：**创建一个类的实例，类的具体对象。

- **方法：**类中定义的函数。

- **对象：**通过类定义的数据结构实例。对象包括两个数据成员（类变量和实例变量）和方法。

### 类定义

语法格式如下：

```python
class ClassName:
    <statement-1>
    .
    .
    .
    <statement-N>
```

类实例化后，可以使用其属性，实际上，创建一个类之后，可以通过类名访问其属性。

### 类对象

类对象支持两种操作：属性引用和实例化。

属性引用使用和 Python 中所有的属性引用一样的标准语法：**obj.name**。

类对象创建后，类命名空间中所有的命名都是有效属性名。所以如果类定义是这样:

```python
#!/usr/bin/python3

class MyClass:
    """一个简单的类实例"""
    i = 12345
    def f(self):
        return 'hello world'

# 实例化类
x = MyClass()

# 访问类的属性和方法
print("MyClass 类的属性 i 为：", x.i)
print("MyClass 类的方法 f 输出为：", x.f())
```

实例化类：

```python
# 实例化类
x = MyClass()
# 访问类的属性和方法
```

以上创建了一个新的类实例并将该对象赋给局部变量 x，x 为空的对象。

执行以上程序输出结果为：

```
MyClass 类的属性 i 为： 12345
MyClass 类的方法 f 输出为： hello world
```

很多类都倾向于将对象创建为有初始状态的。因此类可能会定义一个名为 **init**() 的特殊方法（构造方法），像下面这样：

```python
def __init__(self):
    self.data = []
```

类定义了 **init**() 方法的话，类的实例化操作会自动调用 **init**() 方法。所以在下例中，可以这样创建一个新的实例:

```python
x = MyClass()
```

当然， **init**() 方法可以有参数，参数通过 **init**() 传递到类的实例化操作上。例如:

```python
>>> class Complex:
...     def __init__(self, realpart, imagpart):
...         self.r = realpart
...         self.i = imagpart
...
>>> x = Complex(3.0, -4.5)
>>> x.r, x.i
(3.0, -4.5)
```

### 类的方法

在类地内部，使用 def 关键字可以为类定义一个方法，与一般函数定义不同，类方法必须包含参数 self,且为第一个参数:

```python
#!/usr/bin/python3

#类定义
class people:
    #定义基本属性
    name = ''
    age = 0
    #定义私有属性,私有属性在类外部无法直接进行访问
    __weight = 0
    #定义构造方法
    def __init__(self,n,a,w):
        self.name = n
        self.age = a
        self.__weight = w
    def speak(self):
        print("%s 说: 我 %d 岁。" %(self.name,self.age))

# 实例化类
p = people('W3Cschool',10,30)
p.speak()
```

执行以上程序输出结果为：

```
W3Cschool 说: 我 10 岁。
```

### 继承

Python 同样支持类的继承，如果一种语言不支持继承就，类就没有什么意义。派生类的定义如下所示:

```python
class DerivedClassName(BaseClassName1):
    <statement-1>
    .
    .
    .
    <statement-N>
```

需要注意圆括号中基类的顺序，若是基类中有相同的方法名，而在子类使用时未指定，python 从左至右搜索 即方法在子类中未找到时，从左到右查找基类中是否包含方法。

BaseClassName（示例中的基类名）必须与派生类定义在一个作用域内。除了类，还可以用表达式，基类定义在另一个模块中时这一点非常有用:

```
class DerivedClassName(modname.BaseClassName):
```

**实例**

```python
#!/usr/bin/python3

#类定义
class people:
    #定义基本属性
    name = ''
    age = 0
    #定义私有属性,私有属性在类外部无法直接进行访问
    __weight = 0
    #定义构造方法
    def __init__(self,n,a,w):
        self.name = n
        self.age = a
        self.__weight = w
    def speak(self):
        print("%s 说: 我 %d 岁。" %(self.name,self.age))

#单继承示例
class student(people):
    grade = ''
    def __init__(self,n,a,w,g):
        #调用父类的构函
        people.__init__(self,n,a,w)
        self.grade = g
    #覆写父类的方法
    def speak(self):
        print("%s 说: 我 %d 岁了，我在读 %d 年级"%(self.name,self.age,self.grade))



s = student('ken',10,60,3)
s.speak()
```

执行以上程序输出结果为：

```
ken 说: 我 10 岁了，我在读 3 年级
```

### 多继承

Python 同样有限的支持多继承形式。多继承的类定义形如下例:

```python
class DerivedClassName(Base1, Base2, Base3):
    <statement-1>
    .
    .
    .
    <statement-N>
```

需要注意圆括号中父类的顺序，若是父类中有相同的方法名，而在子类使用时未指定，python 从左至右搜索 即方法在子类中未找到时，从左到右查找父类中是否包含方法。

```python
#!/usr/bin/python3

#类定义
class people:
    #定义基本属性
    name = ''
    age = 0
    #定义私有属性,私有属性在类外部无法直接进行访问
    __weight = 0
    #定义构造方法
    def __init__(self,n,a,w):
        self.name = n
        self.age = a
        self.__weight = w
    def speak(self):
        print("%s 说: 我 %d 岁。" %(self.name,self.age))

#单继承示例
class student(people):
    grade = ''
    def __init__(self,n,a,w,g):
        #调用父类的构函
        people.__init__(self,n,a,w)
        self.grade = g
    #覆写父类的方法
    def speak(self):
        print("%s 说: 我 %d 岁了，我在读 %d 年级"%(self.name,self.age,self.grade))

#另一个类，多重继承之前的准备
class speaker():
    topic = ''
    name = ''
    def __init__(self,n,t):
        self.name = n
        self.topic = t
    def speak(self):
        print("我叫 %s，我是一个演说家，我演讲的主题是 %s"%(self.name,self.topic))

#多重继承
class sample(speaker,student):
    a =''
    def __init__(self,n,a,w,g,t):
        student.__init__(self,n,a,w,g)
        speaker.__init__(self,n,t)

test = sample("Tim",25,80,4,"Python")
test.speak()   #方法名同，默认调用的是在括号中排前地父类的方法
```

执行以上程序输出结果为：

```
我叫 Tim，我是一个演说家，我演讲的主题是 Python
```

### 方法重写

如果你的父类方法的功能不能满足你的需求，你可以在子类重写你父类的方法，实例如下：

```python
#!/usr/bin/python3

class Parent:        # 定义父类
   def myMethod(self):
      print ('调用父类方法')

class Child(Parent): # 定义子类
   def myMethod(self):
      print ('调用子类方法')

c = Child()          # 子类实例
c.myMethod()         # 子类调用重写方法
```

执行以上程序输出结果为：

```
调用子类方法
```

### 类属性与方法

#### 类的私有属性

**\_\_private_attrs**：两个下划线开头，声明该属性为私有，不能在类地外部被使用或直接访问。在类内部的方法中使用时**self.\_\_private_attrs**。

#### 类的方法

在类地内部，使用 def 关键字可以为类定义一个方法，与一般函数定义不同，类方法必须包含参数 self,且为第一个参数

#### 类的私有方法

**\_\_private_method**：两个下划线开头，声明该方法为私有方法，不能在类地外部调用。在类的内部调用 **slef.\_\_private_methods**。

实例如下：

```python
#!/usr/bin/python3

class JustCounter:
    __secretCount = 0  # 私有变量
    publicCount = 0    # 公开变量

    def count(self):
        self.__secretCount += 1
        self.publicCount += 1
        print (self.__secretCount)

counter = JustCounter()
counter.count()
counter.count()
print (counter.publicCount)
print (counter.__secretCount)  # 报错，实例不能访问私有变量
```

执行以上程序输出结果为：

```
1
2
2
Traceback (most recent call last):
  File "test.py", line 16, in <module>
    print (counter.__secretCount)  # 报错，实例不能访问私有变量
AttributeError: 'JustCounter' object has no attribute '__secretCount'
```

#### 类的专有方法：

- \***\*init** :\*\* 构造函数，在生成对象时调用
- \***\*del** :\*\* 析构函数，释放对象时使用
- \***\*repr** :\*\* 打印，转换
- \***\*setitem** :\*\* 按照索引赋值
- \***\*getitem**:\*\* 按照索引获取值
- \***\*len**:\*\* 获得长度
- \***\*cmp**:\*\* 比较运算
- \***\*call**:\*\* 函数调用
- \***\*add**:\*\* 加运算
- \***\*sub**:\*\* 减运算
- \***\*mul**:\*\* 乘运算
- \***\*div**:\*\* 除运算
- \***\*mod**:\*\* 求余运算
- \***\*pow**:\*\* 乘方

#### 运算符重载

Python 同样支持运算符重载，我么可以对类的专有方法进行重载，实例如下：

```python
#!/usr/bin/python3

class Vector:
   def __init__(self, a, b):
      self.a = a
      self.b = b

   def __str__(self):
      return 'Vector (%d, %d)' % (self.a, self.b)

   def __add__(self,other):
      return Vector(self.a + other.a, self.b + other.b)

v1 = Vector(2,10)
v2 = Vector(5,-2)
print (v1 + v2)
```

以上代码执行结果如下所示:

```
Vector(7,8)
```

## 标准库概览

### 操作系统接口

os 模块提供了不少与操作系统相关联的函数。

```python
>>> import os
>>> os.getcwd()      # 返回当前的工作目录
'C:\\Python34'
>>> os.chdir('/server/accesslogs')   # 修改当前的工作目录
>>> os.system('mkdir today')   # 执行系统命令 mkdir
0
```

### 文件通配符

glob 模块提供了一个函数用于从目录通配符搜索中生成文件列表:

```python
>>> import glob
>>> glob.glob('*.py')
['primes.py', 'random.py', 'quote.py']
```

### 命令行参数

通用工具脚本经常调用命令行参数。这些命令行参数以链表形式存储于 sys 模块的 argv 变量。例如在命令行中执行 `python demo.py one two three` 后可以得到以下输出结果:

```python
>>> import sys
>>> print(sys.argv)
['demo.py', 'one', 'two', 'three']
```

### 错误输出重定向和程序终止

sys 还有 stdin，stdout 和 stderr 属性，即使在 stdout 被重定向时，后者也可以用于显示警告和错误信息。

```python
>>> sys.stderr.write('Warning, log file not found starting a new one\n')
Warning, log file not found starting a new one
```

### 字符串正则匹配

re 模块为高级字符串处理提供了正则表达式工具。对于复杂的匹配和处理，正则表达式提供了简洁、优化的解决方案:

```python
>>> import re
>>> re.findall(r'\bf[a-z]*', 'which foot or hand fell fastest')
['foot', 'fell', 'fastest']
>>> re.sub(r'(\b[a-z]+) \1', r'\1', 'cat in the the hat')
'cat in the hat'
```

### 数学

math 模块为浮点运算提供了对底层 C 函数库的访问:

```python
>>> import math
>>> math.cos(math.pi / 4)
0.70710678118654757
>>> math.log(1024, 2)
10.0
```

# 资料

- https://github.com/vinta/awesome-python - 资源大全
- https://github.com/jobbole/awesome-python-cn - 资源大全
- https://github.com/scrapy/scrapy - python 爬虫框架
- https://github.com/faif/python-patterns - python 设计模式
- https://github.com/kennethreitz/python-guide - python 最佳实践
