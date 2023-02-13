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

-- 3. 레코드 변수
--    여러 칼럼의 값을 동시에 저장하는 변수
--    레코드 변수 정의(만들기)와 레코드 변수 선언으로 구분해서 진행

declare
    -- 레코드 변수 정의하기
    type my_record_type is record( -- 타입명 : my_record_type
        fname employees.first_name%type,
        lname employees.last_name%type,
        sal employees.salary%type
    );
    -- 레코드 변수 선언하기
    emp my_record_type;
begin
    select first_name, last_name, salary
      into emp
      from employees
     where employee_id = 100;
     dbms_output.put_line(emp.fname || ',' || emp.lname || ',' || emp.sal); 
end;     

-- 4. 행 변수
--    행 전체 데이터를 저장할 수 있는 타입
--    항상 행 전체 데이터를 저장해야 한다.
--    선언 방법 : 변수명 테이블명%rowtype
declare 
    emp employees%rowtype;
begin 
    select employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
      into emp
      from employees
     where employee_id = 100;
     dbms_output.put_line(emp.first_name||','||emp.last_name||','|| emp.salary);
end;     


/*
    if 구문
    if 조건식 then
        실행문
    elsif 조건식 then
        실행문
    else
        실행문
    end if;    

*/

-- 성적에 따른 학점(a,b,c,d,e,f) 출력하기
declare
    score number(3);
    grade char(1 byte);
begin
    score := 100;
    if score >= 90 then
        grade := 'a';
    elsif score >=80 then
        grade := 'b';
    elsif score >= 70 then
        grade := 'c';
    elsif score >=60 then
        grade := 'd';
    else   
        grade := 'f';
    end if;
    dbms_output.put_line(score || '점은' || grade ||'학점입니다.');
end;    

-- employee_id가 150인 사원의 salary가 15000 이상이면 '고액연봉', 아니면 '보통연봉'을 출력하시오.
declare 
    emp_id employees.employee_id%type;
    sal employees.salary%type;
    message varchar2(20 byte);
    
begin 
    emp_id := 150;
    select salary
      into sal
      from employees
     where  employee_id = emp_id;
     if sal >= 15000 then
     message := '고액연봉'; 
     else 
     message := '보통 연봉'; 
     end if;
     dbms_output.put_line('사원번호 ' || emp_id || '인 사원의 연봉은' || sal || '이고 ' || message || '입니다.');
end;

-- employee_id가 150인 사원의 commission_pct가 0이면 '커미션없음', 아니면 커미션(salary*commission_pct)을 출력하시오.
declare 
    emp_id employees.employee_id%type;
    comm_pct employees.commission_pct%type;
    sal employees.salary%type;
    message varchar2(20 byte);
    
begin
    emp_id := 150;
    select nvl(commission_pct, 0), salary
      into comm_pct, sal
      from employees
     where employee_id = emp_id;
     if comm_pct = 0 then
     message := '커미션없음';
     else 
     message := to_char(comm_pct * sal);
    end if;
    dbms_output.put_line('사원번호 ' || emp_id || '인 사원의 커미션은' || message || '입니다.');
end;    
     













