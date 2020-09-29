-- Практическое задание по теме “Транзакции, переменные, представления”
-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы products
-- и соответствующее название каталога name из таблицы catalogs.

-- Воспользуемся учебной базой shop
DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;

SELECT * FROM products;
SELECT * FROM catalogs;

-- Создаём представление выыборки
-- Учитываем, что у продукта может не быть каталога
CREATE VIEW prod_cat AS
SELECT p.name prod_name, c.name cat_name FROM products p LEFT JOIN catalogs c ON p.catalog_id = c.id;

-- Проверяем представление
SELECT * FROM prod_cat;