#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 10:52
# Version     : V1.0
# Description : Create&Backup&Restore database on MySql5.7             
# System      : CentOS 7.9
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
export MYSQL_PWD=${password}
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}
DBPATH=/root/tmp
[ ! -d "$DBPATH" ] && mkdir $DBPATH

SOCKET=/var/lib/mysql/mysql.sock
MYCMD="mysql --login-path=Kung -S $SOCKET -h localhost"
MYDUMP="mysqldump --login-path=Kung -S $SOCKET -h localhost --no-tablespaces --single-transaction"


Backup_db(){
	for dbname in `$MYCMD -e "show databases;"|sed '1d'|egrep -v "mysql|schema|performance_schema|sys|information_schema"` 
	do
 		mkdir -p $DBPATH/${dbname}_$(date +%F) 
		$MYDUMP $dbname |gzip >$DBPATH/${dbname}_$(date +%F)/${dbname}.sql.gz
	done
}

Del_db(){
	$MYCMD -e "use db1;truncate table test;"	
}

Restore_db(){
	gunzip ${DBPATH}/${dbname}_$(date +%F)/${dbname}.sql.gz 
	$MYCMD ${dbname}<${DBPATH}/${dbname}_$(date +%F)/${dbname}.sql	
}

main(){
	Backup_db
	echo "Backup table. Please wait ........"
	Del_db	
	echo "Del table.Please wait ........"
	Restore_db
	echo "Restore information Please wait....."
}
main
