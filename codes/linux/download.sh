#!/usr/bin/env bash

##############################################################################
# console color
C_BLACK="\033[1;30m"
C_RED="\033[1;31m"
C_GREEN="\033[1;32m"
C_YELLOW="\033[1;33m"
C_BLUE="\033[1;34m"
C_PURPLE="\033[1;35m"
C_CYAN="\033[1;36m"
C_RESET="$(tput sgr0)"
##############################################################################

path=/home/scripts/linux-tutorial
printf "\n${C_BLUE}>>>>>>>> Downloading linux-tutorial to ${path}.${C_RESET}\n"
command -v yum >/dev/null 2>&1 || { echo >&2 -e "${C_RED}Require yum but it's not installed. Aborting.${C_RESET}"; exit 1; }
command -v git >/dev/null 2>&1 || { echo >&2 -e "${C_YELLOW}Not detected git. Install git.${C_RESET}"; yum -y install git; }

if [[ -d ${path} ]]; then
  cd ${path}
  git pull
else
  mkdir -p ${path}
  git clone --no-checkout https://gitee.com/turnon/linux-tutorial.git ${path}
fi
printf "\n${C_GREEN}<<<<<<<< Download linux-tutorial to ${path} ok.${C_RESET}\n"
