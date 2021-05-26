drop table if exists comp5013.users;
drop table if exists comp5013.topics;
drop table if exists comp5013.claims;
drop table if exists comp5013.claimrelations;
drop table if exists comp5013.replys;

create table comp5013.users (
id int unsigned auto_increment primary key,
name varchar(20),
password varchar(20)
);

create table comp5013.topics (
topicID int unsigned auto_increment primary key,
topicName varchar(30),
posterName varchar(20),
posterTime datetime
);

create table comp5013.claims (
claimID int unsigned auto_increment primary key,
claimHeader varchar(50),
posterName varchar(20),
posterTime datetime,
parentTopic int unsigned
);

create table comp5013.claimrelations (
claimID int unsigned,
claimHeader varchar(50),
relatedToID int unsigned,
oppOrEqu varchar(10)
);

create table comp5013.replys (
replyID int unsigned auto_increment primary key,
replyContent varchar(200),
posterName varchar(20),
posterTime datetime,
parentClaim int unsigned,
parentReply int unsigned,
claimResponse varchar(18),
replyResponse varchar(8)
);