create table member(
  id varchar2(20),
  pw varchar2(20),
  nickname varchar2(20) primary key,
  age date,
  gender varchar2(20),
  mail varchar2(30),
  point number(38),
  AUTHKEY varchar2(50),
  Authstatus number(5)
);

create table cvs(
  cvsnum NUMBER(1),
  productnum number(10) primary key,
  productname varchar2(100),
  price number(10),
  newproduct date
  gdsimg varchar2(200)
);

create table board(
  num NUMBER(7) PRIMARY key,
  title varchar2(100),
  nickname varchar2(20) CONSTRAINT nickkey REFERENCES MEMBER(nickname),
  hit number(7),
  recommend NUMBER(7),
  savedate date default sysdate,
  stars float,
  productname varchar2(100),
  content varchar2(1000),
  cvsnum number(1),
  productnum number(10) CONSTRAINT pnamekey REFERENCES CVS(productnum),
  gdsimg varchar2(200),
  cat varchar2(20)
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

create table heart(
bnum number(10) CONSTRAINT bnumkey REFERENCES board(num),
nickname varchar2(20) CONSTRAINT mnumkey REFERENCES member(nickname),
PRIMARY key(bnum,nickname)
);
create table searchCnt(
title varchar2(100),
dates date,
cnt number(10)
);

create table searchCnt(
title varchar2(100),
dates date,
cnt number(10)
);

comments primary key 편집으로 들어가서 bnum에 추가해주세요
그리고 모두 notnull 체크해주세용
보드 테이블에 편집-제약조건-외래 키 들 삭제 시 종속 삭제 해주세용

//2019.12.27
cvs 테이블 - newproduct 컬럼 기본 값에 (TO_CHAR(sysdate,'yy-mm-dd')) 입력
searchcnt 테이블  dates 컬럼 기본 값에 (TO_CHAR(sysdate,'yy-mm-dd')) 입력 
DB에 날짜 입력하기 위해서입니다. 


//2020.01.03
게시글 등록시 포인트주는 것 하루 5개 제한을 위한 DB추가사항입니다.

member 테이블 - DAILYPOINTCHK 컬럼 추가, 기본값 : 0
update member set dailypointchk = 0;
--멤버전원 포인트 0으로 초기화
 
ALTER SYSTEM SET JOB_QUEUE_PROCESSES = 10;

-- TRUNC(SYSDATE+1) : 매일 밤 12시에 job 수행
  
  DECLARE
     X NUMBER;
 BEGIN
    SYS.DBMS_JOB.SUBMIT

    ( job            => x
     ,what          => 'update member set dailypointchk = 0;'
     ,next_date   => to_date('30-12-2019 00:00:00','dd/mm/yyyy hh24:mi:ss')
     ,interval      => 'TRUNC(SYSDATE + 1)'
     ,no_parse   => TRUE
    );

    SYS.DBMS_OUTPUT.PUT_LINE('Job Number is : ' || to_char(x));

 END;

 /
 commit;