-- DDL

-- 한글 byte 확인
select *
 from NLS_DATABASE_PARAMETERS
 where parameter = 'NLS_CHARACTERSET'; -- AL32UTF8 : 한글 한글자는 3byte
                                       -- AL16UTF8이면 2byte

-- 일반적인 방법1
CREATE TABLE scott.employee -- 스키마 명시함
( empno NUMBER(4),
  ename VARCHAR2(20),
  hiredate DATE,
  sal NUMBER(7,2) );
  
CREATE TABLE employee10 -- 스키마 생략
( empno NUMBER(4),
  ename VARCHAR2(20),
  hiredate DATE,
  sal NUMBER(7,2) );
  
--==============================================================================
  
-- 일반적인 방법2 - default 옵션
CREATE TABLE employee2
( empno NUMBER(4),
  ename VARCHAR2(20),
  hiredate DATE DEFAULT SYSDATE,
  sal NUMBER(7,2) );

INSERT INTO employee2 (empno,ename,sal)
VALUES (10, '홍길동',3000);
  
select * from employee2;

commit;

--==============================================================================

-- 제약조건
-- 컬럼 레벨의 primary key 제약조건타입 지정
CREATE TABLE department
( deptno NUMBER(2) CONSTRAINT department_deptno_pk PRIMARY KEY,
  dname VARCHAR2(15),
  loc VARCHAR2(15) );
  -- CONSTRAINT 제약조건명 생략
CREATE TABLE department10
( deptno NUMBER(2) PRIMARY KEY,
  dname VARCHAR2(15),
  loc VARCHAR2(15) );
  
-- 제약조건 확인
select * from user_constraints where table_name = 'DEPARTMENT'; -- 제약조건명 : department_deptno_pk, 제약조건 : P
select * from user_constraints where table_name = 'DEPARTMENT10'; -- 제약조건명 : SYS_C007050, 제약조건 : P


-- 테이블 레벨의 primary key 제약조건타입 지정
CREATE TABLE department2
( deptno NUMBER(2), 
  dname VARCHAR2(15),
  loc VARCHAR2(15) ,
  CONSTRAINT department2_deptno_pk PRIMARY KEY(deptno)
);

select * from user_constraints where table_name = 'DEPARTMENT2';

  --복합컬럼(테이블 레벨만 가능)
CREATE TABLE department3
( deptno NUMBER(2), 
  dname VARCHAR2(15),
  loc VARCHAR2(15) ,
  CONSTRAINT department3_deptno_pk PRIMARY KEY(deptno, loc)
);

select * from user_constraints where table_name = 'DEPARTMENT3';

--==============================================================================

-- 컬럼 레벨의 unique 제약조건타입 지정
CREATE TABLE department4
( deptno NUMBER(2) CONSTRAINT department4_deptno_pk PRIMARY KEY,
  dname VARCHAR2(15) CONSTRAINT department4_dname_uk UNIQUE,
  loc VARCHAR2(15) );

insert into department4 ( deptno, dname, loc ) values ( 1, 'aa', 'bb');
insert into department4 ( deptno, dname, loc ) values ( 2, null, 'bb'); -- unique는 null 허용

select * from department4;

-- 테이블 레벨의 unique 제약조건타입 지정
CREATE TABLE department5
( deptno NUMBER(2) CONSTRAINT department5_deptno_pk PRIMARY KEY,
  dname VARCHAR2(15), 
  loc VARCHAR2(15),
  CONSTRAINT department5_dname_uk UNIQUE(dname)
);

CREATE TABLE department11
( deptno NUMBER(2),
  dname VARCHAR2(15), 
  loc VARCHAR2(15),
  CONSTRAINT department11_deptno_pk PRIMARY KEY(deptno),
  CONSTRAINT department11_dname_uk UNIQUE(dname)
);

--==============================================================================

-- 컬럼 레벨의 not null 제약조건타입 지정
CREATE TABLE department6
( deptno NUMBER(2) CONSTRAINT department6_deptno_pk PRIMARY KEY,
  dname VARCHAR2(15) CONSTRAINT department6_dname_uk UNIQUE,
  loc VARCHAR2(15) CONSTRAINT department6_loc_nn NOT NULL);

