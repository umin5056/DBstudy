-- 문자열 함수


-- 1. 대소문자 변환 함수
select
       upper(email)   -- 대문자로 변환
     , lower(email)   -- 소문자로 변환 
     , initcap(email) -- 첫 글자만 대문자, 나머지 소문자
  from   
       employees; 


-- 2. 글자 수 or 바이트 수 반환 함수
select
       length('hello') -- 글자 수 : 5
     , length('안녕')  -- 글자 수 : 2
     , lengthb('hello')-- 바이트  : 5
     , lengthb('안녕') -- 바이트  : 6
  from 
       dual;


-- 3. 문자열 연결 함수/연산자
--    1) 함  수 : concat(a,b) 주의! 인수가 2개만 전달 가능. (concat(a,b,c) - 불가능)
--    2) 연산자 : ||          주의! or 연산자 아님, 오라클 전용.
select
       concat(first_name, concat(' ',last_name))
     , first_name || ' ' || last_name
  from 
       employees;
       
-- 4. 문자열 일부 반환하기
--    substr(칼럼, begin, legnth) : begin부터 length개를 반환
--    주의! begin은 1부터 시작.
select 
       substr(email, 0, 3) -- 1번째 글자부터 3개를 반환
  from 
       employees;
       
-- 5. 특정 문자열의 위치 반환
--    instr(칼럼, 찾을 문자열,)
--    주의! 반환되는 위치 정보는 1부터 시작한다.
--    못 찾으면 0을 반환한다.
select
       instr(email, 'A') -- 'A'의 위치를 반환
  from 
       employees;
       
-- 6. 문자열 채우기(padding)       
--    1) lpad(칼럼, 전체폭, 채울 문자)
--    2) rpad(칼럼, 전체폭, 채울 문자)
select
       lpad(department_id, 3, 0)
     , rpad(email, 10, '*') 
  from 
       employees;

-- 6-1. 문제 (id는 null -> 000 || email은 첫 두글자 + ***)
select
       lpad(nvl(department_id, 0), 3, 0)
     , rpad(substr(email,1,2), 5, '*')
  from 
       employees;

-- 7. 불필요한 공백 제거
--    1) ltrim(칼럼) : 왼쪽 공백 제거
--    2) rtrim(칼럼) : 오른쪽 공백 제거
--    3)  trim(칼럼) : 양쪽 공백 제거

select
       '[' || ltrim('      hello') || ']'
     , '[' || rtrim('hello      ') || ']'
     , '[' ||  trim('   hello   ') || ']'
  from dual;    

