#!/usr/bin/env bash

### 0到9之间每个数的平方
x=0
### x小于10
while [[ ${x} -lt 10 ]]; do
    echo $((x * x))
    x=$((x + 1))
done
#  Output:
#  0
#  1
#  4
#  9
#  16
#  25
#  36
#  49
#  64
#  81
