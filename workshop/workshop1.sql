--1
select DEPARTMENT_NAME as "학과 명", CATEGORY as 계열 from TB_DEPARTMENT;

--2
select DEPARTMENT_NAME || '의 정원은 ' || CAPACITY || '명 입니다.' as "학과별 정원" from TB_DEPARTMENT;

--3
select student_name from tb_student 
where DEPARTMENT_NO=001 AND absence_yn='Y' AND STUDENT_SSN like '%2______';

--4
select student_name from tb_student 
where STUDENT_NO in ('A513079', 'A513090', 'A513091', 'A513110', 'A513119') order by student_name desc;

--5
select department_name, category from TB_DEPARTMENT where CAPACITY between 20 and 30;

--6
select professor_name from TB_PROFESSOR where DEPARTMENT_NO is null;

--7
select student_name from TB_STUDENT where DEPARTMENT_NO is null;

--8
select CLASS_NO from TB_CLASS where PREATTENDING_CLASS_NO is not null;

--9
select DISTINCT category from TB_DEPARTMENT order by category;

--10
select student_no, student_name, student_ssn from TB_STUDENT 
where student_no like 'A2%' and STUDENT_ADDRESS like '전주시%' and absence_yn='N';