#!/usr/bin/env bash

strIsEmpty() {
    if [[ -z $1 ]]; then
       return ${YES}
    else
       return ${NO}
    fi
}

strIsNotEmpty() {
    if [[ -n $1 ]]; then
       return ${YES}
    else
       return ${NO}
    fi
}

strIsBlank() {
    if [[ ! $1 ]]; then
       return ${YES}
    else
       return ${NO}
    fi
}

strIsNotBlank() {
    if [[ $1 ]]; then
       return ${YES}
    else
       return ${NO}
    fi
}

strEquals() {
    if [[ "$1" = "$2" ]]; then
       return ${YES}
    else
       return ${NO}
    fi
}

strStartWith() {
    if [[ "$1" == "$2*" ]]; then
       return ${YES}
    else
       return ${NO}
    fi
}

