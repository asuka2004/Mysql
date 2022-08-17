#!/bin/bash
# Author      : Kung
# Build       : 2022-06-16 23:21
# Version     : V1.0
# Description : Monitor Mysql            
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions

if [ `netstat -ntulp|grep mysqld|wc -l` -gt 0 ]
 then
	echo  "Mysql is OK"  >/dev/null 2>&1
else
	Critical="Waining!!!! Mysql is down"
	echo $Critical | tee | mail -s "$Critical" root@localhost
	exit 2
fi
