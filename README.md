Mysql 學習筆記  

Mysql 5.7 Script安裝腳本
官網 Mysql載點  網址 https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.37-el7-x86_64.tar.gz
腳本內容: 下載mysql 執行解壓及初始化 環境設定  啟動DB。

OS: CentOS 7.9  DB: Mysql5.7
步驟如下
1.下载安装脚本、Mysql程式、配置文件  並上傳至CentOS7.9
2.执行安装脚本 sh install_mysql.sh
 
產生千萬級別的sql 腳本 create_data.sh
登入Mysql 並執行 source /tmp/sql.txt 匯入檔案
執行crud.sh  可以新增、刪除、修改、查詢資料

執行backup_db.sh 備份、刪除、還原 資料庫

執行monitor_db  監控Mysql 
