use vk;

show tables;

-- ������� ��������� ������� �����
DESC communities;

-- ����������� ������
SELECT * FROM communities;
-- ������� update_at ���������� ���������� � ������� �������� - ���������� �� ���� (��� ���� ��������� ������ ��� ��)

-- ������� ����� �����
DELETE FROM communities WHERE id > 20;

-- ����������� ������� ����� ������������� � �����
SELECT * FROM communities_users;

-- ��������� �������� community_id
UPDATE communities_users SET community_id = FLOOR(1 + RAND() * 20);

-- ������� ��������� ������� ������
DESC friendship;
RENAME TABLE friendship TO friendships;

-- ����������� ������
SELECT * FROM friendships LIMIT 10;

-- ����������� ������ 
SELECT * FROM friendship_statuses;

-- ������� �������
TRUNCATE friendship_statuses;

-- ��������� �������� �������� ������
INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');
 
-- ��������� ������ �� ������ 
UPDATE friendships SET status_id = FLOOR(1 + RAND() * 3); 

-- ������� ���� ������������� ������, ���� ������ �� ���������� ��� �������
UPDATE friendships SET confirmed_at = NULL WHERE status_id = 1 or status_id = 3;

-- ��������� ���� ������� ������
UPDATE friendships SET requested_at = created_at WHERE requested_at > created_at;

-- ��������� ���� ������������� - ������ ���� ������ ���� �������
UPDATE friendships SET confirmed_at = NOW() WHERE requested_at > confirmed_at;

-- ������� ��������� ������� ���������
DESC messages;

-- ����������� ������
SELECT * FROM messages LIMIT 10;

-- ����������� ������ �������������
SELECT * FROM users LIMIT 10;

-- ������� ��������� ������� �������������
DESC users;

-- ������� ��������� ��������
DESC profiles;

-- ��������� ������� ������������� ������� ������������ � ������� ������� ��������
ALTER TABLE profiles ADD COLUMN `user_status_id` int unsigned DEFAULT NULL AFTER photo_id;
ALTER TABLE profiles DROP COLUMN status;

-- ������ ������� �������� ������������
CREATE TABLE user_statuses (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '������������� ������',
  `name` varchar(100) NOT NULL COMMENT '�������� ������� (���������)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '����� �������� ������',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '����� ���������� ������',
  PRIMARY KEY (`id`)
) COMMENT='���������� ��������';

-- ��������� ������� �������
INSERT INTO user_statuses (name) VALUES ('single'),('married');
SELECT * FROM user_statuses;

-- ����������� ������
SELECT * FROM profiles LIMIT 10;


-- ��������� ������ �� ����
UPDATE profiles SET photo_id = FLOOR(1 + RAND() * 100);

-- ��������� ������ �� ������ ������������
UPDATE profiles SET user_status_id = FLOOR(1 + RAND() * 2);

-- ������� ��������� ������� ������������� 
DESC media;

-- ����������� ������
SELECT * FROM media LIMIT 10;

-- ����������� ���� �������������
SELECT * FROM media_types;

-- ������� ��� ����
TRUNCATE media_types;

-- ��������� ������ ����
INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;

-- ����������� ������
SELECT * FROM media LIMIT 10;

-- ��������� ������ ��� ������ �� ��� � ���������
UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);
UPDATE media SET user_id = FLOOR(1 + RAND() * 100);

-- ������ ��������� ������� �������� �����������
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));

-- ��������� ����������
INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png');

-- ���������
SELECT * FROM extensions;

-- ��������� ������ �� ����
UPDATE media SET filename = CONCAT(
  'http://dropbox.net/vk/',
  filename,
  (SELECT last_name FROM users ORDER BY RAND() LIMIT 1),
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);

-- ��������� ������ ������
UPDATE media SET size = FLOOR(10000 + (RAND() * 1000000)) WHERE size < 1000;

-- ��������� ����������
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');  

-- ���������� ������� ���������� ���������� ���
ALTER TABLE media MODIFY COLUMN metadata JSON;
