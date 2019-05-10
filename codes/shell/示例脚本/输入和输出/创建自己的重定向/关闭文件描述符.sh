#!/bin/bash
# testing closing file descriptors

exec 3>test
echo "This is a test line of data" >&3

# closing file descriptor
exec 3>&-

echo "This won't work" >&3

cat test

#覆盖前一个test文件
exec 3>test
echo "This'll be bad" >&3
