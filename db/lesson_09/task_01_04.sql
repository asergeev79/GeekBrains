-- Практическое задание по теме “Транзакции, переменные, представления”
-- Пусть имеется любая таблица с календарным полем created_at. 
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

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

-- Создадим представление, которрое выбирает 5 самых новых записей 
CREATE VIEW newest_rows_5 AS SELECT id FROM tbl ORDER BY created_at DESC LIMIT 5;

SELECT * FROM tbl;
SELECT * FROM newest_rows_5 ;

-- Удаляем из таблицы все записи, которые не попадают в представление
DELETE FROM tbl WHERE id NOT IN (SELECT id FROM newest_rows_5);

-- Проверим, что остались только 5 записей из прредставления
SELECT * FROM tbl;
