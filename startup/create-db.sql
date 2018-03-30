DROP DATABASE IF EXISTS MovieWand ;

CREATE DATABASE MovieWand CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE MovieWand;

-- create table
create table Profile(
userId int not null auto_increment ,
socialId nvarchar(50)not null,
socialType int not null,
userCode nvarchar(500)not null,
userName nvarchar(50) not null,
fullName nvarchar(50),
phone nvarchar(20),
email nvarchar(50) not null,
password nvarchar(50),
avatar nvarchar(500),
birthday bigint not null,
gender int not null,
groupIds nvarchar(500),
role nvarchar(50) not null,
enable int,
primary key(userId)
);

create table Token(
tokenId int not null auto_increment ,
userId int not null,
socialId nvarchar(500)not null,
loginToken nvarchar(500) not null,
refreshToken nvarchar(500) not null,
expiredIn bigint not null,
primary key(tokenId)
);

create table Wallet(
walletId int not null auto_increment,
balance double,
userId int not null,
password nvarchar(500) not null,
primary key(walletId)
);

create table Device(
deviceId int not null auto_increment,
deviceToken nvarchar(500) not null,
pushToken nvarchar(500) not null,
resource nvarchar(500),
uuid nvarchar(100),
lastLng double not null,
lastLat double not null,
primary key(deviceId)
);

create table DeviceUser(
userId int not null,
deviceId int not null,
status int not null,
primary key(userId, deviceId)
);

create table Notification(
notificationId int not null auto_increment,
title nvarchar(500) not null,
description nvarchar(500) not null,
startTime bigint not null,
endTime bigint not null,
schedule nvarchar(50) not null,
status int,
primary key(notificationId)
);

create table UserGroup(
userGroupId int not null auto_increment,
name nvarchar(500),
primary key(userGroupId)
);

create table UserGroupNotification(
notificationId int not null,
userGroupId int not null,
status int not null,
primary key(notificationId, userGroupId)
);

create table Company(
companyId int auto_increment not null,
companyName nvarchar(500) not null,
companyAddress nvarchar(500) not null,
companyWebsite nvarchar(500) not null,
companyHotline nvarchar(50) not null,
companyLogo nvarchar(500),
companyLng double not null,
companyLat double not null,
primary key(companyId)
);

create table Cinema(
cinemaId int auto_increment not null,
companyId int not null,
cinemaName nvarchar(500) not null,
cinemaAddress nvarchar(500) not null,
cinemaLng double not null,
cinemaLat double not null,
cinemaImages nvarchar(5000),
cinemaHotline nvarchar(50) not null,
cinemaCode nvarchar(500) not null,
cinemaDescription nvarchar(5000),
primary key(cinemaId)

);

create table Admin(
adminId int auto_increment not null,
userName nvarchar(50) not null,
password nvarchar(500) not null,
avatar nvarchar(500),
companyId int not null,
primary key(adminId)
);

create table AdminCinema(
adminId int not null,
cinemaId int not null,
role int not null,
primary key(adminId, cinemaId)
);

create table Movie(
movieId int auto_increment not null,
movieCode nvarchar(500) not null,
movieTitle nvarchar(500) not null,
movieSummary nvarchar(5000),
movieReleaseDate bigint not null,
moviePoster nvarchar(500) not null,
movieKind nvarchar(500) not null,
movieTrailers nvarchar(5000) not null,
movieRating double,
movieType nvarchar(50) not null,
movieDuration int not null,
movieLanguage nvarchar(500),
movieDirection nvarchar(500),
movieCast nvarchar(500),
movieCountry nvarchar(500),
movieInternalTitle nvarchar(500) not null,
movieImages nvarchar(5000) not null,
primary key(movieId)
);

create table Showing(
showingId int auto_increment not null,
cinemaId int not null,
movieId int not null,
startTime bigint not null,
endTime bigint not null,
discountTypeId int not null,
numTicketDiscount int not null,
ticketCodes nvarchar(5000) not null,
rootPrice double not null,
showingCode nvarchar(500) not null,
primary key(showingId)
);

create table DiscountType(
discountTypeId int auto_increment not null,
discountName nvarchar(500),
primary key(discountTypeId)
);
-- drop table Discount;
create table Discount(
discountId int auto_increment not null,
discountTypeId int not null,
milestone nvarchar(500) not null,
discountPercent double not null,
primary key(discountId)
);

create table Ticket(
ticketId int auto_increment not null,
showingId int not null,
ticketCode nvarchar(500) not null,
rootPrice double not null,
finalPrice double not null,
transactionId int not null,
status int not null,
primary key(ticketId)
);

create table Transaction(
transactionId int auto_increment not null,
transactionType int not null,
createDate long not null,
totalMoney double not null,
userId int not null,
transactionCode nvarchar(500) not null,
status nvarchar(20) not null,
primary key(transactionId)
);

create table Zone(
zoneId int auto_increment not null ,
zoneName nvarchar(500) not null,
lng double not null,
lat double not null,
radius double not null,
cinemaIds nvarchar(50),
primary key(zoneId)
);

-- create foreign key
 alter table Token add constraint PK_Token_Profile
foreign key (userId) references Profile(userId);

alter table Wallet add constraint PK_Wallet_Profile
foreign key (userId) references Profile(userId);

alter table DeviceUser add constraint PK_DeviceUser_Profile
foreign key (userId) references Profile(userId);

alter table DeviceUser add constraint PK_DeviceUser_Device
foreign key (deviceId) references Device(deviceId);

alter table UserGroupNotification add constraint PK_UserGroupNotification_UserGroup
foreign key (userGroupId) references UserGroup(userGroupId);

alter table UserGroupNotification add constraint PK_UserGroupNotification_Notification
foreign key (notificationId) references Notification(notificationId);

alter table Transaction add constraint PK_Transaction_Profile
foreign key (userId) references Profile(userId);

alter table Cinema add constraint PK_Cinema_Company
foreign key (companyId) references Company(companyId);

alter table Admin add constraint PK_Admin_Company
foreign key (companyId) references Company(companyId);

alter table AdminCinema add constraint PK_AdminCinema_Cinema
foreign key (cinemaId) references Cinema(cinemaId);

alter table AdminCinema add constraint PK_AdminCinema_Admin
foreign key (adminId) references Admin(adminId);

alter table Showing add constraint PK_Showing_Movie
foreign key (movieId) references Movie(movieId);

alter table Showing add constraint PK_Showing_Cinema
foreign key (cinemaId) references Cinema(cinemaId);

alter table Showing add constraint PK_Showing_DiscountType
foreign key (discountTypeId) references DiscountType(discountTypeId);

alter table Discount add constraint PK_Discount_DiscountType
foreign key (discountTypeId) references DiscountType(discountTypeId);

alter table Ticket add constraint PK_Ticket_Showing
foreign key (showingId) references Showing(showingId);

alter table Ticket add constraint PK_Ticket_Transaction
foreign key (transactionId) references Transaction(transactionId);