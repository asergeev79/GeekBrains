-- Урок 8.
-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение.
-- Агрегация данных
-- Работаем с БД vk и тестовыми данными, которые вы сгенерировали ранее:

-- Задание 4.
-- Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей). 

USE vk;

-- Используем вложенный SELECT
-- Выбираем пользователей, кому поставили лайк
SELECT target_id FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name LIKE 'users');

-- Выбираем дни рождения пользователей, кому поставили лайк
SELECT 
	(SELECT birthday FROM profiles WHERE user_id = l.target_id) AS birthday
FROM 
	(SELECT * FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name LIKE 'users')) AS l;

-- Группируем по дням рождения, считаем кол-во лайков каждому пользователя, сортируем и выбираем 10 самых молодых
SELECT 
	(SELECT birthday FROM profiles WHERE user_id = l.target_id) AS birthday,
	COUNT(*) AS likes
FROM 
	(SELECT * FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name LIKE 'users')) AS l
GROUP BY
	birthday
ORDER BY 
	birthday DESC
LIMIT 10;

-- Считаем общее кол-во лайков 10 самым молодым пользователям
SELECT SUM(likes_10.likes) AS sum_10
FROM 
	(SELECT 
		(SELECT birthday FROM profiles WHERE user_id = l.target_id) AS birthday,
		COUNT(*) AS likes
	FROM 
		(SELECT * FROM likes WHERE target_type_id = (SELECT id FROM target_types WHERE name LIKE 'users')) AS l
	GROUP BY
		birthday
	ORDER BY 
		birthday DESC
	LIMIT 10) AS likes_10;


-- Используем JOIN
-- Выбираем лайки, поставленные пользователям
SELECT 	l.target_id FROM likes l, target_types tt WHERE l.target_type_id = tt.id AND tt.name LIKE 'users';

-- Посчитаем кол-во лайков 10 самым молодым пользователям
SELECT 
	SUM(likes_10.likes) AS sum_10
FROM 
	(SELECT 
		p.birthday,
		COUNT(*) AS likes
	FROM 
		likes l 
		JOIN
		target_types tt 
		JOIN 
		profiles p 
		ON
			l.target_type_id = tt.id 
			AND 
			tt.name LIKE 'users'
			AND 
			l.target_id = p.user_id
		GROUP BY 
			p.birthday
		ORDER BY 
			p.birthday DESC 
		LIMIT 10) AS likes_10;

