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

create table Ticket(
	ticketID int,
	showTimingID int,
    	ticketPrice varchar(3),
	foreign key (seatID) references Seat(seatID),
    	foreign key (userID) references User(userID)
);
    
create table Seat(
	seatID int primary key,
    	seatLocation varchar(6),
    	constraint location check (seatLocation in ('stalls', 'circle')),
    	seatPrice varchar(3)
);

create table Performance(
	showID int primary key,
    	foreign key (showTypeID) references performanceType(performanceTypeID),
    	foreign key (ticketID) references Ticket(ticketID),
    	foreign key (languageID) references Language(languageID),
    	title varchar(100),
    	description varchar(1000),
    	hasLiveMusic boolean,
    	noOfSeatsAvailable int
);

create table SeatPerformance(
	seatID int primary key,
    	performanceID int primary key,
    	foreign key (seatID) references Seat(seatID),
	foreign key (perfomanceID) references Performance(performanceID)
);



-- procedures
delimiter / 
create procedure insertUser
				(in aUName varchar(50), in aPassword varchar(50), in aDOB date, in aAddress varchar(100))
	begin
        insert into User (userName, password, DOB, homeAddress) values (aUName, aPassword, aDOB, aAddress);
	end; 
/

create procedure login(in aUName varchar(50), in aPassword varchar(50))
	begin
		if exists(select ID from User where userName = aUName and password = aPassword) 
        then 
			select true;
        else select false;
		end if;
    end;
/
