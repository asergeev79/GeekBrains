-- Практическое задание по теме “Транзакции, переменные, представления”
-- 3.  Пусть имеется таблица с календарным полем created_at. 
-- В ней размещены разряженые календарные записи за август 2018 года 
-- '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
-- Составьте запрос, который выводит полный список дат за август, 
-- выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

DROP DATABASE IF EXISTS lesson_09;
CREATE DATABASE lesson_09;
USE lesson_09;

-- Создадим таблицу с календарным полем created_at
DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl (
  id SERIAL PRIMARY KEY,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Создадим хранимую процедуру, которая заполняет таблицу случайными датами 2018-го года
DELIMITER //
DROP PROCEDURE IF EXISTS tbl_ins//
CREATE PROCEDURE tbl_ins(IN number INT)
BEGIN
	DECLARE x INT(11);
	SET x = 1;    
	WHILE x <= number
	DO
 		INSERT INTO tbl(created_at)
 		VALUES(
 			FROM_UNIXTIME(
    		UNIX_TIMESTAMP('2018-1-1') + FLOOR(RAND() * (UNIX_TIMESTAMP('2018-12-31') - UNIX_TIMESTAMP('2018-1-1') + 1))
			));
 		SET  x = x + 1; 
 	END WHILE;

END//
DELIMITER ;

-- Создадим в таблице 100 записей
CALL tbl_ins(100);

-- Создадим представление, которое выбирает записи, созданные в августе 2018-го
CREATE VIEW august_tbl AS
SELECT * FROM tbl WHERE YEAR(created_at) = 2018 AND MONTH(created_at) = 8;

SELECT DATE(created_at) FROM august_tbl ORDER BY created_at;

-- Создадим представление, которые выводит полный список дат августа 2018-го
CREATE VIEW august_table AS 
SELECT * FROM 
(SELECT adddate('1970-01-01',t4*10000 + t3*1000 + t2*100 + t1*10 + t0) selected_date FROM
 (SELECT 0 t0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,
 (SELECT 0 t1 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
 (SELECT 0 t2 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
 (SELECT 0 t3 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,
 (SELECT 0 t4 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t4) v
WHERE selected_date BETWEEN '2018-08-01' AND '2018-08-31' ORDER BY selected_date;

SELECT * FROM august_table ;

-- В этом запросе выбираем все записи из представления с датами августа
-- и во втором столбце ставим проверку наличия даты в изначальной таблице
SELECT 
	aug1.selected_date, 
	(SELECT EXISTS(SELECT * FROM august_tbl aug2 WHERE aug1.selected_date = DATE(aug2.created_at))) AS day_exists 
FROM august_table aug1;
