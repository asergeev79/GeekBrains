-- ������������ ������� �� ���� �����������, ����������, ��������������
-- ����� ������� ����� ������� � ����������� ����� created_at. 
-- �������� ������, ������� ������� ���������� ������ �� �������, �������� ������ 5 ����� ������ �������.

USE lesson_09;

-- �������� ������� � ����������� ����� created_at
DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl (
  id SERIAL PRIMARY KEY,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- �������� �������� ���������, ������� ��������� ������� ���������� ������ 2018-�� ����
DELIMITER //
DROP PROCEDURE IF EXISTS tbl_ins//
CREATE PROCEDURE tbl_ins(IN number INT)
BEGIN
	DECLARE x INT(11);
	SET x = 1;    
	WHILE x <= number
	DO
 		INSERT INTO tbl(created_at)
 		VALUES(
 			FROM_UNIXTIME(
    		UNIX_TIMESTAMP('2018-1-1') + FLOOR(RAND() * (UNIX_TIMESTAMP('2018-12-31') - UNIX_TIMESTAMP('2018-1-1') + 1))
			));
 		SET  x = x + 1; 
 	END WHILE;

END//
DELIMITER ;

-- �������� � ������� 100 �������
CALL tbl_ins(100);

-- �������� �������������, �������� �������� 5 ����� ����� ������� 
CREATE VIEW newest_rows_5 AS SELECT id FROM tbl ORDER BY created_at DESC LIMIT 5;

SELECT * FROM tbl;
SELECT * FROM newest_rows_5 ;

-- ������� �� ������� ��� ������, ������� �� �������� � �������������
DELETE FROM tbl WHERE id NOT IN (SELECT id FROM newest_rows_5);

-- ��������, ��� �������� ������ 5 ������� �� ��������������
SELECT * FROM tbl;
