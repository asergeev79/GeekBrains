#!/bin/bash

echo "Executing task 1:" > lesson_02.log
echo "Creating '~/.my.cnf' file..." >> lesson_02.log
rm -f ~/.my.cnf
echo "[client]" > ~/.my.cnf
echo "user=root" >> ~/.my.cnf
echo "password=12345678" >> ~/.my.cnf
chmod 0600 ~/.my.cnf
echo `ls -la ~/.my.cnf` >> lesson_02.log
echo "$HOME/.my.cnf:" >> lesson_02.log
cat ~/.my.cnf >> lesson_02.log
echo "" >> lesson_02.log
cat lesson_02.log
read -p "Press any key for task 2"

echo "Executing task 2:" >> lesson_02.log
echo "Running SQL script 'mysql < task_02.sql'" >> lesson_02.log
echo "task_02.sql:" >> lesson_02.log
cat task_02.sql >> lesson_02.log
echo "" >> lesson_02.log
mysql < task_02.sql >> lesson_02.log
echo "" >> lesson_02.log
cat lesson_02.log
read -p "Press any key for task 3"

echo "Executing task 3:" >> lesson_02.log
echo "Dumping database 'example': mysqldump example > dump_example.sql" >> lesson_02.log
mysqldump example > dump_example.sql
echo "Running SQL script 'mysql < task_03.sql'" >> lesson_02.log
echo "task_03.sql:" >> lesson_02.log
cat task_03.sql >> lesson_02.log
echo "" >> lesson_02.log
mysql < task_03.sql >> lesson_02.log
echo "Undumping database 'example' to database 'sample': mysql sample < dump_example.sql" >> lesson_02.log
mysql sample < dump_example.sql
echo "Show tables of 'sample':" >> lesson_02.log
mysql sample -e "describe users;show tables;" >> lesson_02.log
echo "" >> lesson_02.log
cat lesson_02.log
read -p "Press any key for task 4"

echo "Executing task 4:" >> lesson_02.log
echo "Dumping first 100 rows from table 'help_keyword' of database 'mysql': " >> lesson_02.log
echo "mysqldump --opt --where='1 limit 100' --no-create-info mysql help_keyword > dump_mysql_hk_100rows.sql" >> lesson_02.log
mysqldump --opt --where="1 limit 100" --no-create-info mysql help_keyword > dump_mysql_hk_100rows.sql
echo "" >> lesson_02.log
cat lesson_02.log
cat dump_mysql_hk_100rows.sql

