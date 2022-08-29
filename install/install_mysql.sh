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
	echo "Add User Mysql. Please wait.................."
	groupadd mysql
	useradd -s /sbin/nologin -g mysql -M mysql
}

Install_Mysql(){
	echo "Start to install Mysql. Please wait.........."
	cd ${Soft_Path}/software
	#wget https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.37-el7-x86_64.tar.gz
	tar -zxvf  mysql-5.7.37-el7-x86_64.tar.gz 
	mv mysql-5.7.37-el7-x86_64 ${App_Path}/mysql-5.7.37
	ln -s ${App_Path}/mysql-5.7.37  ${App_Path}/mysql
	chown -R mysql:mysql ${App_Path}/mysql*
	${App_Path}/mysql/bin/mysqld --initialize-insecure --user=mysql --basedir=${App_Path}/mysql --datadir=${App_Path}/mysql/data 
	if [ $? -eq 0 ] 
         then
                 action "Success to install Mysql " /bin/true
        else
                 action "Fail to install Mysql" /bin/false
		 exit
        fi  
}

Setup_Config(){
	echo "Setup Mysql config. Please wait..............."
	echo "[mysqld]" >> /etc/my.cnf
	echo "basedir=${App_Path}/mysql" >> /etc/my.cnf
	echo "datadir=${App_Path}/mysql/data" >> /etc/my.cnf
	echo "socket=/tmp/mysql.sock">>/etc/my.cnf
	echo "server_id=1">>/etc/my.cnf
	echo "user=mysql">>/etc/my.cnf
	echo "log_error=${App_Path}/mysql/data/mysql.err">>/etc/my.cnf
	echo "port=3306">>/etc/my.cnf
	echo "export PATH=${App_Path}/mysql/bin:$PATH">>/etc/profile
	source /etc/profile
}

Setup_daemon(){
	echo "Setup daemon program. Please wait............."
	cp ${Soft_Path}/script/mysqld.service /etc/systemd/system/mysqld.service
	systemctl daemon-reload
  	systemctl enable mysqld
	systemctl start mysqld
	if [ $? -eq 0 ] 
         then
                 action "Success to daemon system" /bin/true
        else
                 action "Fail to daemon system" /bin/false
		 exit
        fi  
}

main(){
	Check_User
	echo -e "------------------------------------------------------------------- \n" 	
	Setup_User
	echo -e "------------------------------------------------------------------- \n" 
	Install_Mysql
	echo -e "------------------------------------------------------------------- \n" 
	Setup_Config
	echo -e "------------------------------------------------------------------- \n" 
	Setup_daemon
}
main 
