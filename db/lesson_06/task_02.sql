-- Урок 6.
-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение.
-- Агрегация данных
-- Работаем с БД vk и тестовыми данными, которые вы сгенерировали ранее:

-- Задание 2. 
-- 2. Создать все необходимые внешние ключи и диаграмму отношений.

USE vk;

-- Добавляем внешние ключи в БД vk

-- Для таблицы дружеских контактов
DESC friendships;

-- При удалении пользователя удаляется его дружеский контакт
-- Удалить статус нельзя, пока есть контакты с таким статусом
ALTER TABLE friendships 
  ADD CONSTRAINT friendships_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT friendships_friend_id_fk
    FOREIGN KEY (friend_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT friendships_status_id_fk
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id)
      ON DELETE RESTRICT;   


-- Для таблицы постов
DESC posts ;

-- При удалении группы можно пост считать вне группы
ALTER TABLE posts 
	ADD CONSTRAINT posts_community_id_fk
		FOREIGN KEY (community_id) REFERENCES communities(id)
			ON DELETE SET NULL;

-- Для таблицы лайков
DESC likes;

-- При удалении пользователя убираются все лайки, которые он поставил.
-- Удалить тип лайка нельзя, пока есть лайки с таким типом.
-- Ограничение на target_id поставить здесь нельзя - необходимо использовать триггер?
ALTER TABLE likes 
	ADD CONSTRAINT likes_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT likes_target_type_id_fk
		FOREIGN KEY (target_type_id) REFERENCES target_types(id)
			ON DELETE RESTRICT;


		
-- Все остальные CONSTRAINTS прописываются аналогично (лог не сохранился).
-- Все они будут в базе

-- Смотрим диаграмму отношений в DBeaver (ERDiagram)

