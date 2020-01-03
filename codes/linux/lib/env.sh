#!/usr/bin/env bash

# ------------------------------------------------------------------------------ 颜色状态

# Regular Color
C_BLACK="\033[0;30m"
C_RED="\033[0;31m"
C_GREEN="\033[0;32m"
C_YELLOW="\033[0;33m"
C_BLUE="\033[0;34m"
C_MAGENTA="\033[0;35m"
C_CYAN="\033[0;36m"
C_WHITE="\033[0;37m"

# Bold Color
C_B_BLACK="\033[1;30m"
C_B_RED="\033[1;31m"
C_B_GREEN="\033[1;32m"
C_B_YELLOW="\033[1;33m"
C_B_BLUE="\033[1;34m"
C_B_MAGENTA="\033[1;35m"
C_B_CYAN="\033[1;36m"
C_B_WHITE="\033[1;37m"

# Underline Color
C_U_BLACK="\033[4;30m"
C_U_RED="\033[4;31m"
C_U_GREEN="\033[4;32m"
C_U_YELLOW="\033[4;33m"
C_U_BLUE="\033[4;34m"
C_U_MAGENTA="\033[4;35m"
C_U_CYAN="\033[4;36m"
C_U_WHITE="\033[4;37m"

# Background Color
C_BG_BLACK="\033[40m"
C_BG_RED="\033[41m"
C_BG_GREEN="\033[42m"
C_BG_YELLOW="\033[43m"
C_BG_BLUE="\033[44m"
C_BG_MAGENTA="\033[45m"
C_BG_CYAN="\033[46m"
C_BG_WHITE="\033[47m"

# Reset Color
C_RESET="$(tput sgr0)"

# ------------------------------------------------------------------------------ 常用状态值

YES=0
NO=1
SUCCEED=0
FAILED=1
