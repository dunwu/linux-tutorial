#!/usr/bin/env bash

user='root'
password='xxxxxx'
database='test'

for f in `ls */*.sql`
do
	echo ${f};
	mysql -u${user} -p${password} -f ${database} -e "source $f";
done
echo 'OK!'
