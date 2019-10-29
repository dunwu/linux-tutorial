#!/usr/bin/env bash

PS3="Choose the package manager: "
select ITEM in bower npm gem pip
do
echo -n "Enter the package name: " && read PACKAGE
case ${ITEM} in
	bower) bower install ${PACKAGE} ;;
	npm) npm install ${PACKAGE} ;;
	gem) gem install ${PACKAGE} ;;
	pip) pip install ${PACKAGE} ;;
esac
break # 避免无限循环
done
