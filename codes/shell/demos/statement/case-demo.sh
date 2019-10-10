#!/usr/bin/env bash

echo "input param: " $1 $2 $3

x=0
if [[ -n $1 ]]; then
    x=$1
fi

y=0
if [[ -n $2 ]]; then
    y=$2
fi

oper=""
if [[ -n $3 ]]; then
    oper=$3
fi

exec
case ${oper} in
    "+")
        val=`expr ${x} + ${y}`
        echo "${x} + ${y} = ${val}"
    ;;
    "-")
        val=`expr ${x} - ${y}`
        echo "${x} - ${y} = ${val}"
    ;;
    "*")
        val=`expr ${x} \* ${y}`
        echo "${x} * ${y} = ${val}"
    ;;
    "/")
        val=`expr ${x} / ${y}`
        echo "${x} / ${y} = ${val}"
    ;;
    *)
        echo "Unknown oper!"
    ;;
esac
