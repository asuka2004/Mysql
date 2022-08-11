#!/bin/bash
# Author      : Kung
# Build       : 2022-08-11 11:39
# Version     : V1.0
# Description :            
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

useradd -s /sbin/nologin -g mysql -M mysql
mkdir /software
cd /software
wget https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.37-el7-x86_64.tar.gz
tar -zxvf  mysql-5.7.37-el7-x86_64.tar.gz 
mkdir  /app 
mv mysql-5.7.37
ln -s /app/mysql-5.7.37  /app/mysql
rpm -e –nodeps mariadb-libs

