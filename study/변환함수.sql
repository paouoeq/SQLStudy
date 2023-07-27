-- 변환 함수
--자동 형변환
SELECT last_name, salary
FROM employees
WHERE salary = '17000'; -- salary : 숫자 데이터 but 문자로 넣어도 자동 형변환

SELECT last_name, salary
FROM employees
WHERE hire_date = '03/06/17'; -- 문자 -> 날짜 자동 형변환

--명시적 형변환
-- TO_CHAR : 숫자 -> 문자 / 날짜 -> 문자
--날짜
SELECT SYSDATE, to_char(sysdate,'YYYY'), to_char(sysdate,'MM') -- 출력 형식에 맞추어 출력
from dual;
SELECT SYSDATE, to_char(sysdate,'YYYY/MM/DD MON DAY DY') -- 년도를 마음대로 표현할 수 있음
from dual;
SELECT SYSDATE, to_char(sysdate,'YYYY"년"MM"월"DD"일"') -- 중간에 년월일 -> 인식못함. 따라서 값으로 넣어줘야함("")
from dual;

--시간
SELECT SYSDATE, to_char(sysdate,'AM HH : HH24 : MI : SS')
from dual;
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD,(AM) DY HH24:MI:SS')
FROM dual;

--날짜에서 특정년도만 추출, 월만 추출, 일만 추출 => to_char 또는 extract
select sysdate, to_char(sysdate, 'YYYY'), to_char(sysdate, 'MM') -- to_char
from dual;

select sysdate, extract(year from sysdate) 년, extract(month from sysdate) 월, -- extract
extract(day from sysdate) 일, extract(hour from systimestamp) 시,
extract(minute from systimestamp) 분, extract(second from systimestamp) 초
from dual;

SELECT last_name,hire_date, salary
FROM employees
WHERE TO_CHAR(hire_date, 'MM')='09';  -- to_char
SELECT last_name,hire_date, salary
FROM employees
WHERE extract(month from hire_date)='09';  -- extract로 변경

-- 숫자 -> 문자
SELECT last_name, salary, 
 TO_CHAR(salary, '$999,999') 달러,
 TO_CHAR(salary, 'L999,999') 원화
FROM employees;

select to_char(98765432,'L999,999,999')
from dual;


-- TO_NUMBER : 문자 -> 숫자
SELECT TO_NUMBER('123') + 100 
FROM dual;
SELECT TO_NUMBER('123,456') + 100  -- 123,456은 숫자 형태 문자열이 아니어서 오류 -> 포맷을 사용하면 됨
FROM dual;
SELECT TO_NUMBER('123,456', '999,999') + 100  -- 포맷사용
FROM dual;
SELECT TO_NUMBER('$123,456', '$999,999') + 100  -- 달러 형태도 포맷 지정해주면 숫자로 변경 가능
FROM dual;


-- TO_DATE : 문자 -> 날짜
ALTER SESSION SET NLS_DATE_FORMAT='YYYY/MM/DD HH24:MI:SS'; --  NLS_DATE_FORMAT 파라미터값을 변경(오라클 날짜 형식 변경)
SELECT TO_DATE( '20170802181030' , 'YYYYMMDDHH24MISS' ) -- 문자 '20170802181030'을 날짜 형식으로 변환
FROM dual;
SELECT TO_DATE( '2017년08월02일' , 'YYYY"년"MM"월"DD"일"' ) -- 문자 '2017년08월02일'를 포맷지정 후 날짜로 변환
FROM dual;

SELECT SYSDATE, SYSDATE-TO_DATE( '20170801' , 'YYYYMMDD' ) -- 문자를 날짜로 변환 후 날짜 연산
FROM dual;