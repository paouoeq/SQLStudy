-- 그룹함수
-- SUM : 총합
SELECT SUM(DISTINCT salary),SUM(ALL salary), SUM(salary)  -- DISTINCT : 중복 제거 후 총합 계산
FROM employees;                                           -- ALL, 컬럼명 : 중복 제거 없이 총합 계산

-- SUM / AVG / MAX / MIN / COUNT
SELECT SUM(salary), AVG(salary), MAX(salary), MIN(salary), count(*)
FROM employees;

-- MAX / MIN
SELECT MIN( hire_date ), MAX( hire_date)
FROM employees;

-- COUNT
SELECT COUNT(last_name), COUNT(commission_pct), count(*)
FROM employees;

-- 명시적 그룹핑 : 부서번호별
SELECT DEPARTMENT_ID 부서번호, MAX(SALARY)부서별최대값, min(salary) 부서별최소값, 
       sum(salary) 부서별합계, avg(salary) 부서별평균, count(*) 부서별인원수
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY 1;

select department_id, sum(salary) -- department_id : 107개의 레코드 / sum(salary) : 1개의 레코드 => 오류
from employees;

select department_id, sum(salary) -- 오류 해결
from employees
group by department_id;

select department_id, sum(salary)
from employees
where sum(salary) > 3000 -- where절은 그룹함수를 사용할 수 없다. = group function is not allowed here
group by department_id;

select department_id, sum(salary)
from employees
where sum(salary) > 3000
group by department_id as "DI"; -- 별칭, 순서 사용 불가능 = group function is not allowed here
