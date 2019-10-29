#!/usr/bin/env bash

cat << EOF

###################################################################################
# 安装 nacos 脚本
# 需要提前安装 jdk、maven
# @system: 适用于所有 linux 发行版本。
# @author: Zhang Peng
###################################################################################

EOF

command -v java > /dev/null 2>&1 || {
	printf "${RED}Require java but it's not installed.${RESET}\n";
	exit 1;
}
command -v mvn > /dev/null 2>&1 || {
	printf "${RED}Require mvn but it's not installed.${RESET}\n";
	exit 1;
}

if [[ $# -lt 1 ]] || [[ $# -lt 2 ]]; then
	echo "Usage: sh nacos-install.sh [version] [path]"
	printf "Example: sh nacos-install.sh 1.0.0 /opt/nacos\n"
fi

version=1.0.0
if [[ -n $1 ]]; then
	version=$1
fi

root=/opt/nacos
if [[ -n $2 ]]; then
	root=$2
fi

echo "Current execution: install nacos ${version} to ${root}"

echo -e "\n>>>>>>>>> download nacos"
mkdir -p ${root}
curl -o ${root}/nacos-server-${version}.zip https://github.com/alibaba/nacos/releases/download/${version}/nacos-server-${version}.zip

echo -e "\n>>>>>>>>> install nacos"
unzip ${root}/nacos-server-${version}.zip -d ${root}/nacos-server-${version}
mv ${root}/nacos-server-${version}/nacos/* ${root}/nacos-server-${version}
rm -rf ${root}/nacos-server-${version}/nacos
