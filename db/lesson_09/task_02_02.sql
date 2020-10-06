-- ������������ ������� �� ���� ������������������ MySQL�
-- ����� ������� ������� accounts ���������� ��� ������� id, name, password, 
-- ���������� ��������� ����, ��� ������������ � ��� ������. 
-- �������� ������������� username ������� accounts, ��������������� ������ � ������� id � name. 
-- �������� ������������ user_read, ������� �� �� ���� ������� � ������� accounts, 
-- ������, ��� �� ��������� ������ �� ������������� username.

USE lesson_09;

-- �������� ������� accounts
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '��� ������������',
  password VARCHAR(255) COMMENT '������'
);

-- �������� ������� �������
INSERT INTO accounts (name, password) VALUES
  ('��������', 'sdshdbfjsr'),
  ('�������', 'zvdtbujetyk'),
  ('���������', 'saevdubidyknl'),
  ('������', 'svbdynk'),
  ('����', 'ssvdbuy'),
  ('�����', 'cdrvfj');

SELECT * FROM accounts;

-- �������� �������������
CREATE VIEW username AS SELECT id,name FROM accounts;
SELECT * FROM username;

-- �������� ������������ � ����� ����������� ����������:
-- ������ ������ � ������������� username ���� lesson_09
CREATE USER 'user_read'@'localhost' IDENTIFIED BY '12345678';
GRANT SELECT ON lesson_09.username TO 'user_read'@'localhost';

-- �� ��������� ����� ������������ ������ ����������