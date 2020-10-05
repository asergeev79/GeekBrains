-- ������������ ������� �� ���� �����������, ����������, ��������������
-- 2. �������� �������������, ������� ������� �������� name �������� ������� �� ������� products
-- � ��������������� �������� �������� name �� ������� catalogs.

-- ������������� ������� ����� shop
DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;

SELECT * FROM products;
SELECT * FROM catalogs;

-- ������ ������������� ��������
-- ���������, ��� � �������� ����� �� ���� ��������
CREATE VIEW prod_cat AS
SELECT p.name prod_name, c.name cat_name FROM products p LEFT JOIN catalogs c ON p.catalog_id = c.id;

-- ��������� �������������
SELECT * FROM prod_cat;