-- 1. 모든 컬럼 보기
select * from employees;
--줄을 나눠도 됨
select *
from employees;

select * from departments;

-- 2. 특정 컬럼 보기
SELECT employee_id, last_name, hire_date, salary FROM employees;

-- 3. 산술연산자
SELECT last_name, salary, salary * 12 FROM employees;

-- 4. 별칭
SELECT last_name as 이름, salary 월급, salary * 12 as 연봉 FROM employees;
SELECT last_name as "사원 이름", salary "사원 월급", salary * 12 as "연 봉" FROM employees;

-- 5. null값
SELECT last_name 이름, salary 월급, commission_pct 수수료, salary* 12+commission_pct as 연봉 FROM employees;

SELECT last_name 이름, salary 월급, commission_pct 수수료, salary * 12+NVL(commission_pct,0) as 연봉 FROM employees;

-- 6. 연결 연산자
SELECT last_name || salary as "이름 월급" FROM employees;
SELECT last_name || '사원' FROM employees;
SELECT last_name || '의 직업은 ' || job_id || ' 입니다' as "사원별 직급" FROM employees;

-- 7. 중복제거
SELECT job_id FROM employees;
SELECT distinct job_id FROM employees;

-- 8. where 절 비교연산자
SELECT employee_id,last_name,job_id, salary FROM employees WHERE salary >= 10000;

-- SQL문의 식별자는 대소문자 구별X 값(리터럴)은 대소문자 구별
SELECT employee_id,last_name,job_id, salary FROM employees WHERE last_name = 'KING';

-- 날짜 - 2008년 이후 입사
SELECT employee_id,last_name,salary,hire_date FROM employees WHERE hire_date > '07/12/31';

-- Between a And b
SELECT employee_id,last_name,salary,hire_date
FROM employees
WHERE salary BETWEEN 7000 AND 8000;

  -- 날짜도 가능
SELECT employee_id,last_name,salary,hire_date FROM employees WHERE hire_date BETWEEN '07/01/01' AND '08/12/31';

-- 9. in 연산자
SELECT employee_id,last_name,salary,hire_date FROM employees WHERE employee_id IN ( 100,200,300 );
SELECT employee_id,last_name,salary,hire_date FROM employees WHERE last_name IN ( 'King','Abel','Jones');
SELECT employee_id,last_name,salary,hire_date FROM employees WHERE hire_date IN ( '01/01/13','07/02/07');


-- 10. like 연산자 (%)
SELECT employee_id,last_name,salary FROM employees WHERE last_name LIKE 'J%';
SELECT employee_id,last_name,salary FROM employees WHERE last_name LIKE '%ai%';
SELECT employee_id,last_name,salary FROM employees WHERE last_name LIKE '%in';

-- 10. like 연산자 (_)
SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE '_b%';

SELECT employee_id,last_name,salary
FROM employees
WHERE last_name LIKE '_____d';

-- _를 포함한 이름 찾기 1 - 실패
SELECT employee_id,last_name,salary FROM employees WHERE last_name LIKE '%_%'; -- _를 와일드카드 문자로 인식

-- _를 포함한 이름 찾기 2 - ESCAPE 사용
SELECT employee_id,last_name,salary,job_id FROM employees WHERE job_id LIKE '%E___' ESCAPE 'E';

-- 11. 논리연산자 - and
SELECT last_name,job_id,salary
FROM employees
WHERE job_id = 'IT_PROG' AND salary >= 5000;

-- 11. 논리연산자 - or
SELECT last_name,job_id,salary
FROM employees
WHERE job_id = 'IT_PROG' OR salary >= 5000;

-- 11. 논리연산자 - not
SELECT last_name,job_id,salary FROM employees WHERE NOT salary < 20000;
SELECT last_name,job_id,salary FROM employees WHERE salary NOT IN (9000,8000,6000 );
SELECT last_name,job_id,salary FROM employees WHERE last_name NOT LIKE 'J%';
SELECT last_name,job_id,salary FROM employees WHERE salary NOT BETWEEN 2400 AND 20000;

SELECT last_name,job_id,salary FROM employees WHERE commission_pct IS NULL; -- null값 가진 레코드 출력
SELECT last_name,job_id,salary FROM employees WHERE manager_id IS NULL; -- null값 가진 레코드 출력
SELECT last_name,job_id,salary FROM employees WHERE manager_id IS NOT NULL; -- null값이 아닌 레코드 출력

