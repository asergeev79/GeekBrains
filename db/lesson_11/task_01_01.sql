-- ������������ ������� �� ���� ������������ ��������
-- 1. �������� ������� logs ���� Archive. 
-- ����� ��� ������ �������� ������ � �������� users, catalogs � products 
-- � ������� logs ���������� ����� � ���� �������� ������, �������� �������, 
-- ������������� ���������� ����� � ���������� ���� name.

USE shop;

DESC users ;
DESC catalogs ;
DESC products ;

-- �������� ������� ���� Archive
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
	table_name VARCHAR(255) NOT NULL COMMENT "�������� �������",
	pk_id BIGINT UNSIGNED NOT NULL COMMENT "������������� ���������� �����",
	name VARCHAR(255) COMMENT "���������� ���� name"
	) COMMENT="������� ��� �������������� �������� �������" ENGINE=Archive;

DESC logs;

-- �������� ��������, �� ������� ����� ����������� ������ � logs ����� ���������� ������� � ������ �������
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

-- ������� ��������� ������
INSERT INTO users(name) VALUES ('����');
INSERT INTO catalogs(name) VALUES ('������� ��������');

-- ��������, ��� ���������� ������ � logs
SELECT * FROM logs;

-- ��������� ������� ������ �� logs - ������ �����
DELETE FROM logs WHERE name LIKE '����';
