-- index 객체가 가지고 있는 주소값 : rowid
select rowid, empno, ename
from emp;

-- 출력된 값
  -- (테이블 정보) (데이터 파일 정보) (블럭 정보) (행 정보)
  --   AAAE8Z         AAE          AAAAGO    AAA
  --   AAAE8Z         AAE          AAAAGO    AAB
  --   AAAE8Z         AAE          AAAAGO    AAC
--> 16글자를 외우고 있는 것 -> 탐색 가장 빠름 -> 인덱스가 rowid값을 가지고 있음

select * from user_indexes
where table_name='EMP'; -- emp의 pk인 empno 때문에 인덱스 자동 생성

select * from emp;

-- full scan : 쿼리문 실행 후 F10 -> 계획설명창에 어떻게 동작했는지 나옴(TABLE ACCESS (FULL) : 풀스캔)
SELECT * FROM emp
WHERE ename='SMITH';

-- index
CREATE INDEX emp_ename_idx
ON emp(ename);

SELECT * FROM emp
WHERE ename='SMITH';

-- 함수를 사용하면 인덱스 사용 불가
select * from emp where upper(ename) = 'SMITH';

drop index emp_ename_idx;
