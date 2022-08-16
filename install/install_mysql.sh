#!/bin/bash
# Author      : Kung
# Build       : 2022-08-11 11:39
# Version     : V1.0
# Description : Install Mysql           
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions

App_Path=/app
[ ! -d ${App_Path} ] && mkdir -p ${App_Path}
Soft_Path=/soft
[ ! -d ${Soft_Path} ] && mkdir -p ${Soft_Path}

Check_User(){
	if [ $UID -ne 0 ]
	 then
		echo "You are not supper user.Please use root"
		exit 1;
	fi	
}

Install_Mysql(){
	useradd -s /sbin/nologin -g mysql -M mysql
	cd ${Soft_Path}
	wget https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.37-el7-x86_64.tar.gz
	tar -zxvf  mysql-5.7.37-el7-x86_64.tar.gz 
	mv mysql-5.7.37 ${App_Path}
	ln -s /app/mysql-5.7.37  ${App_Path}/mysql
	chown -R mysql:mysql ${App_Path}/mysql
	${App_Path}/mysql/bin/mysqld --initialize-ubsecure --user=mysql --basedir=${App_Path}/mysql --datadir=${App_Path}/mysql/data
}

Setup_Config(){
	echo "datadir=/app/mysql/data" >> /etc/mysql.cnf
	echo "socket=/var/lib/mysql/mysql.sock">>/etc/mysql.cnf
	echo "server_id=1">>/etc/mysql.cnf
	echo "log_error=/var/log/mysqld.log">>/etc/mysql.cnf
	echo "port=3306">>/etc/mysql.cnf
	echo "export PATH=/app/mysql/bin:$PATH">>/etc/profile
	source /etc/profile
}

Setup_systemctl(){
	cp ${Soft_Path}/mysqld.service /etc/systemd/system/mysqld.service
	systemctl daemon-reload
  	systemctl enable mysqld
	systemctl start mysqld
}

main(){
	Check_User
	Install_Mysql	
	Setup_Config
	Setup_systemctl
}
main 
