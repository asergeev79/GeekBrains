-- Урок 6.
-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение.
-- Агрегация данных
-- Работаем с БД vk и тестовыми данными, которые вы сгенерировали ранее:

-- Задание 4.
-- Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей). 

USE vk;

DESC likes;

-- Выбираем 10 самых молодых пользователей
SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10;

-- Выбираем лайки, поставленные пользователям
SELECT * FROM target_types tt WHERE name LIKE 'users';
SELECT target_id FROM likes l WHERE target_type_id = 2;
SELECT 	l.target_id FROM likes l, target_types tt WHERE l.target_type_id = tt.id AND tt.name LIKE 'users';

-- Посчитаем кол-во лайков 10 самым молодым пользователям
SELECT COUNT(*) FROM 
	(SELECT 
		p.user_id 
	FROM 
		profiles p 
	ORDER BY 
		p.birthday DESC 
	LIMIT 10) AS young_user
JOIN
	(SELECT 
		l.target_id 
	FROM 
		likes l
		JOIN
		target_types tt 
	ON 
		l.target_type_id = tt.id 
		AND 
		tt.name LIKE 'users') AS likes_user
ON 
	young_user.user_id = likes_user.target_id;
