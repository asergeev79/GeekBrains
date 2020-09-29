-- ������������ ������� �� ���� �����������, ����������, ��������������
-- 1. � ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������. 
-- ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� ����������.

-- �������� ������� ���� shop � sample
DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;

DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;

-- �������� �� ������� �� �����: source06.zip
-- ��� ���� � ���� sample ������ ������ ������� ��� ���������� �������.

-- ��������� ������� ������
SELECT * FROM shop.users;
-- � ���� sample ����� �� ������ ������ ������� users ���������
TRUNCATE TABLE sample.users; 
SELECT * FROM sample.users;

-- �������� ����������
START TRANSACTION;
-- ��������� � ������� users ���� sample ������ � id=1 �� ����� �� ������� ���� shop 
INSERT INTO sample.users SELECT * FROM shop.users WHERE shop.users.id = 1;
-- ������� ������ �� ������� users ���� shop
DELETE FROM shop.users WHERE shop.users.id = 1;
-- �� ������ ����� ����� ��������� �� ������� ����������, ��� ������� �� ����������
COMMIT;
-- ����� ������� ��������� � ����� �����

