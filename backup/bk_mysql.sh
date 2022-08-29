#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 10:52
# Version     : V1.0
# Description : Create&Backup&Restore database on MySql5.7             
# System      : CentOS 7.9
			       
export PS4='++ ${LINENO}'  
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions

App_Path=/app
[ ! -d ${App_Path} ] && mkdir -p ${App_Path}
Soft_Path=/tool
[ ! -d ${Soft_Path} ] && mkdir -p ${Soft_Path}
DBPATH=/backup
[ ! -d "$DBPATH" ] && mkdir $DBPATH

SOCKET=/tmp/mysql.sock
MYCMD="${App_Path}/mysql/bin/mysql --login-path=Pwd -S $SOCKET -h localhost"
MYDUMP="${App_Path}/mysql/bin/mysqldump --login-path=Pwd -S $SOCKET -h localhost --no-tablespaces --single-transaction"

Backup_db(){
	echo "Backup table. Please wait ........"
	for dbname in `$MYCMD -e "show databases;"|sed '1d'|egrep -v "mysql|schema|performance_schema|sys|information_schema"` 
	do
 		mkdir -p $DBPATH/${dbname}_$(date +%F) 
		$MYDUMP $dbname |gzip >$DBPATH/${dbname}_$(date +%F)/${dbname}.sql.gz
	done
	if [ $? -eq 0 ] 
         then
                 action "Success to backup " /bin/true
        else
                 action "Fail to backup" /bin/false
                 exit
        fi  
}

Del_db(){
	echo "Del table.Please wait ........"
	$MYCMD -e "use db1;truncate table test;"
	if [ $? -eq 0 ] 
         then
                 action "Success to del " /bin/true
        else
                 action "Fail to del" /bin/false
                 exit
        fi  	
}

Restore_db(){
	echo "Restore db. Please wait....."
	gunzip ${DBPATH}/db1_2022-08-28/db1.sql.gz 
	$MYCMD db1<${DBPATH}/db1_2022-08-28/db1.sql
	if [ $? -eq 0 ] 
         then
                 action "Success to restore " /bin/true
        else
                 action "Fail to restore" /bin/false
                 exit
        fi  	
}

main(){
	Backup_db
	echo -e "-----------------------------------------------------------------\n"
	Del_db
	echo -e "-----------------------------------------------------------------\n"	
	Restore_db
}
main $*
