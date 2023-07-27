-- 1
select STUDENT_NO 학번, STUDENT_NAME 이름, to_char(ENTRANCE_DATE, 'RRRR-MM-DD') 입학년도
from tb_student
where DEPARTMENT_NO = 002
order by 3;

-- 2
select PROFESSOR_NAME, PROFESSOR_SSN
from tb_professor
where PROFESSOR_NAME not like '___';

-- 3
select PROFESSOR_NAME 교수이름, to_char(sysdate, 'YYYY')-(19||SUBSTR(PROFESSOR_SSN, 1, 2)) 나이
from tb_professor
where SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
order by 2,1;

-- 4
select SUBSTR(PROFESSOR_NAME, 2, 2) 이름
from tb_professor;

-- 5
select STUDENT_NO, STUDENT_NAME
from TB_STUDENT
where (to_char(ENTRANCE_DATE,'YYYY')-(19||SUBSTR(STUDENT_SSN, 1, 2))) > 19;

-- 6 X
SELECT to_char(to_date('2020/12/25'), 'YYYYMMDD DAY') 
from dual;

-- 8
select STUDENT_NO, STUDENT_NAME
from tb_student
where STUDENT_NO not like 'A%';

-- 9
select round(avg(POINT),1) 평점
from tb_grade
where STUDENT_NO = 'A517178';

-- 10
select DEPARTMENT_NO 학과번호, count(*) "학생수(명)"
from tb_student
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 11
select count(*)
from tb_student
where COACH_PROFESSOR_NO is null;

-- 12
select substr(TERM_NO,1,4) 년도, 
round(avg(point),1) 평점
from tb_grade
where STUDENT_NO = 'A112113'
group by substr(TERM_NO,1,4);

-- 13 ABSENCE_YN X
select DEPARTMENT_NO 학과코드명,
       sum(case when ABSENCE_YN = 'Y' then 1
           else 0
           END) "휴학생 수"
from tb_student
GROUP BY DEPARTMENT_NO
ORDER BY 1;

- 14
select STUDENT_NAME 동일이름, count(*) "동명인 수"
from tb_student
GROUP BY STUDENT_NAME
having count(*) >= 2
order by 1;