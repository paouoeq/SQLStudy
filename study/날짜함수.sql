-- 1. 날짜 함수
-- 파라미터 설정값 출력
select * from NLS_SESSION_PARAMETERS;

-- RR과 YY 비교
create table exam (a date, b date);

-- 시스템 년도 : 2023년
insert into exam(a,b) values (to_date('15/01/01','RR/MM/DD'), to_date('15/01/01','YY/MM/DD'));
select to_char(a,'RRRR'), to_char(b,'YYYY') from exam; -- RR:2015, YY:2015

-- 시스템 년도를 1995년도로 변경
insert into exam(a,b) values (to_date('15/01/01','RR/MM/DD'), to_date('15/01/01','YY/MM/DD'));
select to_char(a,'RRRR'), to_char(b,'YYYY') from exam; -- RR:2015, YY:1915

--SYSDATE, systimestamp : 현재날짜
SELECT SYSDATE, systimestamp
FROM dual;
--날짜 연산
SELECT SYSDATE 오늘, SYSDATE+1 내일, SYSDATE-1 어제 FROM dual;
--근무일수 계산
SELECT last_name, hire_date, TRUNC((sysdate-hire_date)/365) "년" FROM employees
ORDER BY 3 desc; -- ORDER BY {TRUNC((sysdate-hire_date)/365) , 년 , 3} (택1)

--MONTH_BETWEEN : 지정된 두 날짜 사이의 개월수
SELECT last_name, hire_date, trunc(MONTHS_BETWEEN(sysdate, hire_date)) "근무 월수" FROM employees
ORDER BY 3 desc;

--ADD_MONTHS : 월 더하기 및 빼기
SELECT sysdate 현재, ADD_MONTHS(sysdate,1) 다음달, ADD_MONTHS(sysdate,-1) 이전달
FROM dual;

--NEXT_DAY : 지정된 날짜 기준 가장 가까운 지정된 요일의 날짜 반환
SELECT SYSDATE, NEXT_DAY(SYSDATE, '토'), NEXT_DAY(SYSDATE, '토요일'), NEXT_DAY(SYSDATE, 7) -- 오늘(2023.07.27)기준 가장 가까운 토요일 날짜 반환
FROM dual;

--LAST_DAY : 지정된 날짜가 속한 달의 마지막 날짜 반환
SELECT SYSDATE 현재, LAST_DAY(SYSDATE) "이번달 마지막 날", LAST_DAY(ADD_MONTHS(SYSDATE,1)) "다음달 마지막 날" -- 오늘(2023.07.27)기준 마지막 날짜 반환
FROM dual;

--ROUND : 가장 가까운 년(YEAR)도 또는 월(MONTH)로 반올림
SELECT last_name, hire_date, 
 ROUND(hire_date,'YEAR'), -- 년도 반올림
 ROUND(hire_date,'MONTH') -- 월 반올림
FROM employees;

--TRUNC : 가장 가까운 년도 또는 월로 절삭
SELECT last_name, hire_date, 
 TRUNC(hire_date,'YEAR'), -- 년도 절삭
 TRUNC(hire_date,'MONTH') -- 월 절삭
FROM employees;

