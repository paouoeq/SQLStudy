-- 1
select count(*) "학생 수"
from TB_STUDENT
where to_char(ENTRANCE_DATE,'YYYY') = '2001'
group by DEPARTMENT_NO
having DEPARTMENT_NO = 003;

-- 2
select CATEGORY 계열, DEPARTMENT_NAME 학과이름, CAPACITY 정원
from TB_DEPARTMENT
where CATEGORY = '공학' AND CAPACITY between 20 and 30
order by 2;

-- 3
select CATEGORY 계열, count(*) 학과수
from TB_DEPARTMENT
where CATEGORY like '%학'
group by CATEGORY
order by 2 desc;

-- 4
select PROFESSOR_NAME 교수이름, substr(PROFESSOR_SSN,1,2) 출생년도, PROFESSOR_ADDRESS 주소
from TB_PROFESSOR
where DEPARTMENT_NO = 002
order by 2;

-- 5
select DEPARTMENT_NO 학과번호, STUDENT_NAME 학생이름,
DECODE ( ABSENCE_YN, 'Y', '휴학', '정상')
from TB_STUDENT
where DEPARTMENT_NO = 001 and STUDENT_ADDRESS like '서울%';

-- 6
select substr(STUDENT_SSN,1,8)||'******' 주민번호, STUDENT_NAME 이름
from TB_STUDENT
where STUDENT_NAME like '김%' AND STUDENT_SSN like '80%' AND substr(STUDENT_SSN,8,1) = 2;

-- 7
select DEPARTMENT_NAME 학과이름, CAPACITY 현재정원, 
case when CAPACITY >= 40 then '대강의실'
     when CAPACITY >= 30 then '중강의실'
     else '소강의실'
     end
from TB_DEPARTMENT
where CATEGORY = '예체능'
order by 2 desc, 1;

-- 8
select DEPARTMENT_NO 학과번호, STUDENT_NAME 학생이름, COACH_PROFESSOR_NO 지도교수번호, to_char(ENTRANCE_DATE,'YYYY"년"') 입학년도
from TB_STUDENT
where (ENTRANCE_DATE BETWEEN '05/01/01' AND '06/12/31') AND STUDENT_ADDRESS is null AND (substr(STUDENT_SSN,8,1) = 1)
order by ENTRANCE_DATE, STUDENT_NAME;