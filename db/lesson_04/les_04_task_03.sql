USE vk;

-- Предложения по постам:
-- 1 - это какая-то статья - текст, ссылка и т.д.
-- 2 - может быть репостом (ссылка на другой пост)
-- 3 - могут быть комментарии

-- Создаём таблицу постов
CREATE TABLE posts (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки", 
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на автора",
  body TEXT NOT NULL COMMENT "Текст поста",
  digest varchar(255) not null comment "Хэш поста для идентификации уникальности",
  post_id INT UNSIGNED COMMENT "Ссылка на пост для репоста",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Посты";

-- Создаём таблицу комментариев
CREATE TABLE comments (
  id SERIAL PRIMARY KEY COMMENT "Идентификатор строки", 
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на автора",
  body TEXT NOT NULL COMMENT "Текст комментария",
  post_id INT UNSIGNED COMMENT "Ссылка на пост",
  comment_id INT UNSIGNED COMMENT "Ссылка на родительский комментарий",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Комментарии";

-- Предложения по лайкам:

-- Создаём таблицу типов лайков
CREATE TABLE likes_types (
  id INT SERIAL PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы лайков";
INSERT INTO likes_types (name) VALUES ('like'),('dislike');

-- Создаём таблицу лайков сущностей
CREATE TABLE likes_users (
  like_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип лайка",
  user_like_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, кому поставили лайк",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, кто поставил лайк",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
  PRIMARY KEY (user_like_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Лайки пользователей";

CREATE TABLE likes_media (
  like_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип лайка",
  media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на медиа контент, которому поставили лайк",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, кто поставил лайк",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
  PRIMARY KEY (media_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Лайки медиа";

-- Аналогично для остальных сущностей.
-- Здесть видно, что таблицы одинаковые, за исключением id сущностей, которым поставили лайк
-- Возможно ли указание id строки с использованием названия таблицы?
