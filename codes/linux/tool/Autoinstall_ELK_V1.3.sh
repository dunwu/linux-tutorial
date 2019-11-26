#!/usr/bin/env bash

#mail:xuel@anchnet.com
#data:2017/9/7
#AutoInstall ELK scripts
#Software:elasticsearch-5.4.1/logstash-5.4.1/filebeat-5.4.1/kibana-5.4.1
clear
echo "##########################################"
echo "#       Auto Install ELK.               ##"
echo "#       Press Ctrl + C to cancel        ##"
echo "#       Any key to continue             ##"
echo "##########################################"
read -p
software_dir="/usr/local/software"
elasticsearch_url="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.4.1.tar.gz"
kibana_url="https://artifacts.elastic.co/downloads/kibana/kibana-5.4.1-linux-x86_64.tar.gz"
logstash_url="https://artifacts.elastic.co/downloads/logstash/logstash-5.4.1.tar.gz"
filebeat_url="https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.4.1-linux-x86_64.tar.gz"
sys_version=`cat /etc/redhat-release | awk '{print $4}' | cut -d. -f1`
IP=`ip addr | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | cut -d/ -f1`
jvm_conf="/usr/local/elasticsearch/config/jvm.options"
sys_mem=`free -m | grep Mem: | awk '{print $2}' | awk '{sum+=$1} END {print sum/1024}' | cut -d. -f1`

#wget software
wget_fun() {
	if [ ! -d ${software_dir} ]; then
		mkdir -p ${software_dir} && cd ${software_dir}
	else
		cd ${software_dir}
	fi
	for software in $elasticsearch_url $kibana_url $logstash_url $filebeat_url
	do
		wget -c $software
	done
	clear
}

#initial system:install java wget;set hostname;disable firewalld
init_sys() {
	[ -f /etc/init.d/functions ] && . /etc/init.d/functions
	[ "${sys_version}" != "7" ] && echo "Error:This Scripts Support Centos7.xx" && exit 1
	[ $(id -u) != "0" ] && echo "Error: You must be root to run this script" && exit 1
	sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
	setenforce 0
	yum install -y java-1.8.0-openjdk wget net-tools
	hostnamectl set-hostname elk-server
	systemctl stop firewalld
	cat >> /etc/security/limits.conf << EOF
* soft nofile 65536
* hard nofile 65536
* soft nproc 65536
* hard nproc 65536
EOF
}

#install elasticsearch
install_elasticsearch() {
	cd $software_dir
	tar zxf elasticsearch-5.4.1.tar.gz
	mv elasticsearch-5.4.1 /usr/local/elasticsearch
	mkdir -p /usr/local/elasticsearch/data /usr/local/elasticsearch/logs
	useradd elasticsearch
	chown -R elasticsearch:elasticsearch /usr/local/elasticsearch
	echo "vm.max_map_count = 655360" >> /etc/sysctl.conf && sysctl -p
	if [ ${sys_mem} -eq 0 ]; then
		sed -i "s#`grep "^-Xmx" ${jvm_conf}`#"-Xmx512m"#g" ${jvm_conf}
		sed -i "s#`grep "^-Xms" ${jvm_conf}`#"-Xms512m"#g" ${jvm_conf}
	else
		sed -i "s#`grep "^-Xmx" ${jvm_conf}`#"-Xmx${sys_mem}g"#g" ${jvm_conf}
		sed -i "s#`grep "^-Xms" ${jvm_conf}`#"-Xms${sys_mem}g"#g" ${jvm_conf}
	fi
	cat >> /usr/local/elasticsearch/config/elasticsearch.yml << EOF
cluster.name: my-application
node.name: elk-server
path.data: /usr/local/elasticsearch/data
path.logs: /usr/local/elasticsearch/logs
network.host: 127.0.0.1
http.port: 9200
discovery.zen.ping.unicast.hosts: ["elk-server"]
EOF
	su - elasticsearch -c "nohup /usr/local/elasticsearch/bin/elasticsearch &"
}

#install logstash
install_logstash() {
	cd $software_dir
	tar -zxf logstash-5.4.1.tar.gz
	mv logstash-5.4.1 /usr/local/logstash
	cat > /usr/local/logstash/config/01-syslog.conf << EOF
input {
	beats {
		port => "5044"
		}
	}
output {
	elasticsearch {
		hosts => "127.0.0.1:9200"
	}
	stdout { codec => rubydebug }
}
EOF
	nohup /usr/local/logstash/bin/logstash -f /usr/local/logstash/config/01-syslog.conf & > /dev/null
}

#install filebeat
install_filebeat() {
	cd $software_dir
	tar -zxf filebeat-5.4.1-linux-x86_64.tar.gz
	mv filebeat-5.4.1-linux-x86_64 /usr/local/filebeat
	cat > /usr/local/filebeat/filebeat.yml << EOF
filebeat.prospectors:
- input_type: log
  paths:
    - /var/log/*.log
output.logstash:
  hosts: ["127.0.0.1:5044"]
EOF
	cd /usr/local/filebeat/
	nohup /usr/local/filebeat/filebeat & > /dev/null
}

#install kibana
install_kibana() {
	cd $software_dir
	tar -zxf kibana-5.4.1-linux-x86_64.tar.gz
	mv kibana-5.4.1-linux-x86_64 /usr/local/kibana
	cat >> /usr/local/kibana/config/kibana.yml << EOF
server.port: 5601
server.host: "0.0.0.0"
elasticsearch.url: "http://127.0.0.1:9200"
EOF
	nohup /usr/local/kibana/bin/kibana & > /dev/null
}

check() {
	port=$1
	program=$2
	check_port=`netstat -lntup | grep ${port} | wc -l`
	check_program=`ps -ef | grep ${program} | grep -v grep | wc -l`
	if [ $check_port -gt 0 ] && [ $check_program -gt 0 ]; then
		action "${program} run is ok!" /bin/true
	else
		action "${program} run is error!" /bin/false
	fi
}

main() {
	init_sys
	wget_fun
	install_elasticsearch
	install_filebeat
	install_logstash
	install_kibana
	echo -e "\033[32m Checking Elasticsearch...\033[0m"
	sleep 20
	check :9200 "elasticsearch"
	echo -e "\033[32m Checking Logstash...\033[0m"
	sleep 2
	check ":9600" "logstash"
	echo -e "\033[32m Checking Kibana...\033[0m"
	sleep 2
	check ":5601" "kibana"
	action "ELK install is success!" /bin/true
	echo "url:http://$IP:5601"
}

main
