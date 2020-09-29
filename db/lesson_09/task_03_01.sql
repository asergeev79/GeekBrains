-- ������������ ������� �� ���� ��������� ��������� � �������, ��������"
-- 1. �������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����. 
-- � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", 
-- � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����", 
-- � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".

USE shop;

DELIMITER //
DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello(cur_time DATETIME)
RETURNS TEXT DETERMINISTIC
BEGIN
  IF (HOUR(cur_time) >= 6 AND HOUR(cur_time) < 12) THEN 
  		RETURN "������ ����";
  ELSEIF (HOUR(cur_time) >= 12 AND HOUR(cur_time) < 18) THEN 
  		RETURN "������ ����";
  ELSEIF (HOUR(cur_time) >= 18 AND HOUR(cur_time) < 24) THEN 
  		RETURN "������ �����";
  ELSEIF (HOUR(cur_time) >= 0 AND HOUR(cur_time) < 6) THEN 
  		RETURN "������ ����";
  END IF;
END//
DELIMITER ;

SELECT NOW(); 
SELECT hello(NOW());