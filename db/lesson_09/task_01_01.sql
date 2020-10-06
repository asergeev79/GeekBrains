-- Практическое задание по теме “Транзакции, переменные, представления”
-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

-- Создадим учебные базы shop и sample
DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;

DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;

-- Наполним их данными из урока: source06.zip
-- При этом в базе sample только создаём таблицы без наполнения данными.

-- Проверяем наличие данных
SELECT * FROM shop.users;
-- В базе sample можно на всякий случай таблицу users почистить
TRUNCATE TABLE sample.users; 
SELECT * FROM sample.users;

-- Начинаем транзакцию
START TRANSACTION;
-- Вставляем в таблицу users базы sample запись с id=1 из такой же таблицы базы shop 
INSERT INTO sample.users SELECT * FROM shop.users WHERE shop.users.id = 1;
-- Удаляем запись из таблицы users базы shop
DELETE FROM shop.users WHERE shop.users.id = 1;
-- На данном этапе можно проверить из другого соединения, что таблицы не изменились
COMMIT;
-- После коммита изменения в базах видны