CREATE TABLE department12
( deptno NUMBER(2),
  dname VARCHAR2(15),
  loc VARCHAR2(15) CONSTRAINT department12_loc_nn NOT NULL,
  CONSTRAINT department12_deptno_pk PRIMARY KEY(deptno),
  CONSTRAINT department12_dname_uk UNIQUE(dname)
  );
-- 테이블 레벨의 not null 제약조건타입은 지원 안됨  

--==============================================================================

-- 컬럼 레벨의 check 제약조건타입 지정 - check : 조건에 일치하는 데이터만 저장 가능
CREATE TABLE department7
( deptno NUMBER(2) ,
 dname VARCHAR2(15)
 CONSTRAINT department7_dname_ck CHECK( dname IN('개발','인사')) ,
 loc VARCHAR2(15) 
);

insert into department7 (deptno, dname, loc) values (1, '개발', 'aa');
insert into department7 (deptno, dname, loc) values (2, '인사', 'bb');
insert into department7 (deptno, dname, loc) values (3, '관리', 'cc');

-- 테이블 레벨의 check 제약조건타입 지정
CREATE TABLE department8
( deptno NUMBER(2) ,
  dname VARCHAR2(15),
  loc VARCHAR2(15),
	CONSTRAINT department8_dname_ck CHECK( dname IN('개발','인사')) 
);

insert into department8 (deptno, dname, loc) values (1, '개발', 'aa');
insert into department8 (deptno, dname, loc) values (2, '인사', 'bb');
insert into department8 (deptno, dname, loc) values (3, '관리', 'cc');

--==============================================================================

-- FK 실습
-- 컬럼레벨 제약조건 지정
-- master 테이블 생성
create table m1
( no number(2) constraint m1_no_pk primary key,
  name varchar2(10)
);

insert into m1 (no, name) values (10, 'aa');
insert into m1 (no, name) values (20, 'bb');
insert into m1 (no, name) values (30, 'cc');

commit;

select * from m1;

-- slave 테이블 : 컬럼레벨
create table s1
( num number(4) constraint s1_num_pk primary key,
  email varchar2(20),
  --FK
  no number(2) constraint s1_no_fk references m1(no)
);

insert into s1 (num, email, no) values (100, 'xxx', 10);
insert into s1 (num, email, no) values (200, 'xxx2', 20);
insert into s1 (num, email, no) values (300, 'xxx3', 30);
insert into s1 (num, email, no) values (400, 'xxx4', null); 
insert into s1 (num, email, no) values (500, 'xxx5', 40); -- 에러(m1의 no에 없는 값)

select * from s1;

-- 테이블레벨 제약조건 지정
-- master 테이블 생성
create table m2
( no number(2) constraint m2_no_pk primary key,
  name varchar2(10)
);

insert into m2 (no, name) values (10, 'aa');
insert into m2 (no, name) values (20, 'bb');
insert into m2 (no, name) values (30, 'cc');

commit;

select * from m2;

-- slave 테이블 : 테이블레벨
create table s2
( num number(4) constraint s2_num_pk primary key,
  email varchar2(20),
  --FK
  no number(2),
  constraint s2_no_fk foreign key(no) references m2(no)
);

insert into s2 (num, email, no) values (100, 'xxx', 10);
insert into s2 (num, email, no) values (200, 'xxx2', 20);
insert into s2 (num, email, no) values (300, 'xxx3', 30);
insert into s2 (num, email, no) values (400, 'xxx4', null); 
insert into s2 (num, email, no) values (500, 'xxx5', 40); -- 에러(m2의 no에 없는 값)

select * from s2;

-- FK 이슈 : slave가 참조하는 master의 값을 삭제할 수 없다.

-- 해결방법1 : on delete cascade (FK 만들 때 옵션으로 지정) : 참조하는 자식의 레코드도 함께 삭제
-- master 테이블 생성
create table m3
( no number(2) constraint m3_no_pk primary key,
  name varchar2(10)
);

