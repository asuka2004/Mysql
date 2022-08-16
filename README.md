Mysql 學習筆記  

Mysql Shell Script安裝腳本

作業系統:CentOS 7.9  資料庫:Mysql 5.7
一鍵安裝Mysql 5.7，壓縮包網址如下 https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.37-el7-x86_64.tar.gz
腳本內容包括，檢查是否安裝Mysql下載Mysql安裝包  執行安裝解壓及初始化   添加Mysql到環境變量，最後再啟動DB。
安裝步驟

1、下载安装脚本
从下载链接地址下载安装脚本压缩包，压缩包中包含安装脚本、mysql软件包、配置文件模板等一键安装mysql数据库脚本.zip下载链接

2、将压缩包上传到centos服务器
[test@localhost ~]$ mkdir mysql$ mkdir mysql
[test@localhost ~]$ rz -y
#将一键安装mysql数据库脚本.zip上传到服务器

3、解压压缩包
[test@localhost mysql]$ unzip 一键安装mysql数据库脚本.zip
Archive: 一键安装mysql数据库脚本.zip
inflating: clean.sh
inflating: my.cnf.bak
inflating: mysql_install.sh
inflating: mysql-5.7.32-el7-x86_64.tar.gz
inflating: startmysql.sh
inflating: stopmysql.sh

4、给脚本添加执行权限
[test@localhost mysql]$ chmod u+x *.sh

5、执行mysql安装脚本
[test@localhost mysql]$ sh mysql_install.sh

6、修改root初始密码


7、登录mysql实例检查
[test@localhost ~]$ mysql -uroot -p -h 127.0.0.1
Enter password:
Welcome to the MySQL monitor. Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 5.7.32-log MySQL Community Server (GPL)

Copyright © 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type ‘help;’ or ‘\h’ for help. Type ‘\c’ to clear the current input statement.
mysql>
————————————————
版权声明：本文为CSDN博主「恒悦sunsite」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/carefree2005/article/details/120666977

2. 新增、刪除、修改、查詢 資料  
3. 備份、刪除、還原 資料庫

 
