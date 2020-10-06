-- Урок 6.
-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение.
-- Агрегация данных
-- Работаем с БД vk и тестовыми данными, которые вы сгенерировали ранее:

-- Задание 3.
-- Определить кто больше поставил лайков (всего) - мужчины или женщины? 

USE vk;

-- Отношение users и profiles - 1:1
-- Тогда считаем кол-во лайков по каждому полу из таблиц likes и profiles
SELECT p.gender, COUNT(*) AS likes_from_gender FROM likes l, profiles p WHERE l.user_id = p.user_id GROUP BY p.gender ;

SELECT 
	p.gender, 
	COUNT(*) AS likes_from_gender 
FROM 
	likes l
	JOIN
	profiles p 
ON 
	l.user_id = p.user_id 
GROUP BY 
	p.gender ;