-- 논리 연산자 자용시 주의 : and가 or보다 우선순위가 높다.
SELECT last_name,job_id,salary,commission_pct
FROM employees
WHERE job_id ='AC_MGR' OR job_id='MK_REP' 
AND commission_pct IS NULL 
AND salary >=4000 
AND salary <= 9000;

SELECT last_name,job_id,salary,commission_pct
FROM employees
WHERE ( job_id ='AC_MGR' OR job_id='MK_REP' )  -- or에 괄호 사용
AND commission_pct IS NULL
AND salary >=4000
AND salary <= 9000;

-- 12. order by절
SELECT employee_id,last_name,job_id,salary
FROM employees
ORDER BY salary DESC; -- 내림차순

SELECT employee_id,last_name,job_id,salary
FROM employees
ORDER BY salary asc; -- 오름차순

SELECT employee_id,last_name,job_id,salary
FROM employees
ORDER BY salary; -- 기본은 오름차순

SELECT employee_id,last_name,job_id,salary as "월급" FROM employees
ORDER BY 월급 DESC; -- 컬럼명 대신 별칭 사용

SELECT employee_id,last_name,job_id,salary as "월급" FROM employees
ORDER BY 4 DESC; -- select에 적혀진 컬럼의 4번째 컬럼

-- order by - 문자열 정렬
SELECT employee_id,last_name as 이름,job_id,salary 
FROM employees
ORDER BY last_name ASC; -- 아스키 코드에 의해 A:65, B:66

SELECT employee_id,last_name as 이름,job_id,salary 
FROM employees
ORDER BY 이름 ASC; -- 컬럼명대신 별칭으로

SELECT employee_id,last_name as 이름,job_id,salary 
FROM employees
ORDER BY 2 ASC; -- select절의 2번째 컬럼 = last_name

-- order by - 날짜 데이터 정렬
SELECT employee_id,last_name,salary,hire_date as 입사일
FROM employees
ORDER BY hire_date DESC; -- 내림차순 -> 최근부터 옛날로

SELECT employee_id,last_name,salary,hire_date as 입사일
FROM employees
ORDER BY 입사일 DESC; -- 별칭으로 가능

SELECT employee_id,last_name,salary,hire_date as 입사일
FROM employees
ORDER BY 4 DESC; -- 순서로도 가능

-- order by - 다중 데이터 정렬
SELECT employee_id,last_name,salary,hire_date
FROM employees
ORDER BY salary DESC, hire_date desc;

SELECT employee_id,last_name,salary as 월급,hire_date
FROM employees
ORDER BY 월급 DESC, 4 desc; -- 순서, 별칭 가능

-- order by - null값 정렬
SELECT employee_id,last_name,salary,hire_date, COMMISSION_PCT
FROM employees
order by COMMISSION_PCT; -- 오름차순 => null값이 가장 마지막

-- *) dual : 임시테이블
select 23487*895632 from dual;
select sysdate from dual; -- 현재 날짜정보

-----------------------------------------------------------------------------------------

-- 13. 함수 - 문자처리함수
-- initcap : 단어의 첫문자만 대문자
SELECT INITCAP('ORACLE SQL') FROM dual;
SELECT email, INITCAP(email) FROM employees; -- 기본 email과 initcap 적용한 email 비교

--upper : 모든 문자 대문자
SELECT last_name, UPPER(last_name) FROM employees;
SELECT last_name, salary FROM employees WHERE UPPER(last_name)='KING'; -- 검색에 용이함

--lower : 모든 문자 소문자
SELECT last_name, LOWER(last_name) FROM employees;

--concat : 문자열 연결
SELECT CONCAT( last_name, salary) FROM employees;
SELECT last_name || salary FROM employees; -- 문자열 연결은 연결연산자로도 가능(함수 사용하지 않고)

--length : 문자열 길이
SELECT last_name, LENGTH(last_name) FROM employees;

--instr : 특정 문자 위치
SELECT INSTR('MILLER' , 'L', 1 , 2 ), INSTR('MILLER' , 'X', 1 , 2 ) FROM dual;
SELECT INSTR('MILLER' , 'L', 5 , 2 ), INSTR('MILLER' , 'X', 1 , 2 ) FROM dual;
-- 5번째 글자(E)부터 시작해서 L을 찾을 수 없음 -> 0 반환

