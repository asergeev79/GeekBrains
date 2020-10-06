-- ������������ ������� �� ���� ��������� ��������� � �������, ��������"
-- �������� �������� ������� ��� ���������� ������������� ����� ���������. 
-- ������� ��������� ���������� ������������������ � ������� ����� ����� ����� ���� ���������� �����. 
-- ����� ������� FIBONACCI(10) ������ ���������� ����� 55.

USE shop;

DELIMITER //
DROP FUNCTION IF EXISTS fibonacci//
CREATE FUNCTION fibonacci(num INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE fib1 INT DEFAULT 0;
	DECLARE fib2 INT DEFAULT 1;
	DECLARE fib INT;
	DECLARE i INT DEFAULT 2;
-- ���� 0 ��� 1, ����� ���������� �����
	IF (num = 0 OR num = 1) THEN 
  		RETURN num;
-- ���� ������ 0, �� �������� ����������	
  	ELSEIF (num < 0) THEN
  		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Number must be greater than 0';
	ELSE
  		SET fib = fib2 + fib1;
		WHILE i < num DO
			SET fib1 = fib2;
			SET fib2 = fib; 
			SET fib = fib2 + fib1;
			SET i = i + 1;
		END WHILE;
		RETURN fib;
	END IF;
END//
DELIMITER ;

SELECT fibonacci(-1);