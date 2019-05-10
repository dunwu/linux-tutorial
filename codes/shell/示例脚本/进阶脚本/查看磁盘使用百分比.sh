#!/bin/bash

#查看磁盘实用百分比
df -h /dev/sda1 | sed -n '/% \//p' | gawk '{ print $5 }'
