DROP TABLE member CASCADE CONSTRAINTS;
create table member ( -- 회원
    id varchar2(20) primary key, -- id
    password varchar2(100), -- 암호
    name varchar2(20), -- 이름
    nick varchar2(20), -- 닉네임
    phone varchar2(30), -- 휴대폰 번호
    email varchar2(100), -- email
    birth date, -- 생일
    address varchar2(100), -- 주소
    regDate date, -- 가입일
    del varchar2(2) default 'n',-- 회원상태
    state varchar2(2) default 'n' -- 인증상태
);

DROP TABLE profile CASCADE CONSTRAINTS;
create table profile (
	nick varchar2(20) primary key, -- 닉네임
	id varchar2(20), -- id
	age number, -- 나이
	gender varchar2(10), -- 성별
	intro varchar2(500), -- 자기소개
	photo1 varchar2(200), -- 대표사진
	photo2 varchar2(200), -- 사진 
	photo3 varchar2(200), -- 사진
	del varchar2(2) default 'n', -- 프로필상태
	state varchar2(2) default 'n' -- 인증상태
);
DROP TABLE myPreference CASCADE CONSTRAINTS;
create table myPreference (
	nick varchar2(20) primary key, --nick
	gender varchar2(10), --원하는 성별
	maxAge number, -- 최소나이
	minAge number, -- 최대나이
	tag varchar2(50) -- 관심사
);
drop table Interest cascade constraints;
create table interest (
	itNum number primary key, -- pk
	nick varchar2(20), -- nick
	tag varchar2(50) --관심사
);
drop table tagList cascade constraints;
create table tagList (
	tlNum number primary key, -- pk
	tag varchar2(50) -- 관심사
);
drop table TempInterest cascade constraints;
create table TempInterest(
	itnum number primary key, -- pk
	nick varchar2(20), -- nick
	tag varchar2(50) -- interestList 참조용
);
drop table chatroom;
CREATE TABLE chatroom
(
chatRoompk number  primary key,
    chatRoomNo   VARCHAR2(500),
    enterUser1     VARCHAR2(500),
    enterUser2    VARCHAR2(500),
    carryOnCheck  number,
    carryOnNick   varchar2(500),
    chatRoomdel VARCHAR2(10)
);
drop table chathistory;
CREATE TABLE chathistory
(
  sendorder    number  primary key,
    chatRoomNo   VARCHAR2(500),
    sendUser   VARCHAR2(500),
    message    VARCHAR2(1000),
    readCount number
);
drop table Matching cascade constraints;
create table Matching (
    mcNum number primary key,
    matchingId varchar2(50),
    targetId varchar2(50)
);
drop table MatchingHistory cascade constraints;
create table MatchingHistory(
mchNum number primary key,
nickWhoLiked VARCHAR2(500),
targetNick VARCHAR2(500),
firstLike number,
secondLike number,
meetMade number,
matchingdate Date
);
drop table selLoc cascade constraints;
create table selLoc (
	slNum number primary key,
	chatRoomNo VARCHAR2(500),
	condition VARCHAR2(500),
	place VARCHAR2(500),
	placeAddr VARCHAR2(500)
);
drop table appointment cascade constraints;
create table appointment(
	apNum number primary key,
    chatRoomNo varchar2(500),
    location varchar2(500),
    appointmentTime varchar2(500),
    appointmentdate Date,
    appodel varchar2(10),
    appnick varchar2(30)
);
drop table Location cascade constraints;
create table Location (
    nick varchar2(20) primary key,
    latitude Float,
    longitude Float,
    lastSignIn date
);
drop table memberLoc cascade constraints;
create table memberLoc(
    id varchar2(20) primary key,
    latitude varchar2(100),
    longitude varchar2(100)
);
DROP TABLE anoFeed CASCADE CONSTRAINTS;
create table anoFeed (
    anNum number primary key,
    anTitle varchar2(500),
    anContent varchar2(4000),
    nick varchar2(20),
    photo varchar2(200),
    anDate Date,
    anDel varchar2(2) default 'n',
    anCheck varchar2(2),
    likeCount Number,
    replyCount number
    );
DROP TABLE reply CASCADE CONSTRAINTS;
create table reply (
    rpNum number primary key,
    anNum number,
    replyContent varchar2(2000),
    nick varchar2(20),
    replyDate Date,
    replyDel varchar2(2) default 'n',
    rpCheck varchar2(2),
    ref number,
    ref_level number,
    ref_step number
    );
DROP TABLE HashTag CASCADE CONSTRAINTS;
create table HashTag (
	htNum number primary key,
	anNum number,
	tag varchar2(50)
);
DROP TABLE ShowCondition CASCADE CONSTRAINTS;
create table ShowCondition (
	nick varchar2(20) primary key,
	anHash varchar2(50),
	distCheck varchar2(2)
);
DROP TABLE LikeFeed CASCADE CONSTRAINTS;
create table LikeFeed (
	lfNum number primary key,
	anNum number,
	nick varchar2(20)
);
DROP TABLE Report CASCADE CONSTRAINTS;
create table Report (
	repNum number primary key,
	nick varchar2(20),
	targetNick varchar2(20),
	targetId varchar2(20),
	reason number,
	anNum number,
	repDel varchar2(2)
);
select * from LOCATION;