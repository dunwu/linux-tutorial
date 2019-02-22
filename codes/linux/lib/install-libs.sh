#!/usr/bin/env bash

echo -e "\n>>>>>>>>> install gcc gcc-c++ kernel-devel libtool"
yum -y install make gcc gcc-c++ kernel-devel libtool

echo -e "\n>>>>>>>>> install openssl openssl-devel"
yum -y install make openssl openssl-devel

echo -e "\n>>>>>>>>> install zlib zlib-devel"
yum -y install make zlib zlib-devel

echo -e "\n>>>>>>>>> install pcre"
yum -y install pcre
