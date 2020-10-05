-- Задания на БД vk:
-- 1. Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индексы.

USE vk;

-- Рассмотрим справочники

DESC communities ;
DESC friendship_statuses ;
DESC media_types ;
DESC target_types ;
DESC media_types ;
DESC user_statuses ;

-- id - primary key - неявный индекс создаётся
-- name - unique - неявный индекс создаётся
-- в таблице user_statuses столбец name не является уникальным, сделаем его таким
ALTER TABLE user_statuses MODIFY name VARCHAR(100) UNIQUE;

-- В остальном, справочники являются в основном небольшими малоизменяемыми таблицами.
-- Дополнительные индексы не нужны


-- Рассмотрим таблицы с составными ключами

DESC communities_users ;
-- Здесь частые выборки по принадлежности пользователей к какой-то группе и списку групп у конкретного пользователя
-- Используются для таргетированной рекламы
CREATE INDEX community_user_idx ON communities_users(community_id, user_id);
CREATE INDEX user_community_idx ON communities_users(user_id, community_id);

DESC friendships ;
-- Здесь возможен частый запрос для конкретного пользователя кол-во друзей с определённым статусом
CREATE INDEX user_status_friend_idx ON friendships(user_id,status_id,friend_id);


-- Рассмотрим таблицы, относящиеся к пользователям
DESC users;
-- Здесь частый поиск по email, телефону и имени, но по почте и телефону неявный индекс уже присутствует (UNIQUE)
CREATE INDEX user_name_idx ON users(last_name,first_name);

DESC profiles;
-- Здесь возможны различные сочетания столбцов для использования в индексах - опять же для определения групп пользователей:
-- по возрасту, статусу, полу, месту проживания и т.д.
-- Данные индексы больше зависят от приложения

-- Остальные таблицы

DESC posts ;
-- В постах пока достаточно неявных индексов.
-- Более интересен был бы полнотекстовый поиск по тексту, но тогда лучше использовать другой тип БД - ElasticSearch, например.

DESC messages ;
-- Аналогично постам

DESC likes ;
CREATE INDEX likes_idx ON likes(target_type_id,target_id);

DESC media ;
-- Для медиа тоже интересен анализ содержимого. Используются столбцы media_type_id и metadata
