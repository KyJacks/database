drop database if exists TheatreRoyal;
create database TheatreRoyal;
use TheatreRoyal;


create table User (
	ID INT PRIMARY KEY auto_increment,
	userName VARCHAR(50) NOT NULL,
	password VARCHAR(50) NOT NULL,
	DOB date not null,
    homeAddress varchar(100) not null
    -- constraint will be added for password based on client requirements
);


