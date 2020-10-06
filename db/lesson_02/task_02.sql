drop database if exists example;
create database example;

use example;

drop table if exists users;
create table users (
	id serial primary key,
	name varchar(255)
	);

show tables;
describe users;
select * from users;

