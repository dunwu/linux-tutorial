#!/bin/bash
#
# Capture_Stats - Gather System Performance Statistics
#
#########################################################
#
# Set Script Variables
#
REPORT_FILE=/home/tiandi/Documents/capstats.csv
DATE=`date +%m/%d/%y`
TIME=`date +%k:%M:%S`
#
############################################################
#
USERS=`uptime | sed 's/user.*$//' | gawk '{print $NF}'`
LOAD=`uptime | gawk '{print $NF}'`
#
FREE=`vmstat 1 2 | sed -n '/[0-9]/p' | sed -n '2p' | gawk '{print $4}'`
IDLE=`vmstat 1 2 | sed -n '/[0-9]/p' | sed -n '2p' | gawk '{print $15}'`
#
##########################################
#
echo "$DATE,$TIME,$USERS,$LOAD,$FREE,$IDLE" >> $REPORT_FILE
#
