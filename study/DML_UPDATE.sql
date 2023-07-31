select * from mydept;

-- 조건X
update mydept
set dname='영업', loc='경기';

-- (50, 개발, 서울)  ->  (50, 영업, 경기)로 변경
update mydept
set dname='영업', loc='경기'
where deptno = 50;

commit;
rollback;

-- 서브쿼리 이용 update
UPDATE mydept
SET dname= ( SELECT dname
             FROM dept
             WHERE deptno = 10),
     loc= ( SELECT loc
             FROM dept
             WHERE deptno=20)
WHERE deptno = 60;

select * from mydept;

commit;