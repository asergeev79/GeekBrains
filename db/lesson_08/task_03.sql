-- Урок 8.
-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение.
-- Агрегация данных
-- Работаем с БД vk и тестовыми данными, которые вы сгенерировали ранее:

-- Задание 3.
-- Определить кто больше поставил лайков (всего) - мужчины или женщины? 

USE vk;

-- Отношение users и profiles - 1:1
-- Тогда считаем кол-во лайков по каждому полу из таблиц likes и profiles


-- Используем вложенный SELECT
SELECT 
	(SELECT gender FROM profiles WHERE user_id = l.user_id) AS gender,
	COUNT(*) 
FROM 
	likes l
GROUP BY
	gender
ORDER BY 
	gender;

-- Используем JOIN
SELECT 
	p.gender, 
	COUNT(p.gender) AS likes_from_gender 
FROM 
	likes l
	JOIN
	profiles p 
ON 
	l.user_id = p.user_id 
GROUP BY 
	p.gender
ORDER BY 
	p.gender;

