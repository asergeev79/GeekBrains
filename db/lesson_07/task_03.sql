DROP DATABASE IF EXISTS lesson_07;
CREATE DATABASE lesson_07;
USE lesson_07;

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	city_from VARCHAR(255),
	city_to VARCHAR(255)
);

INSERT INTO 
	flights (city_from,city_to) 
VALUES 
	('moscow','omsk'),
	('novgorod','kazan'),
	('irkutsk','moscow'),
	('omsk','irkutsk'),
	('moscow','kazan');

SELECT * FROM flights;

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	label VARCHAR(255) PRIMARY KEY,
	name VARCHAR(255)
);

INSERT INTO
	cities (label,name)
VALUES
	('moscow','Москва'),
	('novgorod','Новгород'),
	('irkutsk','Иркутск'),
	('omsk','Омск'),
	('kazan','Казань');

SELECT * FROM cities;


SELECT 
	f.id,c1.name from_ru,c2.name to_ru 
FROM 
	cities c1, cities c2, flights f
WHERE 
	c1.label LIKE f.city_from 
	AND 
	c2.label LIKE f.city_to
ORDER BY id;
	