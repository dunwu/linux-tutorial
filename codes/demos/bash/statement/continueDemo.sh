#!/usr/bin/env bash

# 打印10以内的奇数
for (( i = 0; i < 10; i ++ )); do
  if [[ $((i % 2)) -eq 0 ]]; then
    continue;
  fi
  echo ${i}
done
