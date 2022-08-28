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

App_Path=/app
[ ! -d ${App_Path} ] && mkdir -p ${App_Path}
Soft_Path=/tool
[ ! -d ${Soft_Path} ] && mkdir -p ${Soft_Path}

File_Path=/var/spool/cron/root

if [ `grep "monitor_mysql" ${File_Path}|wc -l` -lt 1 ]
 then
	echo "Monitor DB" >>/var/spool/cron/root
	echo "*/5 * * * * /bin/sh  ${Soft_Path}/script/monitor_mysql.sh" >>/var/spool/cron/root
else
	echo " "		
fi


if [ `netstat -ntulp|grep mysqld|wc -l` -gt 0 ]
 then
	echo  "Mysql is normal"  >/dev/null 2>&1
else
	Critical="Warning!!!! Mysql is down"
	echo $Critical | tee | mail -s "$Critical" root@localhost
fi
