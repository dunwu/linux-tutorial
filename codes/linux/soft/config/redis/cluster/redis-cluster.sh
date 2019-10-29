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

printf "${BLUE}\n"
cat << EOF
###################################################################################
# Redis 集群控制脚本
# @system: 适用于 CentOS7+
# @author: Zhang Peng
###################################################################################
EOF
printf "${RESET}\n"

# Settings
PORT=6380
NODES=6
ENDPORT=$((PORT + NODES))
TIMEOUT=2000
REPLICAS=0
PATH="/usr/local/redis"

######################################## MAIN ########################################
printf "${PURPLE}\n"
printf "Usage: $0 [start|create|stop|watch|tail|clean]\n"
printf "start       -- Launch Redis Cluster instances.\n"
printf "create      -- Create a cluster using redis-cli --cluster create.\n"
printf "stop        -- Stop Redis Cluster instances.\n"
printf "watch       -- Show CLUSTER NODES output (first 30 lines) of first node.\n"
printf "tail <id>   -- Run tail -f of instance at base port + ID.\n"
printf "clean       -- Remove all instances data, logs, configs.\n"
printf "clean-logs  -- Remove just instances logs.\n"
printf "${RESET}\n"

case $1 in
	"start")
		while [[ $((PORT < ENDPORT)) != "0" ]]; do
			PORT=$((PORT + 1))
			echo "Starting $PORT"
			if [[ -e "${PATH}/cluster/${PORT}/redis.conf" ]]; then
				${PATH}/src/redis-server "${PATH}/cluster/${PORT}/redis.conf"
			fi
		done
	;;
	"create")
		HOSTS=""
		while [[ $((PORT < ENDPORT)) != "0" ]]; do
			PORT=$((PORT + 1))
			HOSTS="$HOSTS 127.0.0.1:$PORT"
		done
		${PATH}/src/redis-cli --cluster create $HOSTS --cluster-replicas $REPLICAS
	;;
	"stop")
		while [[ $((PORT < ENDPORT)) != "0" ]]; do
			PORT=$((PORT + 1))
			echo "Stopping $PORT"
			${PATH}/src/redis-cli -p $PORT shutdown nosave
		done
	;;
	"watch")
		PORT=$((PORT + 1))
		while [[ 1 ]]; do
			clear
			date
			${PATH}/src/redis-cli -p $PORT cluster nodes | head -30
			sleep 1
		done
	;;
	"tail")
		INSTANCE=$2
		PORT=$((PORT + INSTANCE))
		tail -f ${PORT}.log
	;;
	"call")
		while [[ $((PORT < ENDPORT)) != "0" ]]; do
			PORT=$((PORT + 1))
			${PATH}/src/redis-cli -p $PORT $2 $3 $4 $5 $6 $7 $8 $9
		done
	;;
	"clean")
		rm -rf **/*.log
		rm -rf **/appendonly*.aof
		rm -rf **/dump*.rdb
		rm -rf **/nodes*.conf
	;;
	"clean-logs")
		rm -rf **/*.log
	;;
	"exit")
		printf "${RED}Invalid option!${RESET}\n"
		main
		exit 0
	;;
esac
