drop database if exists TheatreRoyal;
create database TheatreRoyal;
use TheatreRoyal;


create table User (
	userID INT PRIMARY KEY auto_increment,
	userName VARCHAR(50) NOT NULL,
	password VARCHAR(50) NOT NULL,
	DOB date not null,
	homeAddress varchar(100) not null
    -- constraint will be added for password based on client requirements
);

create table Seat(
    seatID int primary key auto_increment,
    seatLocation varchar(6),
    constraint location check (seatLocation in ('stalls', 'circle')),
    seatPrice varchar(3)
);

create table PerformanceType(
	performanceTypeID INT PRIMARY KEY auto_increment,
	performanceTypeName VARCHAR(30),
    	constraint typeName check (performanceTypeName in ('opera', 'concert', 'musical', 'theatre'))
);

create table Ticket(
    ticketID int primary key auto_increment,
    seatID int,
    userID int,
    performanceTimingID int,
    ticketPrice decimal(5, 2),
    foreign key (seatID) references Seat(seatID),
    foreign key (userID) references User(userID)
);

create table Purchase(
	purchaseID int primary key auto_increment,
    ticketID int,
    foreign key (ticketID) references Ticket(ticketID),
    orderNo int,
    quanitity int
);


create table Language(
	languageID INT PRIMARY KEY auto_increment,
	languageOption VARCHAR(30)
);



create table Performance(
	performanceID int primary key auto_increment,
    	performanceTypeID INT,
     	languageID int,
    	foreign key (performanceTypeID) references PerformanceType(performanceTypeID),
    	foreign key (languageID) references Language(languageID),
    	title varchar(100),
    	description varchar(1000),
    	hasLiveMusic boolean,
    	noOfSeatsAvailable int
);

create table SeatPerformance(
    seatId int,
    performanceID int,
    primary key(seatID, performanceID),
    foreign key (seatID) references Seat(seatID),
    foreign key (performanceID) references Performance(performanceID)
);


create table PerformanceTiming(
	performanceTimingID INT PRIMARY KEY auto_increment,
	performanceID INT,
	date DATE,
	duration INT,
	time TIME,
	foreign key (performanceID) references performance(performanceID)
);

-- procedures for inserting data into tables
delimiter / 
create procedure insertUser
				(in aUName varchar(50), in aPassword varchar(50), in aDOB date, in aAddress varchar(100))
	begin
        insert into User (userName, password, DOB, homeAddress) values (aUName, aPassword, aDOB, aAddress);
	end; 
/

create procedure insertSeat
				(in aLocation varchar(6), in aPrice varchar(3))
	begin 
		insert into Seat(seatLocation, seatPrice) values (aLocation, aPrice);
	end;
/

create procedure insertPerformanceType (in aPerformanceTypeName varchar(30))
	begin
		insert into PerformanceType(performanceTypeName) values (aPerformanceTypeName);
	end;
/

create procedure insertLanguage(in aLanguageOption varchar(30))
	begin
		insert into Language(languageOption) values (aLanguageOption);
    end;
/
    
create procedure insertPerformance(in aPerformanceType int, in aLanguageID int, in aTitle varchar(100), in description varchar(1000), in hasLiveMusic boolean, in aNoOfSeatsAvailable int)
	begin
		insert into Performance(performanceTypeID, languageID, title, description, hasLiveMusic, noOfSeatsAvailable) values (aPerformanceTypeID, aLanguageID, aTitle, aDescription, aHasLiveMusic, aNoOfSeatsAvailable);
	end;
/

create procedure insertSeatPerformance(in aSeatID int, in aPerformanceID int)
	begin
		insert into SeatPerformance(seatID, performanceID) values (aSeatID, aPerformanceID);
	end;
/

create procedure insertPerformanceTiming(in aPerformanceID int, in aDate date, in aDuration int, in aTime time)
	begin
		insert into PerfomanceTiming(performanceID, date, duration, time) values (aPerformanceID, aDate, aDuration, aTime);
	end;
/



-- procedure to log user in to account based on valid pswrd and usrnm
create procedure login(in aUName varchar(50), in aPassword varchar(50))
	begin
		if exists(select ID from User where userName = aUName and password = aPassword) 
        then 
			select true;
        else select false;
		end if;
    end;
/

-- select information about performances on a specific date
create procedure getPerfomanceOnDate(in aDate)
	begin
		select title, description, hasLiveMusic, noOfSeatsAvailable, Language.languageOption from Performance, Language, PeformanceTiming where date = aDate;
	end;

/



delimiter ;
