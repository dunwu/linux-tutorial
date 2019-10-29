#!/usr/bin/env bash

# ---------------------------------------------------------------------------------
# 控制台颜色
BLACK="\033[1;30m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
RESET="$(tput sgr0)"
# ---------------------------------------------------------------------------------

printHeadInfo() {
	printf "${BLUE}\n"
	cat << EOF
###################################################################################
# Linux Centos7 系统配置脚本（根据需要选择）
# @author: Zhang Peng
###################################################################################
EOF
	printf "${RESET}\n"
}

setLimit() {
	cat >> /etc/security/limits.conf << EOF
 *  -  nofile  65535
 *  -  nproc   65535
EOF
}

setLang() {
	cat > /etc/sysconfig/i18n << EOF
LANG="zh_CN.UTF-8"
EOF
}

closeShutdownShortkey() {
	printf "\n${CYAN}>>>> 关闭 Ctrl+Alt+Del 快捷键防止重新启动${RESET}\n"
	sed -i 's#exec /sbin/shutdown -r now#\#exec /sbin/shutdown -r now#' /etc/init/control-alt-delete.conf
}

closeSelinux() {
	# see http://blog.51cto.com/13570193/2093299
	printf "\n${CYAN}>>>> 关闭 selinux${RESET}\n"
	sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
}

setBootMode() {
	# 1. 停机(记得不要把 initdefault 配置为 0，因为这样会使 Linux 不能启动)
	# 2. 单用户模式，就像 Win9X 下的安全模式
	# 3. 多用户，但是没有 NFS
	# 4. 完全多用户模式，准则的运行级
	# 5. 通常不用，在一些特殊情况下可以用它来做一些事情
	# 6. X11，即进到 X-Window 系统
	# 7. 重新启动 (记得不要把 initdefault 配置为 6，因为这样会使 Linux 不断地重新启动)
	printf "\n${CYAN}>>>> 配置 Linux 启动模式${RESET}\n"
	sed -i 's/id:5:initdefault:/id:3:initdefault:/' /etc/inittab
}

# 配置 IPv4
configIpv4() {
	printf "\n${CYAN}>>>> 配置 IPv4${RESET}\n"

	cat >> /etc/sysctl.conf << EOF
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 2
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_max_syn_backlog = 16384
net.core.netdev_max_backlog =  16384
net.core.somaxconn = 32768
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_timestamps = 0
net.ipv4.route.gc_timeout = 100
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.ip_local_port_range = 2000  65535
net.ipv4.tcp_max_tw_buckets = 5000
vm.swappiness=10
EOF
}

# 关闭 IPv6
closeIpv6() {
	printf "\n${CYAN}>>>> 关闭 IPv6${RESET}\n"

	cat > /etc/modprobe.d/ipv6.conf << EOF
alias net-pf-10 off
options ipv6 disable=1
EOF

	echo "NETWORKING_IPV6=off" >> /etc/sysconfig/network
}

# 入口函数
main() {
	PS3="请选择要执行的操作："
	select ITEM in "配置 DNS" "配置 NTP" "关闭防火墙" "配置 IPv4" "关闭 IPv6" "全部执行"
	do

	case ${ITEM} in
		"配置 DNS")
			sh ${root}/set-dns.sh ;;
		"配置 NTP")
			sh ${root}/set-ntp.sh ;;
		"关闭防火墙")
			sh ${root}/stop-firewall.sh ;;
		"配置 IPv4")
			configIpv4 ;;
		"关闭 IPv6")
			closeIpv6 ;;
		"全部执行")
			sh ${root}/set-dns.sh
			sh ${root}/set-ntp.sh
			sh ${root}/stop-firewall.sh
			configIpv4
			closeIpv6
		;;
		*)
			printf "\n${RED}输入项不支持${RESET}\n"
			main
		;;
	esac
	break
	done
}

######################################## MAIN ########################################
root=$(pwd)
if [[ -n $1 ]]; then
	root=$1
fi

printHeadInfo
main