--substr : 문자열 일부분 추출
SELECT SUBSTR('900303-1234567' , 8 , 1 ) FROM dual; -- 8번째부터 1개 반환
SELECT SUBSTR('900303-1234567' , 8 ) FROM dual; -- 8번째 뒤로 모든 값 반환
SELECT hire_date 입사일, SUBSTR(hire_date,1,2) 입사년도 FROM employees; -- 1번째부터 2개 반환
SELECT SUBSTR('900303-1234567' , -8 ) FROM dual;

-- replace : 특정 문자열 치환
SELECT REPLACE('JACK and JUE' , 'J' , 'BL' ) FROM dual;

--lpad : 오른쪽 정렬 후 왼쪽에 특정 문자 채우기
SELECT LPAD('MILLER' , 10 , '*' ) FROM dual; -- 10글자중 miller 오른쪽 정렬, 남은 문자는 *

--rpad : 왼쪽 정렬 후 오른쪽에 특정 문자 채우기
SELECT RPAD('MILLER' , 10 , '*' ) FROM dual; -- 10글자중 miller 왼쪽 정렬, 남은 문자는 *
    -- 주민번호 가리기 3가지 방법 --
SELECT SUBSTR('900303-1234567',1,8)||'******' 주민번호 FROM dual; -- 문자열 연결
SELECT RPAD(SUBSTR('900303-1234567',1,8),14,'*' ) 주민번호 FROM dual; -- substr, rpad 사용
SELECT REPLACE( '900303-1234567', SUBSTR('900303-1234567', 9 ) , '*****' ) 주민번호 FROM dual;
      -- substr : 9번째부터 끝까지의 번호 문자열 반환 -> replace로 전체 문자열 중 substr 문자열에 해당하는 값 *로 변경

--ltrim : 왼쪽의 공백 및 특정 문자 삭제
SELECT LTRIM('MILLER', 'M') FROM dual;
SELECT LTRIM('MMMMMMMILLMMER', 'M') FROM dual;
-- 왼쪽에서부터 m을 찾아 삭제하다, m이 아닌 문자를 만나면 멈춤
SELECT LTRIM('     MILLER     '), LENGTH(LTRIM('     MILLER     ')) FROM dual;
--왼쪽 공백 삭제 -> M만나서 멈춤

--rtrim : 문자열의 마지막 문자부터 탐색 시작 -> 오른쪽 공백 및 특정 문자 삭제
SELECT RTRIM('MILRRLERRRRR', 'R') FROM dual;
SELECT RTRIM('     MILLER     '), LENGTH(RTRIM('     MILLER     ')) FROM dual;

--trim : 왼쪽, 오른쪽, 양쪽 삭제
SELECT TRIM( '0' FROM '0001234567000' ) FROM dual; -- 양쪽(BOTH)
SELECT TRIM( LEADING '0' FROM '0001234567000' ) FROM dual; -- 왼쪽(LEADING)
SELECT TRIM( TRAILING '0' FROM '0001234567000' ) FROM dual; -- 오른쪽(TRAILING)

-- 13. 함수 - 숫자 처리 함수
--round : 반올림
SELECT ROUND( 456.789, 2 ) FROM dual; -- 소수점 2자리까지 표현
SELECT ROUND( 456.789, -1 ) FROM dual; -- 정수 첫번째 자리 반올림
SELECT ROUND( 456.789 ) FROM dual; -- 안쓰면 소수점 반올림해 정수 출력

--trunc : 절삭
SELECT TRUNC( 456.789, 2 ) FROM dual; -- 절삭 후 소수점 두번째 자리까지 출력
SELECT TRUNC( 456.789, -1 ) FROM dual; -- 정수 첫번째 자리부터 절삭
SELECT TRUNC( 456.789 ) FROM dual; -- 생략하면 소수점 절삭

--mod : 나머지
SELECT MOD( 10 , 3 ) , MOD( 10 , 0 ) FROM dual; -- 10%3, n자리에 0 -> 값 자체 반환
SELECT employee_id,last_name,salary FROM employees WHERE MOD(employee_id,2)=1; -- employee_id가 홀수인 값만 출력

--ceil : 크거나 같은 최소 정수값
SELECT CEIL(10.6), CEIL(-10.6) FROM dual;

--floor : 작거나 같은 최대 정수값
SELECT FLOOR(10.6), FLOOR(-10.6) FROM dual;

--sign : 양수/음수/0 식별
SELECT SIGN( 100 ) , SIGN(-20) , SIGN(0) FROM dual;
SELECT employee_id, last_name, salary FROM employees WHERE SIGN(salary-15000)=1; 
        -- salary-15000했을 때 음수인 값 => salary>15000인 값

