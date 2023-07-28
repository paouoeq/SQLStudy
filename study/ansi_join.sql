-- ANSI JOIN
--===================================================================================================--

-- natural 조인
SELECT last_name,department_name, department_id
FROM employees NATURAL JOIN departments;
    -- 32개 출력 -> department_id, MANAGER_ID 두가지의 공통 컬럼을 가지고 있어
    -- 둘을 쌍으로 비교해 공통 컬럼을 출력하기 때문. 따라서 오라클과 다른 결과가 도출됨

--공통 컬럼은 별칭.컬럼/테이블.컬럼 불가능
SELECT last_name,department_name, departments.department_id
FROM employees NATURAL JOIN departments;

--별칭 사용 가능, 공통컬럼이 아닐 경우 별칭.컬럼/테이블.컬럼 가능
SELECT e.last_name, d.department_name, department_id
FROM employees e NATURAL JOIN departments d;

--ANSI는 검색조건과 조인조건을 다른 절에서 명시한다.
SELECT last_name,department_name, department_id
FROM employees e NATURAL JOIN departments d  -- 조인조건
WHERE department_id=90;                      -- 검색조건

--===================================================================================================--

-- USING 절
--natural join과 달리 106행 출력
SELECT last_name, department_name, department_id
FROM employees e INNER JOIN departments d USING(department_id);

--INNER은 생략 가능
SELECT last_name, department_name, department_id
FROM employees e JOIN departments d USING(department_id);

--공통 컬럼은 별칭.컬럼/테이블.컬럼 불가능
SELECT last_name,department_name, departments.department_id
FROM employees e JOIN departments d USING(e.department_id);

--별칭 사용 가능, 공통컬럼이 아닐 경우 별칭.컬럼/테이블.컬럼 가능
SELECT e.last_name, d.department_name, department_id
FROM employees e JOIN departments d USING(department_id);

--ANSI는 검색조건과 조인조건을 다른 절에서 명시한다.
SELECT last_name,department_name, department_id
FROM employees e JOIN departments d USING(department_id)  -- 조인조건
WHERE department_id=90;                      -- 검색조건

--===================================================================================================--

-- ON절

-- 동등 : 오라클 조인과 동일하게, 공통 컬럼은 테이블 지정해줘야 한다.
SELECT last_name,department_name, e.department_id -- 별칭/테이블 지정 필수
FROM employees e INNER JOIN departments d 
ON e.department_id = d.department_id;
--INNER 생략 가능
SELECT last_name,department_name, e.department_id
FROM employees e JOIN departments d 
ON e.department_id = d.department_id;

SELECT last_name,department_name, e.department_id
FROM employees e JOIN departments d ON e.department_id = d.department_id -- 조인조건
WHERE e.department_id=90; -- 검색조건

----------------------------------------------------------------------------------

-- 부등
SELECT last_name, salary, grade_level
FROM employees e JOIN job_grades g
ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;

----------------------------------------------------------------------------------

-- self 조인
SELECT e.last_name 사원명, m.last_name 관리자명 
FROM employees e JOIN employees m
ON e.manager_id = m.employee_id;

----------------------------------------------------------------------------------

-- 3개의 테이블 조인
SELECT e.last_name 사원명, d.department_name 부서명,
 g.grade_level 등급
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id
                 INNER JOIN job_grades g  ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;
--using으로 써도 됨
SELECT e.last_name 사원명, d.department_name 부서명,
 g.grade_level 등급
FROM employees e INNER JOIN departments d using (department_id)
                 INNER JOIN job_grades g  ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;

--===================================================================================================--

-- cross join : 데이터로 활용하진 못함. 오라클의 cartesian product 조인과 동일
SELECT last_name,department_name, e.department_id
FROM employees e cross JOIN departments d;

--===================================================================================================--
-- outer 조인

-- USING절 활용
-- 그냥 using절 : department_id값이 null 가진 Grant 사원이 누락됨
SELECT last_name,department_name, department_id
FROM employees e INNER JOIN departments d USING(department_id);
-- left outer 적용하면 -> employees 레코드 모두 출력 (107개 행 모두 출력)
SELECT last_name,department_name, department_id
FROM employees e LEFT OUTER JOIN departments d USING(department_id);
-- right outer 적용하면 -> employees 레코드 모두 출력 (107개 행 모두 출력)
SELECT last_name,department_name, department_id
FROM departments d RIGHT OUTER JOIN employees e USING(department_id);

-- ON절 활용
-- left outer 적용하면 -> employees 레코드 모두 출력 (107개 행 모두 출력)
SELECT last_name,department_name, e.department_id
FROM employees e LEFT OUTER JOIN departments d on e.department_id = d.department_id;
-- right outer 적용하면 -> employees 레코드 모두 출력 (107개 행 모두 출력)
SELECT last_name,department_name, e.department_id
FROM departments d RIGHT OUTER JOIN employees e on e.department_id = d.department_id;