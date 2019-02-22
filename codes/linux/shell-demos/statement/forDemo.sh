#!/usr/bin/env bash

echo "print 1 to 5"
for i in {1..5}; do
  echo $i;
done

echo "print 0 to 9"
for (( i = 0; i < 10; i ++ )); do
  echo $i
done
