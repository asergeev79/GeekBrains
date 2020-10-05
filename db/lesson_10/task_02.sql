-- 2. Задание на оконные функции
-- Построить запрос, который будет выводить следующие столбцы:
-- имя группы
-- среднее количество пользователей в группах
-- самый молодой пользователь в группе
-- самый старший пользователь в группе
-- общее количество пользователей в группе
-- всего пользователей в системе
-- отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100

USE vk;

DESC communities ;
DESC profiles;

-- Используем оконные фунцкии на JOIN'е таблиц communities, communities_users, users, profiles
-- Для проверки можно убрать комментарий на CONCAT и birthday - тогда ещё будут указаны все пользователи  
SELECT DISTINCT c.name,
-- CONCAT(u.first_name,' ',u.last_name),p.birthday ,
	(SELECT COUNT(user_id) FROM communities_users) / (SELECT COUNT(id) FROM communities) AS avg_usrs_grps,
	FIRST_VALUE(CONCAT(u.first_name,' ',u.last_name)) OVER w AS 'youngest',
	LAST_VALUE(CONCAT(u.first_name,' ',u.last_name)) OVER(PARTITION BY cu.community_id
	RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'oldest',
	COUNT(u.id) OVER(PARTITION BY cu.community_id
	RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'total_usrs_grp',
	(SELECT COUNT(id) FROM users) AS total_usrs,
	(COUNT(u.id) OVER(PARTITION BY cu.community_id
	RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) /
	(SELECT COUNT(id) FROM users) * 100 AS "%%"
FROM (communities c 
      JOIN communities_users cu 
      JOIN users u
      JOIN profiles p
        ON c.id = cu.community_id AND cu.user_id = u.id AND u.id = p.user_id)
        WINDOW w AS (PARTITION BY cu.community_id ORDER BY p.birthday)
;