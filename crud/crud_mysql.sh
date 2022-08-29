#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 10:52
# Version     : V1.0
# Description : Create&Backup&Restore database on MySql5.7             
# System      : CentOS 7.9
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
#export MYSQL_PWD=${password}
[ -f /etc/init.d/functions ] && . /etc/init.d/functions

App_Path=/app
[ ! -d ${App_Path} ] && mkdir -p ${App_Path}
Soft_Path=/tool
[ ! -d ${Soft_Path} ] && mkdir -p ${Soft_Path}

SOCKET=/tmp/mysql.sock
MYCMD="${App_Path}/mysql/bin/mysql --login-path=Pwd -S $SOCKET -h localhost"

Create_db(){
	echo "Create&Insert database and table. Please Wait ........ ....."
	$MYCMD -e "create database db1;use db1;create table test(id int(7) zerofill auto_increment not null,username varchar(20),servnumber varchar(30),password varchar(20),createtime datetime,primary key (id))DEFAULT CHARSET=utf8;source ${Soft_Path}/script/sql.txt;"
	if [ $? -eq 0 ] 
         then
                 action "Success to create database " /bin/true
        else
                 action "Fail to create database" /bin/false
		 exit
        fi  
}

Read_db(){
	echo "Select user from db. Please wait ........................"
	$MYCMD -e "use db1;select * from test where username='user10';"
	if [ $? -eq 0 ] 
         then
                 action "Success to select user " /bin/true
        else
                 action "Fail to select user" /bin/false
		 exit
        fi  
}

Update_db(){
	echo "Update information. Please wait ........"
	$MYCMD -e "use db1;update test set username='Kung' where username='user10';"
	if [ $? -eq 0 ] 
         then
                 action "Success to update " /bin/true
        else
                 action "Fail to update" /bin/false
		 exit
        fi  
}

Delete_db(){
	echo "Delete user from db. Please wait .........."
	$MYCMD -e "use db1;delete from test where username='user100';"
	if [ $? -eq 0 ] 
         then
                 action "Success to delete " /bin/true
        else
                 action "Fail to delete" /bin/false
		 exit
        fi  
}

main(){
	Create_db
	echo -e "------------------------------------------------------------------- \n"	
	Read_db
	echo -e "------------------------------------------------------------------- \n"	
	Update_db	
	echo -e "------------------------------------------------------------------- \n"	
	Delete_db
}
main
