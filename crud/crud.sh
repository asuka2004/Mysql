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


SOCKET=/var/lib/mysql/mysql.sock
MYCMD="mysql --login-path=Kung -S $SOCKET -h localhost"

Create_db(){
	$MYCMD -e "create database db1;use db1;create table test(id int(7) zerofill auto_increment not null,username varchar(20),servnumber varchar(30),password varchar(20),createtime datetime,primary key (id))DEFAULT CHARSET=utf8;source /root/tmp/sql.txt;source /tmp/sql.txt"
}

Read_db(){
	$MYCMD -e "use db1;select * from test where username='user0';"
}

Update_db(){
	$MYCMD -e "use db1;update test set username='Kung' where username='user0';"
}

Delete_db(){
	$MYCMD -e "use db1;delete from test where username='Kung';"
}

main(){
	Create_db
	echo "Create&Insert database and table. Please Wait ....."
	Read_db
	echo "Select user. Please wait ........"
	Update_db	
	echo "Del user. Please wait ........"
	Delete_db
	echo "Delete user. Please wait....."
}
main
