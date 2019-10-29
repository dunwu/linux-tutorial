#################################################################################
# 前端应用发布脚本
# 环境要求：Nvm、Node.js
#################################################################################

# 检查脚本参数，如必要参数未传入，退出脚本。
function checkInput() {
	if [ "${branch}" == "" ]; then
		echo "请输入脚本参数：branch"
		echo "    branch: git分支。如 feature/1.1.16, master"
		exit 1
	fi
}

# 脚本主方法
function main() {
	echo ">>>>>>>>>>>>>> 1. 更新代码"
	${SCRIPT_DIR}/update-code.sh ${APP} ${branch} ${SOURCE_DIR}
	execode=$?
	if [ "${execode}" == "0" ]; then
		echo "更新代码成功"
	else
		echo "更新代码失败"
		exit 1
	fi

	echo ">>>>>>>>>>>>>> 2. 替换配置"
	# 有的应用此处可能需要替换配置

	echo ">>>>>>>>>>>>>> 3. 构建编译"
	cd ${SOURCE_DIR}/${APP}
	source "${HOME}/.nvm/nvm.sh"
	nvm use 8.9
	npm install
	if [ "${profile}" == "develop" ] || [ "${profile}" == "test" ]; then
		npm start
	elif [ "${profile}" == "preview" ] || [ "${profile}" == "product" ]; then
		npm run build
	fi
	execode=$?
	if [ "${execode}" == "0" ]; then
		echo "构建编译成功"
	else
		echo "构建编译失败"
		exit 1
	fi

	echo ">>>>>>>>>>>>>> 4. 记录发布的版本信息"
	saveVersionInfo ${LOG_DIR} ${APP} ${branch} ${profile}

	echo ">>>>>>>>>>>>>> 发布应用结束"
}

######################################## MAIN ########################################
# 设置环境变量
export LANG="zh_CN.UTF-8"

# 设置全局常量
APP=blog
LOG_DIR=/home/zp/log
SOURCE_DIR=/home/zp/source
SCRIPT_DIR=$(cd "$(dirname "$0")";
pwd)

# 装载函数库
. ${SCRIPT_DIR}/helper.sh

# 获取传入参数并检查
branch=`echo $1`
profile=`echo $2`

checkInput
checkFileExist ${SCRIPT_DIR}/update-code.sh
createFolderIfNotExist ${SOURCE_DIR}

# 运行主方法
main
