#!/bin/bash
# testing inpiut/output file descriptor

exec 3<> test
read line <&3
echo "Read: $line"
echo "This is the test line" >&3
