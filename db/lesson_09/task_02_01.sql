-- ������������ ������� �� ���� ������������������ MySQL�
-- 1. �������� ���� ������������� ������� ����� ������ � ���� ������ shop. 
-- ������� ������������ shop_read ������ ���� �������� ������ ������� �� ������ ������, 
-- ������� ������������ shop � ����� �������� � �������� ���� ������ shop.

SELECT Host,User FROM mysql.`user` u ;

-- ������ �������������
CREATE USER 'shop_read'@'localhost' IDENTIFIED BY '12345678';
CREATE USER 'shop'@'localhost' IDENTIFIED BY '12345678';

-- ������������� ���������� �� ���� shop
GRANT SELECT ON shop.* TO 'shop_read'@'localhost';
GRANT ALL ON shop.* TO 'shop'@'localhost';

-- �� ���������� �����, ��� ���������� ������������ ���������