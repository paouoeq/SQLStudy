-- where절 O
DELETE FROM mydept
WHERE deptno = 50;

select * from mydept;

commit;

-- where절 X
delete from mydept;

select * from mydept;

rollback;

-- delete + subquery
DELETE 
FROM mydept
WHERE loc = (SELECT loc
             FROM dept
             WHERE deptno = 20);
commit;