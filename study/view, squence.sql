-- View
-- 복잡한 sql문
SELECT empno,ename, d.dname, d.deptno
FROM emp e JOIN dept d
ON e.deptno = d.deptno
WHERE e.deptno = 20;

-- 단순화
CREATE VIEW emp_view
AS
SELECT empno,ename, d.dname, d.deptno
FROM emp e JOIN dept d
ON e.deptno = d.deptno
WHERE e.deptno = 20;

-- 뷰 실행
select * from emp_view;

-- 별칭
CREATE VIEW emp_view10 (no, name, dname, dno)
AS
SELECT empno,ename, d.dname, d.deptno
FROM emp e JOIN dept d
ON e.deptno = d.deptno
WHERE e.deptno = 20;
-- 뷰 실행
select * from emp_view10;

-- 테이블의 특정 컬럼 보호 목적
-- emp의 sal이 매우 민감한 컬러라고 가정
CREATE VIEW emp_view2
AS
SELECT empno,ename,job,mgr,hiredate,comm,deptno -- salary제외 : 민감정보로 가정
FROM emp;

-- 뷰 수정 : create or replace : 없으면 생성, 있으면 교체
CREATE or replace VIEW emp_view2
AS
SELECT empno,ename,job --  세 컬럼만 보이도록 수정 => 에러(이미 존재하다고 나옴)
FROM emp;

select * from emp_view2;

-- 뷰 DML
create table copy_emp
as
select *
from emp;

select * from copy_emp;

create or replace view copy_emp_view
as
select *
from copy_emp; -- 베이스 테이블(뷰를 만들 때 쓴 테이블)

select * from copy_emp_view;

delete from copy_emp_view
where deptno = 20; -- view, 베이스 테이블 모두 삭제됨

-- DML 불가능하도록 읽기모드 뷰 생성
create or replace view copy_emp_view2
as
select *
from copy_emp -- 베이스 테이블(뷰를 만들 때 쓴 테이블)
with read only;

delete from copy_emp_view2
where deptno = 30; -- 에러 : read-only view

-- view로 메타 정보 확인
select * from user_views;

-- 뷰 삭제
drop view copy_emp_view2;

--------------------------------------------------------------------------------
-- sequence
-- base table
create table copy_dept
as
select deptno as no, dname as name, loc as addr
from dept
where 1=2;

CREATE SEQUENCE copy_dept_no_seq -- copy_dept의 no 칼럼을 시퀀스 하겠다.
 START WITH 10
 INCREMENT BY 10
 MAXVALUE 100
 MINVALUE 5
 CYCLE -- 다시 시작값은 minvalue 값부터 시작한다.
 NOCACHE;
 
-- 시퀀스에서 값을 가져오는 방법 : 시퀀스명.nextval
select copy_dept_no_seq.nextval, copy_dept_no_seq.currval
from dual;

CREATE SEQUENCE dept_deptno_seq2
 START WITH 100
 INCREMENT BY -10
 MAXVALUE 150
 MINVALUE 10
 CYCLE -- 다시 시작값은 maxvalue 부터 시작
 NOCACHE;

select dept_deptno_seq2.nextval, dept_deptno_seq2.currval
from dual;

create sequence my_seq;

-- 메타정보(start with 값 정보는 없다 => 시퀀스 수정시 start with는 수정할 수 없음)
select * from user_sequences;

-- my_seq 시퀀스를 이용해서 copy_dept 테이블의 no 컬럼을 넘버링
select * from copy_dept;

insert into copy_dept (no, name, addr) values (my_seq.nextval, 'aa', '서울');
insert into copy_dept (no, name, addr) values (my_seq.nextval, 'bb', '서울');
insert into copy_dept (no, name, addr) values (my_seq.nextval, 'cc', '서울');

-- 시퀀스 삭제
select * from user_sequences;
drop sequence DEPT_DEPTNO_SEQ2;