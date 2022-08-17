**Mysql 學習筆記**  

OS: CentOS 7.9  DB: Mysql 5.7

官網 Mysql載點  網址  https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.37-el7-x86_64.tar.gz

### Install資料庫腳本

腳本內容: 下載Mysql、執行解壓縮及並初始化、環境設定、啟動DB等。

步驟如下

1.下载Script脚本、Mysql程式、配置文件，並上傳至CentOS7.9

2.執行sh install_mysql.sh
 
### CRUD腳本

1.執行create_data.sh 可以產生千萬級別的sql語法，並source /tmp/sql.txt匯入
 
2.執行crud.sh，可以新增、刪除、修改、查詢資料

### Backup 資料庫腳本
    
執行backup_db.sh，備份、刪除、還原資料庫

### Monitor 資料庫腳本
    
執行monitor_db，監控Mysql並加入排程 
