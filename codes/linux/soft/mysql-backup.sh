#!/usr/bin/env bash

#数据库IP
dbServer="127.0.0.1"
#数据库用户名
dbUser="root"
#数据密码
dbPassword="Tw#123456"
# 备份模式：备份所有数据库（ALL）|备份指定数据库列表（CUSTOM）
backupMode="ALL"
#backupMode="CUSTOM"
#数据库,如有多个库用空格分开
databaseList="mysql sys"
#备份日期
backupDate=`date +"%Y%m%d"`
#备份路径
backupPath="/var/lib/mysql/backup"
#备份日志路径
logPath="${backupPath}/mysql-backup.log"

#日志记录头部
mkdir -p ${backupPath}
touch ${logPath}
echo "------------------------------------------------------------------" >> ${logPath}
beginTime=`date +"%Y-%m-%d %H:%M:%S"`
echo "备份数据库开始，时间：${beginTime}" >> ${logPath}

#正式备份数据库
if [[ ${backupMode} == "ALL" ]];then
	filename="all-${backupDate}"
	#备份所有数据库
	source=`mysqldump -h ${dbServer} -u ${dbUser} -p${dbPassword} --all-databases > ${backupPath}/${filename}.sql`
	 2>> ${logPath};
	#备份成功以下操作
	if [[ "$?" == 0 ]];then
		cd ${backupPath}
		#为节约硬盘空间，将数据库压缩
		tar zcf ${filename}.tar.gz ${filename}.sql > /dev/null
		#删除原始文件，只留压缩后文件
		rm -f ${backupPath}/${filename}.sql
		#删除七天前备份，也就是只保存7天内的备份
		find ${backupPath} -name "*.tar.gz" -type f -mtime +7 -exec rm -rf {} \; > /dev/null 2>&1
		echo ">>>> 备份所有数据库成功!" >> ${logPath}
	else
		#备份失败则进行以下操作
		echo ">>>> 备份所有数据库失败!" >> ${logPath}
	fi
else
	#备份指定数据库列表
	for database in ${databaseList}; do
		filename="${database}-${backupDate}"
		source=`mysqldump -h ${dbServer} -u ${dbUser} -p${dbPassword} ${database} > ${backupPath}/${filename}.sql` 2>> ${logPath};
		#备份成功以下操作
		if [[ "$?" == 0 ]];then
			cd ${backupPath}
			#为节约硬盘空间，将数据库压缩
			tar zcf ${filename}.tar.gz ${filename}.sql > /dev/null
			#删除原始文件，只留压缩后文件
			rm -f ${backupPath}/${filename}.sql
			#删除七天前备份，也就是只保存7天内的备份
			find ${backupPath} -name "*.tar.gz" -type f -mtime +7 -exec rm -rf {} \; > /dev/null 2>&1
			echo ">>>> 备份数据库 ${database} 成功!" >> ${logPath}
		else
			#备份失败则进行以下操作
			echo ">>>> 备份数据库 ${database} 失败!" >> ${logPath}
		fi
	done
fi
endTime=`date +"%Y-%m-%d %H:%M:%S"`
echo "备份数据库结束，时间：${endTime}" >> ${logPath}
