#!/bin/bash

#查看僵尸进程
ps -al | gawk '{print $2,$4}' | grep Z
