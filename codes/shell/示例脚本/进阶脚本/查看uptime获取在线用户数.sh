#!/bin/bash
#
uptime | sed 's/user.*$//' | gawk '{print $NF}'
