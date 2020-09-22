-- Для выполнения заданий к 5-му уроку создадим базу данных
DROP DATABASE IF EXISTS lesson_05;
CREATE DATABASE lesson_05;
USE lesson_05;

-- Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»
-- Задание 1
-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
-- Заполните их текущими датой и временем.

-- Создадим таблицу users
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- Заполним некоторыми данными с NULL в столбцах created_at и updated_at
INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', NULL, NULL),
  ('Наталья', '1984-11-12', NULL, NULL),
  ('Александр', '1985-05-20', NULL, NULL),
  ('Сергей', '1988-02-14', NULL, NULL),
  ('Иван', '1998-01-12', NULL, NULL),
  ('Мария', '1992-08-29', NULL, NULL);
 
-- Проверим что значения заполнились по условию задачи
SELECT * FROM users;

-- Обновим значения столбца created_at, выставив текущую дату, где NULL.
-- Значения в updated_at проставятся автоматически.
UPDATE users SET created_at = NOW() WHERE created_at is NULL; 

-- Проверим правильность выполнения
SELECT * FROM users;

-- Задание 2
-- Таблица users была неудачно спроектирована. 
-- Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
-- Создадим таблицу users
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- Заполним некоторыми данными
INSERT INTO users (name, birthday_at, created_at) VALUES
  ('Геннадий', '1990-10-05', '10.05.2001 8:10'),
  ('Наталья', '1984-11-12', '12.11.2002 9:10'),
  ('Александр', '1985-05-20', '20.05.2003 10:10'),
  ('Сергей', '1988-02-14', '14.02.2011 15:23'),
  ('Иван', '1998-01-12', '12.01.2012 20:00'),
  ('Мария', '1992-08-29', '29.08.2013 23:34');
 
-- Проверим что значения заполнились по условию задачи
SELECT * FROM users;

-- Добавим новый столбец типа DATETIME
ALTER TABLE users ADD new_created_at DATETIME;

-- Преобразуем строковые данные из created_at в тип даты нового столбца
UPDATE users SET new_created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i') WHERE created_at IS NOT NULL;

-- Проверим, что значения корректно заполнились
SELECT * FROM users;

-- Удалим старый столбец и переименуем новый
ALTER TABLE users DROP created_at, CHANGE new_created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;

-- Проверим свойства таблицы
DESC users;

-- Задание 3
-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
-- 0, если товар закончился и выше нуля, если на складе имеются запасы. 
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
-- Однако нулевые запасы должны выводиться в конце, после всех записей.

-- Создаём таблицу остатков
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

-- Заполняем тестовыми данными
INSERT INTO storehouses_products
  (storehouse_id, product_id, value)
VALUES
  (FLOOR(RAND()*11 + 1), FLOOR(RAND()*6 + 1), 0),
  (FLOOR(RAND()*11 + 1), FLOOR(RAND()*6 + 1), 2500),
  (FLOOR(RAND()*11 + 1), FLOOR(RAND()*6 + 1), 0),
  (FLOOR(RAND()*11 + 1), FLOOR(RAND()*6 + 1), 30),
  (FLOOR(RAND()*11 + 1), FLOOR(RAND()*6 + 1), 500),
  (FLOOR(RAND()*11 + 1), FLOOR(RAND()*6 + 1), 1);
 
-- Проверим значения
SELECT * FROM storehouses_products;

-- Отсортируем, как требуется
SELECT * FROM storehouses_products ORDER BY value=0, value;


-- Задание 4.
-- Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий (may, august)

-- Проверим список пользователей
SELECT * FROM users;

-- Выберем пользователей, родившихся в необходимый месяц: выделение имени месяца из даты рождения и приведение к нижнему регистру
SELECT * FROM users WHERE LOWER(MONTHNAME(birthday_at)) in ('may', 'august');


-- Задание 5.
-- Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.

-- Создадим таблицу catalogs
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

-- Заполним некоторыми значениями
INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');
 
-- Проверим заполненные данные
SELECT * FROM catalogs;

-- Выберем данные по условию.
-- Но вывод будет неотсортирован, как необходимо
SELECT * FROM catalogs WHERE id IN (5, 1, 2);

-- Сделаем выборку с сортировкой
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);


-- ----------------------------------------------------
-- Практическое задание теме «Агрегация данных»
-- Задание 1.
-- Подсчитайте средний возраст пользователей в таблице users.

-- Проверим список пользователей
SELECT * FROM users;

-- Вычисляем возраст пользователя:
-- Разница лет между текущей датой и годом рождения
-- и проверка по дню с месяцем: если больше текущей даты, то вычитается 1
SELECT
  *,
  (
    (YEAR(CURRENT_DATE) - YEAR(birthday_at)) -                             
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday_at, '%m%d'))
  ) AS age
FROM users;

-- Вычисляем средний возраст
SELECT
  AVG(
    (YEAR(CURRENT_DATE) - YEAR(birthday_at)) -                             
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday_at, '%m%d'))
  ) AS average_age
FROM users;

-- Задание 2.
-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

-- Проверим список пользователей
SELECT * FROM users;

-- Добавим пользователей, чтобы дни недели повторялись
INSERT INTO users (name, birthday_at) VALUES
  ('Алексей', '1990-10-07'),
  ('Светлана', '1984-11-13');

-- Приводим день рождения пользователя к текущему году через DATE_ADD и вычисляем день недели через DAYNAME
SELECT 
  *,
  DATE_FORMAT(DATE_ADD(birthday_at , INTERVAL (YEAR(CURRENT_DATE()) - YEAR(birthday_at)) YEAR), '%Y-%m-%d') AS birthday,
  (
    DAYNAME(DATE_FORMAT(DATE_ADD(birthday_at , INTERVAL (YEAR(CURRENT_DATE()) - YEAR(birthday_at)) YEAR), '%Y-%m-%d'))
  ) AS day_week
FROM users;

-- Группируем дни рождения в текущем году по дню недели и считаем количество
SELECT 
  DAYNAME(DATE_FORMAT(DATE_ADD(birthday_at , INTERVAL (YEAR(CURRENT_DATE()) - YEAR(birthday_at)) YEAR), '%Y-%m-%d'))
  AS day_week,
  COUNT(*) 
FROM users GROUP BY day_week;

-- Задание 3.
-- Подсчитайте произведение чисел в столбце таблицы.

-- Создадим временную таблицу множителей
DROP TABLE IF EXISTS tbl;
CREATE TEMPORARY TABLE tbl (
  value INT COMMENT 'Значение множителя'
) COMMENT = 'Таблица множителей';

-- Запишем значения множителей
INSERT INTO tbl (value) VALUES (1), (2), (3), (4), (5), (6);

-- Проверим данные
SELECT * FROM tbl;

-- Вычислим произведение множителей через логарифмы
SELECT EXP(SUM(LOG(value))) AS product FROM tbl;
