#!/usr/bin/env bash

#
uptime | sed 's/user.*$//' | gawk '{print $NF}'
