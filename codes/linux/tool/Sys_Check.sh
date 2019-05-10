#!/bin/bash
# auth:kaliarch
# func:sys info check
# version:v1.0

[ $(id -u) -gt 0 ] && echo "请用root用户执行此脚本！" && exit 1
sysversion=$(rpm -q centos-release|cut -d- -f3)
line="-------------------------------------------------"


[ -d logs ] || mkdir logs

sys_check_file="logs/$(ip a show dev eth0|grep -w inet|awk '{print $2}'|awk -F '/' '{print $1}')-`date +%Y%m%d`.txt"

# 获取系统cpu信息
function get_cpu_info() {
    Physical_CPUs=$(grep "physical id" /proc/cpuinfo| sort | uniq | wc -l)
    Virt_CPUs=$(grep "processor" /proc/cpuinfo | wc -l)
    CPU_Kernels=$(grep "cores" /proc/cpuinfo|uniq| awk -F ': ' '{print $2}')
    CPU_Type=$(grep "model name" /proc/cpuinfo | awk -F ': ' '{print $2}' | sort | uniq)
    CPU_Arch=$(uname -m)
cat <<EOF
CPU信息:

物理CPU个数:$Physical_CPUs
逻辑CPU个数:$Virt_CPUs
每CPU核心数:$CPU_Kernels
CPU型号:$CPU_Type
CPU架构:$CPU_Arch
EOF
}

# 获取系统内存信息
function get_mem_info() {
    check_mem=$(free -m)
    MemTotal=$(grep MemTotal /proc/meminfo| awk '{print $2}')  #KB
    MemFree=$(grep MemFree /proc/meminfo| awk '{print $2}')    #KB
    let MemUsed=MemTotal-MemFree
    MemPercent=$(awk "BEGIN {if($MemTotal==0){printf 100}else{printf \"%.2f\",$MemUsed*100/$MemTotal}}")
    report_MemTotal="$((MemTotal/1024))""MB"        #内存总容量(MB)
    report_MemFree="$((MemFree/1024))""MB"          #内存剩余(MB)
    report_MemUsedPercent="$(awk "BEGIN {if($MemTotal==0){printf 100}else{printf \"%.2f\",$MemUsed*100/$MemTotal}}")""%"   #内存使用率%

cat <<EOF
内存信息：

${check_mem}
EOF
}

# 获取系统网络信息
function get_net_info() {
    pri_ipadd=$(ip a show dev eth0|grep -w inet|awk '{print $2}'|awk -F '/' '{print $1}')
    pub_ipadd=$(curl ifconfig.me -s)
    gateway=$(ip route | grep default | awk '{print $3}')
    mac_info=$(ip link| egrep -v "lo"|grep link|awk '{print $2}')
    dns_config=$(egrep -v "^$|^#" /etc/resolv.conf)
    route_info=$(route -n)
cat <<EOF
IP信息:

系统公网地址:${pub_ipadd}
系统私网地址:${pri_ipadd}
网关地址:${gateway}
MAC地址:${mac_info}

路由信息:
${route_info}

DNS 信息:
${dns_config}
EOF
}

# 获取系统磁盘信息
function get_disk_info() {
    disk_info=$(fdisk -l|grep "Disk /dev"|cut -d, -f1)
    disk_use=$(df -hTP|awk '$2!="tmpfs"{print}')
    disk_inode=$(df -hiP|awk '$1!="tmpfs"{print}')

cat <<EOF
磁盘信息:

${disk_info}
磁盘使用:

${disk_use}
inode信息:

${disk_inode}
EOF


}

# 获取系统信息
function get_systatus_info() {
    sys_os=$(uname -o)
    sys_release=$(cat /etc/redhat-release)
    sys_kernel=$(uname -r)
    sys_hostname=$(hostname)
    sys_selinux=$(getenforce)
    sys_lang=$(echo $LANG)
    sys_lastreboot=$(who -b | awk '{print $3,$4}')
    sys_runtime=$(uptime |awk '{print  $3,$4}'|cut -d, -f1)
    sys_time=$(date)
    sys_load=$(uptime |cut -d: -f5)

cat <<EOF
系统信息:

系统: ${sys_os}
发行版本:   ${sys_release}
系统内核:   ${sys_kernel}
主机名:    ${sys_hostname}
selinux状态:  ${sys_selinux}
系统语言:   ${sys_lang}
系统当前时间: ${sys_time}
系统最后重启时间:   ${sys_lastreboot}
系统运行时间: ${sys_runtime}
系统负载:   ${sys_load}
EOF
}

# 获取服务信息
function get_service_info() {
    port_listen=$(netstat -lntup|grep -v "Active Internet")
    kernel_config=$(sysctl -p 2>/dev/null)
    if [ ${sysversion} -gt 6 ];then
        service_config=$(systemctl list-unit-files --type=service --state=enabled|grep "enabled")
        run_service=$(systemctl list-units --type=service --state=running |grep ".service")
    else
        service_config=$(/sbin/chkconfig | grep -E ":on|:启用" |column -t)
        run_service=$(/sbin/service --status-all|grep -E "running")
    fi
cat <<EOF
服务启动配置:

${service_config}
${line}
运行的服务:

${run_service}
${line}
监听端口:

${port_listen}
${line}
内核参考配置:

${kernel_config}
EOF
}


function get_sys_user() {
    login_user=$(awk -F: '{if ($NF=="/bin/bash") print $0}' /etc/passwd)
    ssh_config=$(egrep -v "^#|^$" /etc/ssh/sshd_config)
    sudo_config=$(egrep -v "^#|^$" /etc/sudoers |grep -v "^Defaults")
    host_config=$(egrep -v "^#|^$" /etc/hosts)
    crond_config=$(for cronuser in /var/spool/cron/* ;do ls ${cronuser} 2>/dev/null|cut -d/ -f5;egrep -v "^$|^#" ${cronuser} 2>/dev/null;echo "";done)
cat <<EOF
系统登录用户:

${login_user}
${line}
ssh 配置信息:

${ssh_config}
${line}
sudo 配置用户:

${sudo_config}
${line}
定时任务配置:

${crond_config}
${line}
hosts 信息:

${host_config}
EOF
}


function process_top_info() {

    top_title=$(top -b n1|head -7|tail -1)
    cpu_top10=$(top b -n1 | head -17 | tail -11)
    mem_top10=$(top -b n1|head -17|tail -10|sort -k10 -r)

cat <<EOF
CPU占用top10:

${top_title}
${cpu_top10}

内存占用top10:

${top_title}
${mem_top10}
EOF
}


function sys_check() {
    get_cpu_info
    echo ${line}
    get_mem_info
    echo ${line}
    get_net_info
    echo ${line}
    get_disk_info
    echo ${line}
    get_systatus_info
    echo ${line}
    get_service_info
    echo ${line}
    get_sys_user
    echo ${line}
    process_top_info
}


sys_check > ${sys_check_file}
