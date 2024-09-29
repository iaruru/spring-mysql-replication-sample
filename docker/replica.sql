-- source 서버 root 계정으로 실행
CREATE USER 'repl'@'%' IDENTIFIED BY 'repl_password';
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';
FLUSH PRIVILEGES;
SHOW MASTER STATUS;

-- replica 서버 root 계정으로 실행
CHANGE MASTER TO
    MASTER_HOST='mysql_source',
    MASTER_USER='repl',
    MASTER_PASSWORD='repl_password',
    MASTER_LOG_FILE='mysql-bin.000003', -- source 서버의 File 값
    MASTER_LOG_POS=571; -- source 서버의 Position 값

START SLAVE;
SHOW SLAVE STATUS;