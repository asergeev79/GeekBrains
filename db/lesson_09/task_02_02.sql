-- Практическое задание по теме “Администрирование MySQL”
-- Пусть имеется таблица accounts содержащая три столбца id, name, password, 
-- содержащие первичный ключ, имя пользователя и его пароль. 
-- Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. 
-- Создайте пользователя user_read, который бы не имел доступа к таблице accounts, 
-- однако, мог бы извлекать записи из представления username.

USE lesson_09;

-- Создадим таблицу accounts
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя пользователя',
  password VARCHAR(255) COMMENT 'Пароль'
);

-- Наполним таблицу данными
INSERT INTO accounts (name, password) VALUES
  ('Геннадий', 'sdshdbfjsr'),
  ('Наталья', 'zvdtbujetyk'),
  ('Александр', 'saevdubidyknl'),
  ('Сергей', 'svbdynk'),
  ('Иван', 'ssvdbuy'),
  ('Мария', 'cdrvfj');

SELECT * FROM accounts;

-- Создадим представление
CREATE VIEW username AS SELECT id,name FROM accounts;
SELECT * FROM username;

-- Создадим пользователя и дадим необходимые привилегии:
-- доступ только к представлению username базы lesson_09
CREATE USER 'user_read'@'localhost' IDENTIFIED BY '12345678';
GRANT SELECT ON lesson_09.username TO 'user_read'@'localhost';

-- На скриншоте видна корректность работы привилегий