#!/bin/bash
# Author      : Kung
# Build       : 2022-08-11 10:39
# Version     : V1.0
# Description : Create big data             
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

echo "Please input Servnum Number:"
read Server
echo "Please input SQL Number:"
read Number
for (( i=0;i<$Number;i++ ))
do
	Pass=`head /dev/urandom | tr -dc a-z | head -c 8`
	let Server=Server+1
	echo "insert into test(id,username,servnumber,password,createtime)
	values('$i','user${i}','${Server}','${Pass}',now());" >>sql.txt
done
