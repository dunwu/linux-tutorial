#!/usr/bin/env bash

add() {
    echo $[ $1 + $2 ]
}

sub() {
    echo $[ $1 - $2 ]
}

mul() {
    echo $[ $1 * $2 ]
}

div() {
    if [[ $2 -ne 0 ]]; then
        echo $[ $1 / $2 ]
    else
        echo -1
    fi
}
