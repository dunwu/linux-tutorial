#!/bin/bash
# function:自定义rm命令，每天晚上定时清理

CMD_SCRIPTS=$HOME/.rm_scripts.sh
TRASH_DIR=$HOME/.TRASH_DIR
CRON_FILE=/var/spool/cron/root
BASHRC=$HOME/.bashrc

[ ! -d ${TRASH_DIR} ] && mkdir -p ${TRASH_DIR}
cat > $CMD_SCRIPTS <<EOF
PARA_CNT=\$#
TRASH_DIR=$TRASH_DIR
for i in \$*; do
     DATE=\$(date +%F%T)
     fileName=\$(basename \$i)
     mv \$i \$TRASH_DIR/\$fileName.\$DATE
done
EOF

sed -i "s@$(grep 'alias rm=' $BASHRC)@alias rm='bash ${CMD_SCRIPTS}'@g" $BASHRC
source $HOME/.bashrc

echo "0 0 * * * rm -rf $TRASH_DIR/*" >> $CRON_FILE
echo "删除目录:$TRASH_DIR"
echo "删除脚本:$CMD_SCRIPTS"
echo "请执行:source $BASHRC 来加载文件或退出当前shell重新登录"
