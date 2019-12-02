create table member(
  id varchar2(20),
  pw varchar2(20),
  nickname varchar2(20) primary key,
  age date,
  gender varchar2(20),
  mail varchar2(30),
  point number(38)
);

create table cvs(
  cvsnum NUMBER(1),
  productnum number(10) primary key,
  productname varchar2(100),
  price number(10),
  newproduct date
);

create table board(
  num NUMBER(7) PRIMARY key,
  title varchar2(100),
  nickname varchar2(20) CONSTRAINT nickkey REFERENCES MEMBER(nickname),
  hit number(7),
  recommend NUMBER(7),
  savedate date default sysdate,
  stars float,
  productname varchar2(20),
  content varchar2(1000),
  cvsnum number(1),
  productnum number(10) CONSTRAINT pnamekey REFERENCES CVS(productnum)
);
create SEQUENCE board_num_seq;        

create table comments(
  bnum number(10) CONSTRAINT commentkey REFERENCES board(num),
  savedate date DEFAULT sysdate,
  content varchar2(100),
  nickname varchar2(20),
  cnum number(10) primary key
);
create SEQUENCE comment_num_seq;        


comments primary key 편집으로 들어가서 bnum에 추가해주세요
그리고 모두 notnull 체크해주세용