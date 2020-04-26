#!/usr/bin/env bash

# -----------------------------------------------------------------------------------------------------
# 安装 sonatype nexus(用于搭建 maven 私服) 脚本
# @system: 适用于所有 linux 发行版本。
# sonatype nexus 会被安装到 /opt/maven 路径。
# 注意：sonatype nexus 要求必须先安装 JDK
# @author: Zhang Peng
# -----------------------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------ env

# Regular Color
export ENV_COLOR_BLACK="\033[0;30m"
export ENV_COLOR_RED="\033[0;31m"
export ENV_COLOR_GREEN="\033[0;32m"
export ENV_COLOR_YELLOW="\033[0;33m"
export ENV_COLOR_BLUE="\033[0;34m"
export ENV_COLOR_MAGENTA="\033[0;35m"
export ENV_COLOR_CYAN="\033[0;36m"
export ENV_COLOR_WHITE="\033[0;37m"
# Bold Color
export ENV_COLOR_B_BLACK="\033[1;30m"
export ENV_COLOR_B_RED="\033[1;31m"
export ENV_COLOR_B_GREEN="\033[1;32m"
export ENV_COLOR_B_YELLOW="\033[1;33m"
export ENV_COLOR_B_BLUE="\033[1;34m"
export ENV_COLOR_B_MAGENTA="\033[1;35m"
export ENV_COLOR_B_CYAN="\033[1;36m"
export ENV_COLOR_B_WHITE="\033[1;37m"
# Reset Color
export ENV_COLOR_RESET="$(tput sgr0)"

# status
export ENV_YES=0
export ENV_NO=1
export ENV_SUCCEED=0
export ENV_FAILED=1

# ------------------------------------------------------------------------------ functions

# 显示打印日志的时间
SHELL_LOG_TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
# 那个用户在操作
USER=$(whoami)

redOutput() {
    echo -e "${ENV_COLOR_RED} $@${ENV_COLOR_RESET}"
}

greenOutput() {
    echo -e "${ENV_COLOR_B_GREEN} $@${ENV_COLOR_RESET}"
}

yellowOutput() {
    echo -e "${ENV_COLOR_YELLOW} $@${ENV_COLOR_RESET}"
}

blueOutput() {
    echo -e "${ENV_COLOR_BLUE} $@${ENV_COLOR_RESET}"
}

magentaOutput() {
    echo -e "${ENV_COLOR_MAGENTA} $@${ENV_COLOR_RESET}"
}

cyanOutput() {
    echo -e "${ENV_COLOR_CYAN} $@${ENV_COLOR_RESET}"
}

whiteOutput() {
    echo -e "${ENV_COLOR_WHITE} $@${ENV_COLOR_RESET}"
}

printInfo() {
    echo -e "${ENV_COLOR_B_GREEN}[INFO] $@${ENV_COLOR_RESET}"
}

printWarn() {
    echo -e "${ENV_COLOR_B_YELLOW}[WARN] $@${ENV_COLOR_RESET}"
}

printError() {
    echo -e "${ENV_COLOR_B_RED}[ERROR] $@${ENV_COLOR_RESET}"
}

callAndLog () {
    $*
    if [[ $? -eq ${ENV_SUCCEED} ]]; then
        printInfo "$@"
        return ${ENV_SUCCEED}
    else
        printError "$@ EXECUTE FAILED"
        return ${ENV_FAILED}
    fi
}

# ------------------------------------------------------------------------------ main
ENV_NEXUS_VERSION=${ENV_NEXUS_VERSION:-3.13.0-01}
ENV_NEXUS_DIR=${ENV_NEXUS_DIR:-/opt/maven}

printInfo ">>>> install nexus begin."

mkdir -p ${ENV_NEXUS_DIR}
printInfo "download nexus"
#由于国内网络问题，有可能下载失败
curl -o ${ENV_NEXUS_DIR}/nexus-unix.tar.gz https://sonatype-download.global.ssl.fastly.net/repository/repositoryManager/3/nexus-${ENV_NEXUS_VERSION}-unix.tar.gz
if [[ "$?" != ${ENV_SUCCEED} ]]; then
    printError "<<<< download nexus-${ENV_NEXUS_VERSION}-unix.tar.gz failed"
    return ${ENV_FAILED}
fi
tar -zxf nexus-unix.tar.gz

printInfo ">>>> setting systemd."
#通过设置 systemd，是的 nexus 注册为服务，开机自启动
touch /lib/systemd/system/nexus.service
cat >> /lib/systemd/system/nexus.service << EOF
[Unit]
Description=nexus
After=network.target

[Service]
Type=forking
LimitNOFILE=65536 #警告处理
Environment=RUN_AS_USER=root
ExecStart=${ENV_NEXUS_DIR}/nexus-${ENV_NEXUS_VERSION}/bin/nexus start
ExecReload=${ENV_NEXUS_DIR}/nexus-${ENV_NEXUS_VERSION}/bin/nexus restart
ExecStop=${ENV_NEXUS_DIR}/nexus-${ENV_NEXUS_VERSION}/bin/nexus stop
Restart=on-failure
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF
systemctl enable nexus
systemctl start nexus

printInfo ">>>> setting firewalld."
firewall-cmd --zone=public --add-port=8081/tcp --permanent
firewall-cmd --reload
# 如果防火墻使用的是 iptables，使用如下配置：
#iptables -I INPUT -p tcp -m tcp --dport 8081 -j ACCEPT
#/etc/rc.d/init.d/iptables save
#service iptables restart

printInfo "<<<<<<<< install nexus success."
