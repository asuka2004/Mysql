# Mysql 學習筆記  

作業環境  OS: CentOS 7.9  DB: Mysql 5.7

官網載點  網址如下 https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.37-el7-x86_64.tar.gz

### Install DB Script

腳本內容: 下載Mysql、執行解壓縮及並初始化、環境設定、啟動DB等。 

下载Script脚本、Mysql程式、配置文件，執行install_mysql.sh
 
### CRUD Script

1.執行create_data.sh 可以產生千萬級別的sql語法，並source /tmp/sql.txt匯入
 
2.執行crud.sh，可以新增、刪除、修改、查詢資料

### Backup DB Script
    
執行backup_db.sh，備份、刪除、還原資料庫

### Monitor DB Script
    
1.執行monitor_db，監控Mysql並加入排程 

2.加入排程 指令如下
   echo "Monitor DB" >>/var/spool/cron/root
   echo */5 * * * * /use/bin/sh -x /root/project/Mysql/monitor/monitor_db.sh >>/var/spool/cron/root
