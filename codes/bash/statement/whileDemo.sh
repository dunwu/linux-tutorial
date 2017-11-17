#!/usr/bin/env bash

### 0到9之间每个数的平方
x=0
### x小于10
while [[ ${x} -lt 10 ]]; do
  echo $((x * x))
  x=$((x + 1)) ### x加1
done
