show user;

select * from scott.emp; -- 보안 이슈 발생 가능(어떤 계정에 어떤 테이블이 있는지 알 수 있음)
-- 해결 : 시노님(별칭 사용)
create synonym s_emp
for scott.emp;

select * from s_emp;

drop synonym s_emp;