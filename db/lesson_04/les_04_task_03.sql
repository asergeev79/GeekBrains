USE vk;

-- ����������� �� ������:
-- 1 - ��� �����-�� ������ - �����, ������ � �.�.
-- 2 - ����� ���� �������� (������ �� ������ ����)
-- 3 - ����� ���� �����������

-- ������ ������� ������
CREATE TABLE posts (
  id SERIAL PRIMARY KEY COMMENT "������������� ������", 
  user_id INT UNSIGNED NOT NULL COMMENT "������ �� ������",
  body TEXT NOT NULL COMMENT "����� �����",
  digest varchar(255) not null comment "��� ����� ��� ������������� ������������",
  post_id INT UNSIGNED COMMENT "������ �� ���� ��� �������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "�����";

-- ������ ������� ������������
CREATE TABLE comments (
  id SERIAL PRIMARY KEY COMMENT "������������� ������", 
  user_id INT UNSIGNED NOT NULL COMMENT "������ �� ������",
  body TEXT NOT NULL COMMENT "����� �����������",
  post_id INT UNSIGNED COMMENT "������ �� ����",
  comment_id INT UNSIGNED COMMENT "������ �� ������������ �����������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "�����������";

-- ����������� �� ������:

-- ������ ������� ����� ������
CREATE TABLE likes_types (
  id INT SERIAL PRIMARY KEY COMMENT "������������� ������",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "�������� ����",
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "���� ������";
INSERT INTO likes_types (name) VALUES ('like'),('dislike');

-- ������ ������� ������ ���������
CREATE TABLE likes_users (
  like_type_id INT UNSIGNED NOT NULL COMMENT "������ �� ��� �����",
  user_like_id INT UNSIGNED NOT NULL COMMENT "������ �� ������������, ���� ��������� ����",
  user_id INT UNSIGNED NOT NULL COMMENT "������ �� ������������, ��� �������� ����",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
  PRIMARY KEY (user_like_id, user_id) COMMENT "��������� ��������� ����"
) COMMENT "����� �������������";

CREATE TABLE likes_media (
  like_type_id INT UNSIGNED NOT NULL COMMENT "������ �� ��� �����",
  media_id INT UNSIGNED NOT NULL COMMENT "������ �� ����� �������, �������� ��������� ����",
  user_id INT UNSIGNED NOT NULL COMMENT "������ �� ������������, ��� �������� ����",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
  PRIMARY KEY (media_id, user_id) COMMENT "��������� ��������� ����"
) COMMENT "����� �����";

-- ���������� ��� ��������� ���������.
-- ������ �����, ��� ������� ����������, �� ����������� id ���������, ������� ��������� ����
-- �������� �� �������� id ������ � �������������� �������� �������?
