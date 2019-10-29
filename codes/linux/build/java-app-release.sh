#!/usr/bin/env bash

#################################################################################
# JAVA 应用发布脚本
# @author: Zhang Peng
#################################################################################

# 检查脚本参数，如必要参数未传入，退出脚本。
checkInput() {
	if [ "${branch}" == "" ] || [ "${profile}" == "" ]; then
		echo "请输入脚本参数：branch profile"
		echo "    branch: git分支（必填）。如 feature/1.1.16, master"
		echo "    profile: 运行环境（必填）。可选值：development | test"
		echo "例：./java-app-release.sh feature/1.1.16 test"
		exit 0
	fi
}

# 检查文件是否存在，不存在则退出脚本
checkFileExist() {
	if [ ! -f "$1" ]
	then
		echo "关键文件 $1 找不到，脚本执行结束"
		exit 0
	fi
}

# 检查文件夹是否存在，不存在则创建
createFolderIfNotExist() {
	if [ ! -d "$1" ]; then
		mkdir -p "$1"
	fi
}

# 记录发布的版本信息
saveVersionInfo() {
	rm -rf ${VERSION_LOG_FILE}
	touch ${VERSION_LOG_FILE}
	chmod 777 ${VERSION_LOG_FILE}

	echo -e "\n=================== Version Info ===================" >> ${VERSION_LOG_FILE}
	echo "Branch is: ${branch}" >> ${VERSION_LOG_FILE}
	echo "Profile is: ${profile}" >> ${VERSION_LOG_FILE}
	echo "CommitID is : $(git log --pretty=oneline -1)" >> ${VERSION_LOG_FILE}
}

######################################## MAIN ########################################
# 设置环境变量
export LANG="zh_CN.UTF-8"

# 设置全局常量
LOG_DIR=/home/zp/log/
SCRIPT_DIR=$(cd "$(dirname "$0")";
pwd)
SOURCE_DIR=/home/zp/source/
APP_NAME=XXX
RESOURCES_DIR=/home/zp/source/${APP_NAME}/src/main/resources
UPDATE_CODE_SCRIPT_FILE=${SCRIPT_DIR}/update-code.sh
MAVEN_LOG_FILE=${LOG_DIR}/${APP_NAME}-maven.log
VERSION_LOG_FILE=${LOG_DIR/${APP_NAME}-version.log

# 0. 获取传入参数并检查
branch=`echo $1`
profile=`echo $2`
checkInput
checkFileExist ${UPDATE_CODE_SCRIPT_FILE}
createFolderIfNotExist ${LOG_DIR}
createFolderIfNotExist ${SOURCE_DIR}

echo ">>>>>>>>>>>>>> 1. 停止应用"
${SCRIPT_DIR}/java-app-run.sh ${profile} stop

echo ">>>>>>>>>>>>>> 2. 更新代码"
${UPDATE_CODE_SCRIPT_FILE} ${APP_NAME} ${branch} ${SOURCE_DIR}
execode=$?
if [ "${execode}" == "0" ]; then
	echo "更新代码成功"
else
	echo "更新代码失败"
	exit 1
fi

echo ">>>>>>>>>>>>>> 3. 替换配置"
# 有则加，无则过

echo ">>>>>>>>>>>>>> 4. 构建编译"
cd ${SOURCE_DIR}/ck-lion
mvn clean package -e -Dmaven.test.skip=true | tee ${MAVEN_LOG_FILE}
eexecode=$?
if [ "${execode}" == "0" ]; then
	echo "构建编译成功"
	echo "编译详情见：${MAVEN_LOG_FILE}"
else
	echo "构建编译失败"
	echo "编译详情见：${MAVEN_LOG_FILE}"
	exit 1
fi

echo ">>>>>>>>>>>>>> 5. 启动应用"
# 手动释放内存
echo 3 > /proc/sys/vm/drop_caches
${SCRIPT_DIR}/java-app-run.sh ${profile} start
execode=$?
if [ "${execode}" == "0" ]; then
	echo "启动应用成功"
else
	echo "启动应用失败"
	exit 1
fi

echo ">>>>>>>>>>>>>> 6. 记录发布的版本信息"
saveVersionInfo

echo ">>>>>>>>>>>>>> 发布应用结束"
