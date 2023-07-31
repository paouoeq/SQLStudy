create table student
( studno number(5) constraint student_studno_pk PRIMARY KEY,
stuname varchar2(10) );

create table subject
( subno number(5) constraint subject_subno_pk primary key,
  subname varchar2(20) constraint subject_subname_nn not null,
  term varchar2(1) constraint subject_term_ck check (term in('1','2')),
  type varchar2(4) constraint subject_type_ck check (type in('필수','선택'))
);

create table sugang
( studno number(5) constraint sugang_studno_fk references student(studno),
  subno number(5) constraint sugang_subno_fk references subject(subno),
  regdate date default SYSDATE ,
  resut number(3),
  constraints sugang_studno_subno_pk primary key(studno,subno)
);