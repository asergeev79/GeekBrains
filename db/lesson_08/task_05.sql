-- Урок 8.
-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение.
-- Агрегация данных
-- Работаем с БД vk и тестовыми данными, которые вы сгенерировали ранее:

-- Задание 5.
-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети. 

USE vk;

-- Ищем активность за последний год

-- Используем вложенный SELECT
SELECT 
  CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM friendships f WHERE DATEDIFF(NOW(), f.requested_at) < 365 AND f.user_id = u.id) + 
	(SELECT COUNT(*) FROM messages msg WHERE DATEDIFF(NOW(), msg.created_at) < 365 AND msg.from_user_id = u.id) + 
	(SELECT COUNT(*) FROM likes l WHERE DATEDIFF(NOW(), l.created_at) < 365 AND l.user_id = u.id) +
	(SELECT COUNT(*) FROM media m WHERE DATEDIFF(NOW(), m.created_at) < 365 AND m.user_id = u.id) +
	(SELECT COUNT(*) FROM posts p WHERE DATEDIFF(NOW(), p.created_at) < 365 AND p.user_id = u.id)
	AS overall_activity 
	  FROM users u
	  ORDER BY overall_activity
	  LIMIT 10;


-- Используем JOIN
-- Пользователи, запросившие дружбу (user_id, requested_at)
SELECT u.id, COUNT(f.user_id) FROM users u LEFT JOIN friendships f ON DATEDIFF(NOW(), f.requested_at) < 365 AND f.user_id = u.id GROUP BY u.id;

-- Сообщения от пользователя (from_user_id, created_at)
SELECT u.id, COUNT(msg.from_user_id) FROM users u LEFT JOIN messages msg ON DATEDIFF(NOW(), msg.created_at) < 365 AND msg.from_user_id = u.id GROUP BY u.id;

-- Проставленные лайки (user_id, created_at)
SELECT u.id, COUNT(l.user_id) FROM users u LEFT JOIN likes l ON DATEDIFF(NOW(), l.created_at) < 365 AND l.user_id = u.id GROUP BY u.id;

-- Добавленный медиа-контент (user_id, created_at)
SELECT u.id, COUNT(m.user_id) FROM users u LEFT JOIN media m ON DATEDIFF(NOW(), m.created_at) < 365 AND m.user_id = u.id GROUP BY u.id;

-- Создание поста (user_id, created_at)
SELECT u.id, COUNT(p.user_id) FROM users u LEFT JOIN posts p ON DATEDIFF(NOW(), p.created_at) < 365 AND p.user_id = u.id GROUP BY u.id;

-- Добавление в группу и обновление профиля не считаем

-- 10 самых неактивных
SELECT 
	CONCAT(u2.first_name, ' ', u2.last_name) , SUM(activity.count_l) AS overall_activity 
FROM
	(
	(SELECT u.id, COUNT(f.user_id) AS count_l FROM users u LEFT JOIN friendships f ON DATEDIFF(NOW(), f.requested_at) < 365 AND f.user_id = u.id GROUP BY u.id)
	UNION ALL
	(SELECT u.id, COUNT(msg.from_user_id) AS count_l FROM users u LEFT JOIN messages msg ON DATEDIFF(NOW(), msg.created_at) < 365 AND msg.from_user_id = u.id GROUP BY u.id)
	UNION ALL
	(SELECT u.id, COUNT(l.user_id) AS count_l FROM users u LEFT JOIN likes l ON DATEDIFF(NOW(), l.created_at) < 365 AND l.user_id = u.id GROUP BY u.id)
	UNION ALL
	(SELECT u.id, COUNT(m.user_id) AS count_l FROM users u LEFT JOIN media m ON DATEDIFF(NOW(), m.created_at) < 365 AND m.user_id = u.id GROUP BY u.id)
	UNION ALL
	(SELECT u.id, COUNT(p.user_id) AS count_l FROM users u LEFT JOIN posts p ON DATEDIFF(NOW(), p.created_at) < 365 AND p.user_id = u.id GROUP BY u.id)
	) AS activity
JOIN 
	users u2
ON 
	activity.id = u2.id
GROUP BY 
	activity.id
ORDER BY 
	overall_activity 
LIMIT 10;
