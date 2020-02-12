#!/usr/bin/env bash

# 装载其它库
source ../lib/utils.sh

# ------------------------------------------------------------------------------ 颜色变量测试
printf "${C_B_YELLOW}测试彩色打印：${C_RESET}\n"

printf "${C_BLACK}Hello.${C_RESET}\n"
printf "${C_RED}Hello.${C_RESET}\n"
printf "${C_GREEN}Hello.${C_RESET}\n"
printf "${C_YELLOW}Hello.${C_RESET}\n"
printf "${C_BLUE}Hello.${C_RESET}\n"
printf "${C_MAGENTA}Hello.${C_RESET}\n"
printf "${C_CYAN}Hello.${C_RESET}\n"

printf "${C_B_BLACK}Hello.${C_RESET}\n"
printf "${C_B_RED}Hello.${C_RESET}\n"
printf "${C_B_GREEN}Hello.${C_RESET}\n"
printf "${C_B_YELLOW}Hello.${C_RESET}\n"
printf "${C_B_BLUE}Hello.${C_RESET}\n"
printf "${C_B_MAGENTA}Hello.${C_RESET}\n"
printf "${C_B_CYAN}Hello.${C_RESET}\n"

printf "${C_U_BLACK}Hello.${C_RESET}\n"
printf "${C_U_RED}Hello.${C_RESET}\n"
printf "${C_U_GREEN}Hello.${C_RESET}\n"
printf "${C_U_YELLOW}Hello.${C_RESET}\n"
printf "${C_U_BLUE}Hello.${C_RESET}\n"
printf "${C_U_MAGENTA}Hello.${C_RESET}\n"
printf "${C_U_CYAN}Hello.${C_RESET}\n"

printf "${C_BG_BLACK}Hello.${C_RESET}\n"
printf "${C_BG_RED}Hello.${C_RESET}\n"
printf "${C_BG_GREEN}Hello.${C_RESET}\n"
printf "${C_BG_YELLOW}Hello.${C_RESET}\n"
printf "${C_BG_BLUE}Hello.${C_RESET}\n"
printf "${C_BG_MAGENTA}Hello.${C_RESET}\n"
printf "${C_BG_CYAN}Hello.${C_RESET}\n"

