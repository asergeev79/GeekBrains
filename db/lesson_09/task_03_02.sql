-- ������������ ������� �� ���� ��������� ��������� � �������, ��������"
-- 2. � ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������. 
-- ��������� ����������� ����� ����� ��� ���� �� ���. 
-- ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������. 
-- ��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������. 
-- ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.

USE shop;

DESC products ;
SELECT name,description FROM products p ;

-- �������� ������� �� �������
-- ���� ��� ���� ����� NULL, �� ���������� ���������� � ������� ��� ��������
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

-- �������� ������
INSERT INTO products (name,description) VALUES ('test',NULL);
SELECT * FROM products p ;

INSERT INTO products (name,description) VALUES (NULL,'test');
SELECT * FROM products p ;

INSERT INTO products (name,description) VALUES ('test','test');
SELECT * FROM products p ;

-- ����� ������ ������
INSERT INTO products (name,description) VALUES (NULL,NULL);
SELECT * FROM products p ;

-- �������� ������� �� ����������
-- ���� ��� ���� ����� NULL, �� ���������� ���������� � ���������� �� ��������
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

-- �������� ������ ��������
-- � ������ � id 10 ��� ���� ��������� - ������ �� �����
UPDATE products SET name = NULL WHERE id = 10;
SELECT * FROM products p ;

-- � ������ � id 8 description=NULL - ������� ���������
UPDATE products SET name = NULL WHERE id = 8;
SELECT * FROM products p ;
