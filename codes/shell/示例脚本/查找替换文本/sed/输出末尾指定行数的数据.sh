#!/bin/bash
#输出末尾10行数据

sed '{
:start
$q
N
11,$D
b start
}' /etc/passwd
