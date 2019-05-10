#!/bin/bash
# hiding input data from monitor

read -s -p "Please enter your password: " pass

#添加了-s选项之后，不会自动换行，不添加-s 会自动换行
echo 
echo "Is your password really $pass?"
