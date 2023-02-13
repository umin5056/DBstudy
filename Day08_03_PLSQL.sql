/*
    PL/SQL
    1. 오라클 전용 문법이고 프로그래밍 처리가 가능한 SQL이다.
    2. 형식
        [declare
            변수 선언]
        begin
            수행할 PL/SQL
        end;
    3. 변수에 저장된 메세지 출력을 위해서 서버 출력을 on 시켜줘야 한다.
        최초 1번만 실행시켜 두면 된다. (디폴트는 off)
        set serveroutput on;
*/

-- 서버출력 on
set serveroutput on;

-- 서버출력 확인
begin 
    dbms_output.put_line('Hello World');
end;

/*
    테이블 복사하기
    1. create table과 복사할 데이터의 조회(select)를 이용한다.
    2. pk와 fk 제약조건은 복사되지 않는다.
    3. 복사하는 쿼리
        1) 데이터를 복사하기
            create table 테이블 as (select 칼럼 from 테이블);
*/

-- HR 계정의 employees 테이블을 GDJ61 계정으로 복사해서 기초 데이터로 사용하기
drop table employees;
create table employees
    as (select *
          from HR.employees);
          
-- employees 테이블에 pk 생성하기
alter table employees
    add constraint pk_employee primary key(employee_id);


/* 
    변수 선언하기
    1. 대입 연산자(:=)를 사용한다.
    2. 종류
        1) 스칼라 변수  : 타입을 직접 지정한다.
        2) 참조 변수    : 특정 칼럼의 타입을 가져다가 지정한다.
        3) 레코드 변수  : 2개 이상의 칼럼을 합쳐서 하나의 타입으로 지정한다.
        4) 행 변수      : 행 전체 데이터를 저장한다.
*/        

-- 1. 스칼라 변수
--      직접 타입을 명시
declare
   name varchar2(10 byte);
    age number(3);
begin
    name := '제시카';
    age  := 30;
    dbms_output.put_line('이름은 ' || name || '입니다.');
    dbms_output.put_line('나이는' || age || '살입니다.');
end;    

-- 2. 참조 변수
--    특정 칼럼의 타입을 그대로 사용하는 변수
--    select 절의 into를 이용해서 테이블의 데이터를 가져와서 변수에 저장할 수 있다.
--    선언방법 : 변수명 테이블명.칼럼명%type
declare
    fname employees.first_name%type;
    lname employees.last_name%type;
    sal employees.salary%type;
begin
    select first_name, last_name, salary
      into fname, lname, sal
      from employees
     where employee_id = 100;
    dbms_output.put_line(fname || ',' || lname || ',' || sal);
end;          