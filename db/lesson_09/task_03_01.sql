-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

USE shop;

DELIMITER //
DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello(cur_time DATETIME)
RETURNS TEXT DETERMINISTIC
BEGIN
  IF (HOUR(cur_time) >= 6 AND HOUR(cur_time) < 12) THEN 
  		RETURN "Доброе утро";
  ELSEIF (HOUR(cur_time) >= 12 AND HOUR(cur_time) < 18) THEN 
  		RETURN "Добрый день";
  ELSEIF (HOUR(cur_time) >= 18 AND HOUR(cur_time) < 24) THEN 
  		RETURN "Добрый вечер";
  ELSEIF (HOUR(cur_time) >= 0 AND HOUR(cur_time) < 6) THEN 
  		RETURN "Доброй ночи";
  END IF;
END//
DELIMITER ;

SELECT NOW(); 
SELECT hello(NOW());