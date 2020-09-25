-- Урок 8.
-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение.
-- Агрегация данных
-- Работаем с БД vk и тестовыми данными, которые вы сгенерировали ранее:

-- Задание 5.
-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети. 

USE vk;

-- Ищем активность за последний год

-- Пользователи, запросившие дружбу (user_id, requested_at)
SELECT * FROM friendships f ;
SELECT f.user_id user_id FROM friendships f WHERE  DATEDIFF(NOW(), f.requested_at) < 365;

-- Сообщения от пользователя (from_user_id, created_at)
SELECT * FROM messages msg ;
SELECT msg.from_user_id user_id FROM messages msg WHERE DATEDIFF(NOW(), msg.created_at) < 365;

-- Проставленные лайки (user_id, created_at)
SELECT * FROM likes l ;
SELECT l.user_id user_id FROM likes l WHERE DATEDIFF(NOW(), l.created_at) < 365;

-- Добавленный медиа-контент (user_id, created_at)
SELECT * FROM media m ;
SELECT m.user_id user_id FROM media m WHERE DATEDIFF(NOW(), m.created_at) < 365;

-- Создание поста (user_id, created_at)
SELECT * FROM posts p ;
SELECT p.user_id user_id FROM posts p WHERE DATEDIFF(NOW(), p.created_at) < 365;

-- Добавление в группу и обновление профиля не считаем

-- Смотрим общую активность пользователей по показателям за последний год
(SELECT f.user_id user_id FROM friendships f WHERE  DATEDIFF(NOW(), f.requested_at) < 365)
UNION ALL 
(SELECT msg.from_user_id user_id FROM messages msg WHERE DATEDIFF(NOW(), msg.created_at) < 365)
UNION ALL
(SELECT l.user_id user_id FROM likes l WHERE DATEDIFF(NOW(), l.created_at) < 365)
UNION ALL
(SELECT m.user_id user_id FROM media m WHERE DATEDIFF(NOW(), m.created_at) < 365)
UNION ALL 
(SELECT p.user_id user_id FROM posts p WHERE DATEDIFF(NOW(), p.created_at) < 365)
ORDER BY user_id ;

-- Выбираем 10 из самых неактивных за последний год
SELECT 
	CONCAT(u.first_name,' ',u.last_name) 
FROM 
	(SELECT user_id, COUNT(*) count_active 
	FROM
		(
		(SELECT f.user_id user_id FROM friendships f WHERE  DATEDIFF(NOW(), f.requested_at) < 365)
		UNION ALL 
		(SELECT msg.from_user_id user_id FROM messages msg WHERE DATEDIFF(NOW(), msg.created_at) < 365)
		UNION ALL
		(SELECT l.user_id user_id FROM likes l WHERE DATEDIFF(NOW(), l.created_at) < 365)
		UNION ALL
		(SELECT m.user_id user_id FROM media m WHERE DATEDIFF(NOW(), m.created_at) < 365)
		UNION ALL 
		(SELECT p.user_id user_id FROM posts p WHERE DATEDIFF(NOW(), p.created_at) < 365)
		) AS active_users
	GROUP BY user_id
	ORDER BY count_active
	LIMIT 10) AS min_users
JOIN 
	users u 
WHERE min_users.user_id = u.id ;
