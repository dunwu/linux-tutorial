#!/usr/bin/env bash

###################################################################################
# 项目发布脚本模板
# @author: Zhang Peng
###################################################################################

# 选择应用
function chooseAppName() {
	cat << EOF
请选择应用名（数字或关键字均可）。
可选值如下：
    [0] all （所有应用）
    [1] js-app
    [2] APP2
EOF

	while read app
	do
		case ${app} in
			0)
				app=all
				break ;;
			1)
				app=js-app
				break ;;
			2)
				app=APP2
				break ;;
			all | js-app | APP2)
				break ;;
			*) echo "无法识别 ${app}" ;;
		esac
	done
}

# 选择操作
function chooseOper() {
	cat << EOF
请选择想要执行的操作（数字或关键字均可）。
可选值如下：
    [1] start
    [2] restart
    [3] stop
EOF

	while read oper
	do
		case ${oper} in
			1)
				oper=start
				break ;;
			2)
				oper=restart
				break ;;
			3)
				oper=stop
				break ;;
			start | restart | stop)
				break ;;
			*) echo "无法识别 ${oper}" ;;
		esac
	done
}

# 选择代码分支
function chooseBranch() {
	cat << EOF
请输入 git 分支。
如：develop、master、feature/xxx
EOF

	read branch
	if [[ "${branch}" =~ ^ ( feature/ ) ( [^ \f\n\r\t\v]+ ) ]] || [ "${branch}" == "develop" ] || [ "${branch}" == "master" ]; then
		echo "输入了 ${branch}"
	else
		echo "无法识别 ${branch}"
		chooseBranch
	fi
}

# 选择运行环境
function chooseProfile() {
	cat << EOF
请选择运行环境（数字或关键字均可）。
可选值：
    [1] develop (开发环境)
    [2] test (测试环境)
    [3] preview (预发布环境)
    [4] product (生产环境)
EOF

	while read profile
	do
		case ${profile} in
			1)
				profile=develop
				break ;;
			2)
				profile=test
				break ;;
			3)
				profile=preview
				break ;;
			4)
				profile=product
				break ;;
			develop | test | preview | product)
				break ;;
			*) echo "无法识别 ${profile}" ;;
		esac
	done
}

# 确认选择
function confirmChoice() {

	cat << EOF
===================================================
请确认您的选择：Y/N
    app: ${app}
    oper: ${oper}
    branch: ${branch}
    profile: ${profile}
===================================================
EOF

	while read confirm
	do
		case ${confirm} in
			y | Y)
				echo -e "\n\n>>>>>>>>>>>>>> 开始发布应用"
				break ;;
			n | N)
				echo -e "重新输入发布参数\n"
				inputParams ;;
			*)
				echo "无法识别 ${confirm}" ;;
		esac
	done
}

# 引导式发布应用
function releaseApp() {
	# 输入执行参数
	app=""
	branch=""
	profile=""
	chooseAppName
	chooseOper
	if [ "${oper}" == "stop" ]; then
		confirmChoice
		if [ "${app}" == "all" ]; then
			${SCRIPT_DIR}/${app}-run.sh stop ${profile}
		else
			${SCRIPT_DIR}/${app}-run.sh stop ${profile}
		fi
	else
		chooseBranch
		chooseProfile
		confirmChoice
		if [ "${app}" == "all" ]; then
			${SCRIPT_DIR}/js-app-release.sh ${branch} ${profile}
		else
			${SCRIPT_DIR}/${app}-release.sh ${branch} ${profile}
		fi
	fi

}

# 脚本主方法
function main() {

	printHeadInfo
	while read sign
	do
		case ${sign} in
			exit)
				echo "主动退出脚本"
				exit 0 ;;
			*)
				releaseApp ;;
		esac

		# 装载函数库
		printFootInfo
	done
}

######################################## MAIN ########################################
# 设置环境变量
export LANG="zh_CN.UTF-8"

# 设置全局常量
SCRIPT_DIR=$(cd "$(dirname "$0")";
pwd)
SOURCE_DIR=/home/zp/source/

# 装载函数库
. ${SCRIPT_DIR}/helper.sh

# 检查必要文件或文件夹是否存在
checkFileExist ${SCRIPT_DIR}/helper.sh
createFolderIfNotExist ${SOURCE_DIR}

# 运行主方法
main
