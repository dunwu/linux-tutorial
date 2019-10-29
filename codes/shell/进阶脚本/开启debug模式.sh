#!/usr/bin/env bash

# 开启 debug
set -x
for (( i = 0; i < 3; i ++ )); do
	printf ${i}
done
# 关闭 debug
set +x
#  Output:
#  + (( i = 0 ))
#  + (( i < 3 ))
#  + printf 0
#  0+ (( i++  ))
#  + (( i < 3 ))
#  + printf 1
#  1+ (( i++  ))
#  + (( i < 3 ))
#  + printf 2
#  2+ (( i++  ))
#  + (( i < 3 ))
#  + set +x

for i in {1..5}; do
	printf ${i};
done
printf "\n"
#  Output: 12345
