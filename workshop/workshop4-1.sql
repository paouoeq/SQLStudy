-- 34
update TB_DEPARTMENT
set CAPACITY = round(capacity+(capacity*0.1));

-- 35
update TB_STUDENT
set STUDENT_ADDRESS = '서울시 종로구 숭인동 181-21'
where STUDENT_NO = 'A413042';

-- 36
update TB_STUDENT
set STUDENT_SSN = substr(STUDENT_SSN, 1,6);

-- 37
update TB_GRADE
set point = 3.5
where student_no = (select student_no
                    from TB_STUDENT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
                    where STUDENT_NAME = '김명훈' AND DEPARTMENT_NAME = '의학과') 
       AND CLASS_NO = (select CLASS_NO
                       from TB_CLASS
                       where CLASS_NAME = '피부생리학');

select POINT
from TB_GRADE join TB_STUDENT using(STUDENT_NO)
     join TB_CLASS using (CLASS_NO)
where STUDENT_NAME = '김명훈' AND CLASS_NAME = '피부생리학';
       
-- 38
DELETE FROM TB_GRADE
WHERE STUDENT_NO IN ( SELECT STUDENT_NO
                     FROM TB_STUDENT JOIN TB_GRADE USING(STUDENT_NO)
                     WHERE ABSENCE_YN = 'Y');

SELECT STUDENT_NO, POINT
FROM TB_STUDENT JOIN TB_GRADE USING(STUDENT_NO)
WHERE ABSENCE_YN = 'Y';

--------
rollback;