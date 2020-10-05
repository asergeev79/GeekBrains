-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. 
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

USE shop;

DESC products ;
SELECT name,description FROM products p ;

-- Создадим триггер на вставку
-- Если оба поля равны NULL, то вызывается исключение и вставка неи проходит
DELIMITER //
DROP TRIGGER IF EXISTS check_products_name_desc_insert//
CREATE TRIGGER check_products_name_desc_insert BEFORE INSERT ON products
FOR EACH ROW 
BEGIN 
	IF (NEW.name IS NULL AND NEW.description IS NULL) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
	END IF;
END//
DELIMITER ;

-- Проверим работу
INSERT INTO products (name,description) VALUES ('test',NULL);
SELECT * FROM products p ;

INSERT INTO products (name,description) VALUES (NULL,'test');
SELECT * FROM products p ;

INSERT INTO products (name,description) VALUES ('test','test');
SELECT * FROM products p ;

-- Здесь выдаст ошибку
INSERT INTO products (name,description) VALUES (NULL,NULL);
SELECT * FROM products p ;

-- Создадим триггер на обновление
-- Если оба поля равны NULL, то вызывается исключение и обновление не проходит
DELIMITER //
DROP TRIGGER IF EXISTS check_products_name_desc_update//
CREATE TRIGGER check_products_name_desc_update BEFORE UPDATE ON products
FOR EACH ROW 
BEGIN 
	IF (NEW.name IS NULL AND NEW.description IS NULL) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled';
	END IF;
END//
DELIMITER ;

-- Проверим работу триггера
-- в записи с id 10 оба поля заполнены - ошибки не будет
UPDATE products SET name = NULL WHERE id = 10;
SELECT * FROM products p ;

-- в записи с id 8 description=NULL - триггер сработает
UPDATE products SET name = NULL WHERE id = 8;
SELECT * FROM products p ;
