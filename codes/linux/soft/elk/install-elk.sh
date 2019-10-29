#!/usr/bin/env bash

# 本脚本为一键式安装 ELK 脚本
# 执行脚本前，请先执行以下命令，创建用户
# groupadd elk
# useradd -g elk elk
# passwd elk

# 获取当前设备IP
ipaddr='127.0.0.1'
function getDeviceIp() {
	ipaddr=$(ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}')
}

# 检查文件是否存在，不存在则退出脚本
checkFileExist() {
	if [ ! -f "$1" ]
	then
		echo "关键文件 $1 找不到，脚本执行结束"
		exit 0
	fi
}

init() {
	mkdir -p ${ELASTIC_SOFTWARE_PATH}
	getDeviceIp
}

# 安装 elasticsearch
installElasticsearch() {
	cd ${ELASTIC_SOFTWARE_PATH}
	wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${version}.tar.gz
	tar -xzf elasticsearch-${version}.tar.gz
}

installRuby() {
	cd ${RUBY_SOFTWARE_PATH}
	wget https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.0.tar.gz
	tar -xzf ruby-2.5.0.tar.gz
	cd ruby-2.5.0
	./configure
	make & make install
}

# 安装 logstash
installLogstash() {
	cd ${ELASTIC_SOFTWARE_PATH}
	wget https://artifacts.elastic.co/downloads/logstash/logstash-${version}.tar.gz
	tar -xzf logstash-${version}.tar.gz
}

# 安装 kibana
installKibana() {
	cd ${ELASTIC_SOFTWARE_PATH}
	wget https://artifacts.elastic.co/downloads/kibana/kibana-${version}-linux-x86_64.tar.gz
	tar -xzf kibana-${version}-linux-x86_64.tar.gz
}

# 安装 filebeat
installFilebeat() {
	cd ${ELASTIC_SOFTWARE_PATH}
	wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${version}-linux-x86_64.tar.gz
	tar -zxf filebeat-${version}-linux-x86_64.tar.gz
}

# 替换 Elasticsearch 配置
# 1. 替换 192.168.0.1 为本机 IP
replaceElasticsearchConfig() {
	cp ${ELASTIC_SOFTWARE_PATH}/elasticsearch-${version}/config/elasticsearch.yml ${ELASTIC_SOFTWARE_PATH}/elasticsearch-${version}/config/elasticsearch.yml.bak
	sed -i "s/#network.host: 192.168.0.1/network.host: ${IP}/g" ${ELASTIC_SOFTWARE_PATH}/elasticsearch-${version}/config/elasticsearch.yml
	touch ${ELASTIC_SOFTWARE_PATH}/elasticsearch-${version}/bin/nohup.out
}

replaceLogstashConfig() {
	cp ${ELASTIC_SOFTWARE_PATH}/logstash-${version}/config/logstash.yml ${ELASTIC_SOFTWARE_PATH}/logstash-${version}/config/logstash.yml.bak
	sed -i "s/# http.host: \"127.0.0.1\"/ http.host: ${IP}/g" ${ELASTIC_SOFTWARE_PATH}/logstash-${version}/config/logstash.yml
	touch ${ELASTIC_SOFTWARE_PATH}/logstash-${version}/bin/nohup.out
	cd ${ELASTIC_SOFTWARE_PATH}/logstash-${version}/bin
	wget "https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/elk/config/logstash.conf"
}

# 替换 Kibana 配置
# 1. 替换 localhost 为本机 IP
replaceKibanaConfig() {
	cp ${ELASTIC_SOFTWARE_PATH}/kibana-${version}-linux-x86_64/config/kibana.yml ${ELASTIC_SOFTWARE_PATH}/kibana-${version}-linux-x86_64/config/kibana.yml.bak
	sed -i "s/#server.host: \"localhost\"/server.host: ${IP}/g" ${ELASTIC_SOFTWARE_PATH}/kibana-${version}-linux-x86_64/config/kibana.yml
	sed -i "s/#elasticsearch.url: \"http://localhost:9200\"/#elasticsearch.url: \"${IP}\"/g" ${ELASTIC_SOFTWARE_PATH}/kibana-${version}-linux-x86_64/config/kibana.yml
	touch ${ELASTIC_SOFTWARE_PATH}/kibana-${version}-linux-x86_64/bin/nohup.out
}

# 替换 Filebeat 配置
replaceFilebeatConfig() {
	cp ${ELASTIC_SOFTWARE_PATH}/filebeat-${version}-linux-x86_64/filebeat.yml ${ELASTIC_SOFTWARE_PATH}/filebeat-${version}-linux-x86_64/filebeat.yml.bak
	cd ${ELASTIC_SOFTWARE_PATH}/filebeat-${version}-linux-x86_64
	wget https://github.com/dunwu/OS/blob/master/codes/deploy/tool/elk/config/filebeat.yml
	sed -i 's/127.0.0.1/'"${IP}"'/g' ${ELASTIC_SOFTWARE_PATH}/filebeat-${version}-linux-x86_64/filebeat.yml
}

# 为 elk.elk 用户设置权限
setPrivilegeForUser() {
	chown -R elk.elk ${ELASTIC_SOFTWARE_PATH}
	chown -R elk.elk /var/log/
}

######################################## MAIN ########################################
echo -e "\n>>>>>>>>> install elk"

version=6.1.1
RUBY_SOFTWARE_PATH=/opt/ruby
ELASTIC_SOFTWARE_PATH=/opt/elastic
ELASTIC_SETTINGS_PATH=/opt/elastic/settings

init

installElasticsearch
replaceElasticsearchConfig

installLogstash
replaceLogstashConfig

installKibana
replaceKibanaConfig

installFilebeat
replaceFilebeatConfig

# 最后，将启动脚本下载到本地
mkdir -p /home/zp/script
wget -P /home/zp/script "https://gitee.com/turnon/linux-tutorial/raw/master/codes/linux/soft/elk/boot-elk.sh"
#setPrivilegeForUser

