-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
-- Вызов функции FIBONACCI(10) должен возвращать число 55.

USE shop;

DELIMITER //
DROP FUNCTION IF EXISTS fibonacci//
CREATE FUNCTION fibonacci(num INT)
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE fib1 INT DEFAULT 0;
	DECLARE fib2 INT DEFAULT 1;
	DECLARE fib INT;
	DECLARE i INT DEFAULT 2;
-- Если 0 или 1, сразу возвращаем ответ
	IF (num = 0 OR num = 1) THEN 
  		RETURN num;
-- Если меньше 0, то вызываем исключение	
  	ELSEIF (num < 0) THEN
  		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Number must be greater than 0';
	ELSE
  		SET fib = fib2 + fib1;
		WHILE i < num DO
			SET fib1 = fib2;
			SET fib2 = fib; 
			SET fib = fib2 + fib1;
			SET i = i + 1;
		END WHILE;
		RETURN fib;
	END IF;
END//
DELIMITER ;

SELECT fibonacci(-1);