-- Практическое задание по теме “Оптимизация запросов”
-- 1. Создайте таблицу logs типа Archive. 
-- Пусть при каждом создании записи в таблицах users, catalogs и products 
-- в таблицу logs помещается время и дата создания записи, название таблицы, 
-- идентификатор первичного ключа и содержимое поля name.

USE shop;

DESC users ;
DESC catalogs ;
DESC products ;

-- Создадим таблицу типа Archive
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "время создания записи",
	table_name VARCHAR(255) NOT NULL COMMENT "название таблицы",
	pk_id BIGINT UNSIGNED NOT NULL COMMENT "идентификатор первичного ключа",
	name VARCHAR(255) COMMENT "содержимое поля name"
	) COMMENT="таблица для журналирования создания записей" ENGINE=Archive;

DESC logs;

-- Создадим триггеры, по которым будем создаваться запись в logs после добавления записей в нужные таблицы
DELIMITER //
DROP TRIGGER IF EXISTS log_users_insert//
CREATE TRIGGER log_users_insert AFTER INSERT ON users
FOR EACH ROW 
BEGIN 
	INSERT INTO logs(table_name,pk_id,name) VALUES ('users',NEW.id,NEW.name);
END//

DROP TRIGGER IF EXISTS log_catalogs_insert//
CREATE TRIGGER log_catalogs_insert AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN 
	INSERT INTO logs(table_name,pk_id,name) VALUES ('catalogs',NEW.id,NEW.name);
END//

DROP TRIGGER IF EXISTS log_product_insert//
CREATE TRIGGER log_product_insert AFTER INSERT ON products
FOR EACH ROW 
BEGIN 
	INSERT INTO logs(table_name,pk_id,name) VALUES ('products',NEW.id,NEW.name);
END//
DELIMITER ;

-- Вставим некоторые записи
INSERT INTO users(name) VALUES ('Вова');
INSERT INTO catalogs(name) VALUES ('Сетевые адаптеры');

-- Проверим, что добавились записи в logs
SELECT * FROM logs;

-- Попробуем удалить запись из logs - ошибка будет
DELETE FROM logs WHERE name LIKE 'Вова';
