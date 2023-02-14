/*
    프로시저(procedure)
    1. 하나의 프로시저에 여러 개의 쿼리문을 작성해서 처리할 수 있다.
    2. 여러 개의 쿼리문이 필요한 서비스를 프로시저로 작성해두면 사용이 편리하다.
       (예시 : 은행 이체(update 쿼리가 2개로 구성))
    3. 형식      
        create [or replace] procedure 프로시저명 [(매개변수)]
        is (as도 가능)
            변수 선언
        begin
            본문
        [exception
            예외처리]
        end;
    4. 작성된 프로시저는 excute 프로시저(); 형식으로 실행한다.
                        ㄴ 작성할 땐 괄호 생략이 가능하지만 실행 시에는 괄호 필수
    
*/

-- 프로시저1 정의(만들기)
create or replace procedure proc1
is

begin
    dbms_output.put_line('hello world');
end;

-- 프로시저1 호출(실행하기)
execute proc1();

-- 프로시저2 정의 (만들기) : 사원번호가 100이 사원의 first_name, last_name, salary를 조회하는 프로시저
create or replace procedure proc2
is
    fname employees.first_name%type;
    lname employees.last_name%type;
    sal employees.salary%type;
begin
    select first_name, last_name, salary
      into fname, lname, sal
      from employees
     where employee_id = 100;
     dbms_output.put_line(fname || ' ' || lname || ' ' || sal);
end;
-- 프로시저 2 호출(실행하기)
execute proc2();


-- 프로시저3 정의 (만들기) : 사원번호를 전달하면 해당 사원의 first_name, last_name, salary를 조회하는 프로시저
-- 입력 파라미터
-- 1. 프로시저 값을 전달할 때 사용한다.
-- 2. 형식 : 변수 이름 in 타입
create or replace procedure proc3(emp_id in employees.employee_id%type)
is
    fname employees.first_name%type;
    lname employees.last_name%type;
    sal employees.salary%type;
begin
    select first_name, last_name, salary
      into fname, lname, sal
      from employees
     where employee_id = emp_id;
     dbms_output.put_line(fname || ' ' || lname || ' ' || sal);
exception
    when others then
    dbms_output.put_line('오류발생');
end;
-- 프로시저 3 호출(실행하기)
execute proc3(0);


-- 프로시저4 정의(만들기)
-- 사원번호가 100인 사원의 first_name, last_name을 출력 파라미터로 반환하는 프로시저
-- 출력 파라미터
-- 1. 프로시저의 실행 결과를 저장하는 변수이다.
-- 2. 형식 : 변수명 out 타입

create or replace procedure proc4(fname out employees.first_name%type, lname out employees.last_name%type)
is 
begin
    select first_name, last_name
      into fname, lname -- 출력 파라미터에 값이 저장된다.
      from employees
     where employee_id = 100;
end;

-- 프로시저4 호출(실행하기)
-- fname과 lname 값을 저장할 변수를 선언한 뒤, 프로시저에 전달해야 한다.
declare
    fname employees.first_name%type;
    lname employees.last_name%type;
begin
    proc4(fname, lname);--plsql 내부에서 프로시저를 호출할 때는 execute를 생략해야 한다.
    dbms_output.put_line(fname || ',' || lname);
end;    


-- 프로시저5. 사원번호를 전달하면, 해당 사원의 first_name이 출력 파라미터 fname에 저장되도록 작성.
-- 없는 사원번호가 전달되면 fname에 출력 파라미터 'noname'이 저장되도록 작성.
create or replace procedure proc5 
    (emp_id in employees.employee_id%type,
     fname out employees.first_name%type)
is
begin
    select first_name
      into fname
      from employees
     where employee_id = emp_id;
exception
    when others then
    fname := 'noname';
end;

declare
    fname employees.first_name%type;
begin
    proc5(10,fname);
    dbms_output.put_line(fname);
end;


/*
    프로시저 연습
    1. buy_proc 프로시저 구현하기
    2. 처리할 일
        1) 구매 내역 테이블에 구매 내역을 추가(insert)
        2) 제품 테이블의 재고 내역을 수정(update)
        3) 고객 테이블의 포인트를 수정(update)
*/