insert into m3 (no, name) values (10, 'aa');
insert into m3 (no, name) values (20, 'bb');
insert into m3 (no, name) values (30, 'cc');

commit;


-- slave 테이블
create table s3
( num number(4) constraint s3_num_pk primary key,
  email varchar2(20),
  --FK
  no number(2) constraint s3_no_fk references m3(no) on delete cascade
);

insert into s3 (num, email, no) values (100, 'xxx', 10);
insert into s3 (num, email, no) values (200, 'xxx2', 20);
insert into s3 (num, email, no) values (300, 'xxx3', 30);
insert into s3 (num, email, no) values (400, 'xxx4', null);

commit;
select * from m3;
select * from s3;
delete from m3 where no = 10; -- 에러없이 삭제 가능

-- 해결방법2 : on delete set null (FK 만들 때 옵션으로 지정) : 자식의 foreign key의 값을 null로 변경
-- master 테이블 생성
create table m4
( no number(2) constraint m4_no_pk primary key,
  name varchar2(10)
);

insert into m4 (no, name) values (10, 'aa');
insert into m4 (no, name) values (20, 'bb');
insert into m4 (no, name) values (30, 'cc');

commit;

-- slave 테이블
create table s4
( num number(4) constraint s4_num_pk primary key,
  email varchar2(20),
  --FK
  no number(2) constraint s4_no_fk references m4(no) on delete set null
);

insert into s4 (num, email, no) values (100, 'xxx', 10);
insert into s4 (num, email, no) values (200, 'xxx2', 20);
insert into s4 (num, email, no) values (300, 'xxx3', 30);
insert into s4 (num, email, no) values (400, 'xxx4', null);

commit;

delete from m4 where no = 10; -- 에러없이 삭제 가능

select * from m4; -- no = 10인 레코드 삭제
select * from s4; -- no = 10인 레코드의 no 값이 null로 변경

--==============================================================================

-- 테이블 삭제(drop)
drop table mydept;
drop table mydept10;

-- m1과 s1 제약조건 확인
select * from user_constraints where table_name = 'S1';
select * from user_constraints where table_name = 'M1';

drop table m1 cascade constraints; -- m1테이블 삭제, s1의 FK 제약조건 삭제

--==============================================================================

-- 테이블 변경(ALTER)
--실습테이블 생성
CREATE TABLE emp04
AS
SELECT * FROM emp;

select * from emp04;

-- 컬럼 추가
ALTER TABLE emp04
ADD ( email VARCHAR2(10) , address VARCHAR2(20) );

-- 크기 변경
ALTER TABLE emp04
MODIFY ( email VARCHAR2(40) );

ALTER TABLE emp04
MODIFY ( email VARCHAR2(5) );

desc emp04;

-- 데이터타입 변경
ALTER TABLE emp04
MODIFY ( email number(5) );

-- 컬럼 삭제
ALTER TABLE emp04
DROP ( email );

CREATE TABLE dept03
( deptno NUMBER(2),
 dname VARCHAR2(15),
 loc VARCHAR2(15)
);

-- 제약조건 추가
-- primary key
alter table dept03
add constraint dept03_deptno_pk primary key(deptno);

-- unique
alter table dept03
add constraint dept03_loc_uk unique(loc);

-- not null
alter table dept03
modify (dname VARCHAR2(15) constraint dept03_dname_nn not null);

-- 제약조건 삭제
-- primary key 삭제 2가지 방법
alter table dept03
drop primary key;

alter table dept03
drop constraint dept03_deptno_pk;

-- unique 삭제 2가지 방법
alter table dept03
drop unique(loc);

alter table dept03
drop constraint dept03_loc_uk;

-- notnull 삭제
alter table dept03
drop constraint dept03_dname_nn;

select * from user_constraints where table_name='DEPT03';


-- cascade 옵션
-- m2의 primary key 삭제
alter table m2
drop primary key; -- 오류 : s2의 fk가 참조하고 있기 때문
-- 해결법 : cascade 옵션
alter table m2
drop primary key cascade; -- 참조하는 fk 제약조건도 같이 삭제

select * from user_constraints where table_name='M2';
select * from user_constraints where table_name='S2';