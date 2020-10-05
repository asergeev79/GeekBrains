-- Практическое задание по теме “Оптимизация запросов”
-- 2. Создайте SQL-запрос, который помещает в таблицу users миллион записей.

USE shop;

DESC users;

SELECT * FROM users;

-- В учебной таблице users базы shop 6 записей.
-- Добавим ещё 4.
INSERT INTO users (name, birthday_at) VALUES
  ('Алексей', '1990-10-05'),
  ('Светлана', '1984-11-12'),
  ('Андрей', '1985-05-20'),
  ('Надежда', '1988-02-14');

-- Проверим, что в таблице users 10 записей
 SELECT * FROM users ;
 
-- Чтобы вставить 1000000 записей,
-- достаточно выбрать записи из JOIN'а 6 таблиц: 10х10х10х10х10х10
-- Можно не добавлять записи на предыдущем шаге, но тогда больше таблиц будет участвовать в JOIN
INSERT INTO users(name)
SELECT u1.name 
FROM 
	users u1 
	JOIN 
	users u2 
	JOIN 
	users u3 
	JOIN 
	users u4 
	JOIN 
	users u5 
	JOIN 
	users u6 
;

-- Проверим, что записей в таблице больше 1 млн
SELECT * FROM users WHERE id > 1000000;
