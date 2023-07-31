INSERT INTO dept( deptno, dname, loc )
VALUES ( 50 ,'개발','서울');

INSERT INTO dept( deptno, dname)
VALUES ( 51 ,'개발'); -- 묵시적 방법으로 null 저장

INSERT INTO dept
VALUES ( 60 ,'인사','경기');

INSERT INTO dept
VALUES ( 61 ,'인사'); -- 에러 발생

INSERT INTO dept(deptno, dname , loc )
VALUES ( 80 ,'인사', NULL ); -- 명시적 방법으로 null 저장

select * from dept;

commit;

CREATE TABLE mydept
AS
SELECT * FROM dept
WHERE 1=2; -- 테이블의 구조만 복사해서 새로운 테이블 만듦

CREATE TABLE mydept10
AS
SELECT * FROM dept; -- 데이터 포함하여 테이블 생성

-- mydept
select * from mydept;

INSERT INTO mydept
SELECT deptno,dname,loc
FROM dept;

select * from mydept;

-- 무조건 insert all
--실습 테이블 생성
CREATE TABLE myemp_hire
AS
SELECT empno,ename,hiredate,sal
FROM emp
WHERE 1=2;

CREATE TABLE myemp_mgr
AS
SELECT empno,ename,mgr
FROM emp
WHERE 1=2;

-- insert
INSERT ALL
INTO myemp_hire VALUES ( empno,ename,hiredate,sal )
INTO myemp_mgr VALUES ( empno,ename,mgr )
SELECT empno,ename,hiredate,sal,mgr
FROM emp; -- 12개, 12개씩 저장 -> 24개 행 이(가) 삽입되었습니다.

select * from myemp_hire;
select * from myemp_mgr;

-- 조건 insert all
CREATE TABLE myemp_hire2
AS
SELECT empno,ename,hiredate,sal
FROM emp
WHERE 1=2;

CREATE TABLE myemp_mgr2
AS
SELECT empno,ename,mgr,sal
FROM emp
WHERE 1=2;

select * from myemp_hire2;
select * from myemp_mgr2;

INSERT ALL
WHEN sal = 800 THEN -- 800도 2500보다 작기 때문에 800은 두개의 테이블에 모두 저장됨
 INTO myemp_hire2 VALUES ( empno,ename,hiredate,sal )
WHEN sal < 2500 THEN
 INTO myemp_mgr2 VALUES ( empno,ename,mgr,sal )
SELECT empno,ename,hiredate,sal,mgr
FROM emp;

-- insert first
CREATE TABLE myemp_hire3
AS
SELECT empno,ename,hiredate,sal
FROM emp
WHERE 1=2;

CREATE TABLE myemp_mgr3
AS
SELECT empno,ename,mgr,sal
FROM emp
WHERE 1=2;

select * from myemp_hire3;
select * from myemp_mgr3;

INSERT first
WHEN sal = 800 THEN -- 800도 2500보다 작기 때문에 800은 두개의 조건에 모두 일치하지만, 첫번째 조건에만 저장
 INTO myemp_hire3 VALUES ( empno,ename,hiredate,sal )
WHEN sal < 2500 THEN
 INTO myemp_mgr3 VALUES ( empno,ename,mgr,sal )
SELECT empno,ename,hiredate,sal,mgr
FROM emp;