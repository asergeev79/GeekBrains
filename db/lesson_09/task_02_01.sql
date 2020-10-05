-- Практическое задание по теме “Администрирование MySQL”
-- 1. Создайте двух пользователей которые имеют доступ к базе данных shop. 
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
-- второму пользователю shop — любые операции в пределах базы данных shop.

SELECT Host,User FROM mysql.`user` u ;

-- Создаём пользователей
CREATE USER 'shop_read'@'localhost' IDENTIFIED BY '12345678';
CREATE USER 'shop'@'localhost' IDENTIFIED BY '12345678';

-- Предоставляем привилегии на базу shop
GRANT SELECT ON shop.* TO 'shop_read'@'localhost';
GRANT ALL ON shop.* TO 'shop'@'localhost';

-- На скриншотах видно, что привилегии отрабатывают корректно