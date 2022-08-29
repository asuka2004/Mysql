# Mysql 學習筆記  

作業環境  OS: CentOS 7.9  DB: Mysql 5.7  

目前採用二進制安裝  官網載點 https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.37-el7-x86_64.tar.gz

### Install DB Script

1.安裝腳本: install_mysql.sh 

2.Mysql設定檔: my.cnf 

3.常駐程式設定檔: mysqld.service

### CRUD Script

1.create_data.sh 可以產生大量的sql語法檔案sql.txt，並匯入mysql
 
2.crud_mysql.sh，增、刪、修、查資料

### Backup DB Script
    
1.bk_mysql.sh，備份、刪除、還原資料庫

### Monitor DB Script
    
1.monitor_mysql.sh，監控Mysql並加入排程 

