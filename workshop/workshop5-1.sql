-- 1
create table TB_CATEGORY
( NAME VARCHAR2(10),
  USE_YN CHAR(1) default 'Y'
);

-- 2
create table TB_CLASS_TYPE
( NO VARCHAR2(5) constraint tb_clss_type_no_pk primary key,
  NAME VARCHAR2(10)
);

-- 3
alter table TB_CATEGORY
add constraint tb_class_category_name_pk primary key(name);

-- 4
alter table TB_CLASS_TYPE
modify (name VARCHAR2(10) constraint tb_class_type_name_nn not null);

-- 5
alter table TB_CATEGORY
modify ( name VARCHAR2(20) );

alter table TB_CLASS_TYPE
modify ( no VARCHAR2(10) ,
         name VARCHAR2(20) );