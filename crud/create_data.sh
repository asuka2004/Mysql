#!/bin/bash
# Author      : Kung
# Build       : 2022-08-11 10:39
# Version     : V1.0
# Description : Create big data             
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/tool/script
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}

read -p "Please input ServNumber:" Server
read -p "Please input SQL Number:" Number

for (( i=0;i<$Number;i++ ))
do
	Pwd=`head /dev/urandom | tr -dc a-z | head -c 8`
	let Server=Server+1
	echo "insert into test(id,username,servnum,password,createtime)
	values('$i','user${i}','${Server}','${Pwd}',now());" >>${Script_Path}/sql.txt
done
