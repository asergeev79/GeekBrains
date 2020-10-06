-- ������������ ������� �� ���� ������������ ��������
-- 2. �������� SQL-������, ������� �������� � ������� users ������� �������.

USE shop;

DESC users;

SELECT * FROM users;

-- � ������� ������� users ���� shop 6 �������.
-- ������� ��� 4.
INSERT INTO users (name, birthday_at) VALUES
  ('�������', '1990-10-05'),
  ('��������', '1984-11-12'),
  ('������', '1985-05-20'),
  ('�������', '1988-02-14');

-- ��������, ��� � ������� users 10 �������
 SELECT * FROM users ;
 
-- ����� �������� 1000000 �������,
-- ���������� ������� ������ �� JOIN'� 6 ������: 10�10�10�10�10�10
-- ����� �� ��������� ������ �� ���������� ����, �� ����� ������ ������ ����� ����������� � JOIN
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

-- ��������, ��� ������� � ������� ������ 1 ���
SELECT * FROM users WHERE id > 1000000;
