#!/bin/bash
# Author      : Kung
# Build       : 2022-08-11 11:39
# Version     : V1.0
# Description : Install Mysql           
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions

App_Path=/app
[ ! -d ${App_Path} ] && mkdir -p ${App_Path}
Soft_Path=/tool
[ ! -d ${Soft_Path} ] && mkdir -p ${Soft_Path}

Check_User(){
	if [ $UID -ne 0 ]
	 then
		echo "You are not supper user.Please use root"
		exit 1;
	fi	
}

Setup_User(){
	groupadd mysql
	useradd -s /sbin/nologin -g mysql -M mysql
	chown -R mysql:mysql ${App_Path}/mysql
}

Setup_Config(){
	echo "basedir=${App_Path}/mysql" >> /etc/my.cnf
	echo "datadir=${App_Path}/mysql/data" >> /etc/my.cnf
	echo "socket=/var/lib/mysql/mysql.sock">>/etc/my.cnf
	echo "server_id=1">>/etc/my.cnf
	echo "log_error=${App_Path}/mysql/data/mysql.err">>/etc/my.cnf
	echo "port=3306">>/etc/my.cnf
	echo "export PATH=${App_Path}/mysql/bin:$PATH">>/etc/profile
	source /etc/profile
}

Install_Mysql(){
	cd ${Soft_Path}/software
	#wget https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.37-el7-x86_64.tar.gz
	tar -zxvf  mysql-5.7.37-el7-x86_64.tar.gz 
	mv mysql-5.7.37-el7-x86_64 ${App_Path}/mysql-5.7.37
	ln -s ${App_Path}/mysql-5.7.37  ${App_Path}/mysql
	${App_Path}/mysql/bin/mysqld --initialize-insecure --user=mysql --basedir=${App_Path}/mysql --datadir=${App_Path}/mysql/data
	if [ $? -eq 0 ] 
         then
                 action "Success to install " /bin/true
        else
                 action "Fail to install" /bin/false
        fi  
}

Setup_daemon(){
	cp ${Soft_Path}/script/mysqld.service /etc/systemd/system/mysqld.service
	systemctl daemon-reload
  	systemctl enable mysqld
	systemctl start mysqld
}

main(){
	Check_User
	Setup_User
	Install_Mysql
	Setup_Config	
#	Setup_daemon
}
main 
