#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# 目录操作示例
# @author: Zhang Peng
# ------------------------------------------------------------------------------

# 创建目录（整个文件路径中的目录如果不存在，都会一一创建，如果目录已存在，则什么也不做）
mkdir -p /home/linux-tutorial/temp

# 进入目录，如果失败，则退出脚本
cd /home/linux-tutorial/temp || exit 1

# 获取当前目录路径
CURRENT_DIR=$(pwd)
echo "当前目录是：${CURRENT_DIR}"

# 获取上一级目录路径
PARENT_DIR=$(dirname $(pwd))
echo "父目录是：${PARENT_DIR}"

# 获取当前执行脚本名
DIR_NAME=$(basename $0)
echo "当前执行脚本名是：${DIR_NAME}"

# 复制目录（复制 temp 目录所有内容，并命名新文件夹叫 temp2）
cp -rf /home/linux-tutorial/temp /home/linux-tutorial/temp2

# 移动目录（将 temp2 移到 temp 目录下）
mv /home/linux-tutorial/temp2 /home/linux-tutorial/temp/temp2

# 删除目录
rm -rf /home/linux-tutorial
