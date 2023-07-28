--ORACLE JOIN
--===================================================================================================--
-- 제약조건 검색
select * from user_constraints
where table_name = 'EMPLOYEES';

select * from user_constraints
where table_name = 'DEPARTMENTS';

--===================================================================================================--

-- equi join, inner join
SELECT last_name,department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

SELECT employees.last_name, departments.department_name -- 테이블명.컬럼명 형태
FROM employees, departments
WHERE employees.department_id = departments.department_id;

--------------------------------------------------------------------------------

-- 지정된 테이블에 모두 존재하는 컬럼은 반드시 테이블명.컬럼명 형태로 표현
SELECT last_name,department_name, department_id -- department_id는 공통컬럼이기 때문에 에러(누구꺼인지 모름)
FROM employees, departments
WHERE employees.department_id = departments.department_id;

--------------------------------------------------------------------------------

-- 테이블 별칭
SELECT emp.last_name,department_name, emp.department_id
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id;

-- 주의 : 별칭을 지정하면 반드시 별칭으로 사용해야함(테이블명은 이제 사용 불가)
SELECT employees.last_name,department_name, employees.department_id
FROM employees emp, departments dept
WHERE employees.department_id = departments.department_id;

--------------------------------------------------------------------------------

-- 검색 조건 추가
SELECT etmp.last_name,salary,department_name 
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id -- 조인 조건
AND last_name='Whalen'; -- 검색 조건

SELECT d.department_name 부서명, COUNT(e.employee_id) 인원수
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND TO_CHAR( hire_date , 'YYYY') <= 2005
GROUP BY d.department_name -- join과 같이 사용할 수 있음
ORDER BY 2;

--===================================================================================================--

-- Non-Equi join (employees ~ job_grades), inner join
SELECT last_name, salary, grade_level
FROM employees e, job_grades g
WHERE e.salary BETWEEN g.lowest_sal AND g.highest_sal;

-- 3개의 테이블 조인
SELECT last_name, salary, department_name, grade_level
FROM employees e, departments d, job_grades g
WHERE e.department_id = d.department_id
AND e.salary BETWEEN g.lowest_sal AND g.highest_sal;

--===================================================================================================--

-- self join, inner join
--사원 테이블 가상으로 생성
select employee_id, last_name, manager_id
from EMPLOYEES e;
--매니저 테이블 가상으로 생성
select employee_id, last_name
from EMPLOYEES m;
-- 사원 테이블과 매니저 테이블 조인
select e.employee_id, e.last_name 사원명, m.last_name 관리자명
from employees e, employees m
where e.manager_id = m.employee_id;

-- 질문 : 사원명(e) 관리자명(m) 관리자의 관리자명(m2)을 출력하시오.
select e.last_name 사원명, m.last_name 관리자명, m2.last_name "관리자의 관리자명"
from employees e, employees m, employees m2
where e.manager_id = m.employee_id and m.manager_id = m2.employee_id;
-- 92행 출력 => 관리자가 king이면 관리자의 관리자가 없기 때문에 m이 king인 행은 제외됨.

--===================================================================================================--

-- outer join
--inner 조인 -> emp.department_id에 null값이 있어 107행중 106행만 나온다.
SELECT emp.last_name,department_name, emp.department_id
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id;
--outer 조인 연산자를 활용해 107행 모두 출력
SELECT emp.last_name,department_name, emp.department_id
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id(+);

-- inner로 106행 나오던 것도 outer 조인 연산자를 통해 107행 모두 출력
select e.employee_id, e.last_name 사원명, m.last_name 관리자명
from employees e, employees m
where e.manager_id = m.employee_id(+);

-- inner로 92행만 출력되던 것도 outer 조인 연산자를 통해 107행 모두 출력
SELECT e.last_name 사원명,
 m.last_name 관리자명, m2.last_name "관리자의 관리자명" 
FROM employees e, employees m , employees m2
WHERE e.manager_id = m.employee_id(+) 
AND m.manager_id = m2.employee_id(+);

--===================================================================================================--

-- cartesian projuct 조인 : 107 * 27 = 2889 <못 쓰는 데이터>
SELECT emp.last_name, department_name, emp.department_id
FROM EMPLOYEES emp, departments dept;