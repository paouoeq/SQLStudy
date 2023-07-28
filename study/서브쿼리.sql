-- 서브쿼리
--------------------------------------------------------------------------------
--사원 테이블에서 Whalen 사원보다 많은 월급을 받는 사원을 조회하기
--1. Whalen 사원의 월급 파악 => 4400
SELECT salary
FROM employees
WHERE last_name='Whalen';
--2. Whalen 사원보다 많은 월급을 받는 사원을 조회
SELECT last_name,salary
FROM employees
WHERE salary >= 4400;
--------------------------------------------------------------------------------
-- 서브쿼리 활용 => 한번에 파악 가능
SELECT last_name,salary
FROM employees
WHERE salary >= (SELECT salary
                  FROM employees
                  WHERE last_name='Whalen');
--------------------------------------------------------------------------------
-- 단일행 연산자 : 비교연산자
-- 사원들의 평균 월급보다 더 많은 월급을 받는 사원 조회
SELECT last_name,salary
FROM employees
WHERE salary >= (SELECT AVG(salary)
                 FROM employees);
--문제 : 다음은 부서번호가 100인 사원들 중에서 최대 월급을 받는 사원과 동일한 월급을 받는 사원을 조회
select last_name, salary
from employees
where salary >= ( select max(salary)
                   from employees
                   where DEPARTMENT_ID = 100);
--having 절에서 사용 : 100번 부서의 최대 월급보다 많은 모든 부서 정보 출력
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > (SELECT MAX(salary)
                      FROM employees
                      WHERE department_id=100 );
--------------------------------------------------------------------------------
-- 복수행 연산자

-- IN
SELECT last_name, salary
FROM employees
WHERE salary IN ( SELECT salary
                  FROM employees
                  WHERE last_name IN ('Whalen','Fay') );

-- ALL
-- 직업이 IT_PROG 인 사원의 최대 월급보다 많은 월급을 받는 사원들의 정보
SELECT last_name, department_id, salary
FROM employees
WHERE salary > ALL (SELECT salary
               FROM employees
               WHERE job_id = 'IT_PROG');
-- 단일행 연산자 + max 사용하는 것과 동일
SELECT last_name, department_id, salary
FROM employees
WHERE salary > (SELECT max(salary)
                FROM employees
                WHERE job_id = 'IT_PROG');
                
-- 직업이 IT_PROG 인 사원의 최소 월급보다 적은 월급을 가진 사원정보 : < ALL
SELECT last_name, department_id, salary
FROM employees
WHERE salary < ALL (SELECT salary
               FROM employees
               WHERE job_id = 'IT_PROG');
-- 단일행 연산자 + min 사용하는 것과 동일
SELECT last_name, department_id, salary
FROM employees
WHERE salary < (SELECT min(salary)
                FROM employees
                WHERE job_id = 'IT_PROG');

--------------------------------------------------------------------------------

-- ANY
--  직업이 IT_PROG 인 사원의 최소 월급보다 많은 월급을 받는 사원정보 : > ANY
SELECT last_name, department_id, salary
FROM employees
WHERE salary > ANY (SELECT salary
                    FROM employees
                    WHERE job_id = 'IT_PROG');
-- 단일행 연산자 + min 사용하는 것과 동일
SELECT last_name, department_id, salary
FROM employees
WHERE salary > (SELECT min(salary)
                FROM employees
                WHERE job_id = 'IT_PROG');

-- 직업이 IT_PROG 인 사원의 최대 월급보다 작은 월급을 받는 사원정보 : < ANY
SELECT last_name, department_id, salary
FROM employees
WHERE salary < ANY (SELECT salary
               FROM employees
               WHERE job_id = 'IT_PROG');
--  단일행 연산자 + max 사용하는 것과 동일
SELECT last_name, department_id, salary
FROM employees
WHERE salary < (SELECT max(salary)
                FROM employees
                WHERE job_id = 'IT_PROG');

--------------------------------------------------------------------------------

-- EXIST : 서브쿼리에 실행된 결과가 하나라도 존재하는지 여부를 확인
--커미션을 받는 사원이 한 명이라도 있느면 모든 사원 정보 출력(107행)
SELECT last_name, department_id, salary
FROM employees
WHERE EXISTS (SELECT employee_id -- 메인쿼리 : true면 사원이름, 부서id, 월급 정보 출력, false면 메인쿼리 실행 X
              FROM employees
              WHERE commission_pct IS NOT NULL); -- 서브쿼리 : 커미션 값이 모두 null이 아니면 사원id 정보 출력
--서브쿼리 실행결과가 false를 반환하여 메인 쿼리가 실행되지 않는 SQL문
SELECT last_name, department_id, salary
FROM employees
WHERE EXISTS ( SELECT employee_id
               FROM employees
               WHERE salary > 500000 );
               
--------------------------------------------------------------------------------

-- 다중 컬럼 서브쿼리
--부서별로 가장 많은 월급을 받는 사원 정보 출력
SELECT last_name, department_id, salary
FROM employees
WHERE (department_id, salary) IN ( SELECT department_id, MAX(salary)
                                   FROM employees
                                   GROUP BY department_id )
ORDER BY 2;

--------------------------------------------------------------------------------

-- 인라인 뷰
--사원 테이블과 부서 테이블에서 부서별 월급 총합과 평균 그리고 부서별 인원수를 출력하는 SQL문
SELECT e.department_id , SUM(salary) 총합, AVG(salary) 평균, COUNT(*) 인원수
FROM employees e , departments d
WHERE e.department_id = d.department_id
GROUP BY e.department_id
ORDER BY 1;

--인라인뷰 활용
SELECT e.department_id, 총합, 평균, 인원수
FROM ( SELECT department_id, SUM(salary) 총합, AVG(salary) 평균 ,
              COUNT(*) 인원수 
              FROM employees
              GROUP BY department_id ) e, departments d
WHERE e.department_id = d.department_id
ORDER By 1;
