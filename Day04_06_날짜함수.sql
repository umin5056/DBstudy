
--1. 현재 날짜와 시간
select 
       sysdate
     , systimestamp
  from dual;  


-- 2. 날짜에 형식 지정하기
select 
       to_char(sysdate, 'yyyy-mm-dd')
     , to_char(sysdate, 'yyyy')
  from dual;   
     
-- 3. 필요한 정보만 추출하기
select
       extract(year from sysdate)
     , extract(month from sysdate)
     , extract(day from sysdate)
     , extract(hour from systimestamp)      -- utc 기준(세계 표준시), 우리나라 시간은 +9 해야 한다.
     , extract(minute from systimestamp)
     , extract(second from systimestamp)
     , floor(extract(second from systimestamp))
  from 
       dual;

-- 4. n개월 전후 날짜 구하기
select
       add_months(sysdate,  1)    -- 1개월 후 날짜
     , add_months(sysdate, -1)   -- 1개월 전 날짜
     , add_months(sysdate, 12)   -- 1년 후 날짜
  from 
       dual;
       
-- 5. 경과한 개월 수 구하기
select
       months_between(sysdate, to_date('22/10/07','yy-mm-dd'))
  from     
       dual;
       
-- 6. 날짜 연산
--    1) 1일(하루)을 숫자 1로 처리한다.
--    2) 12시간은 숫자 0.5로 처리한다.
--    3) 날짜는 덧셈/뺄셈이 가능하다. (며칠 전후, 경과한 일수 구하는 함수가 없다.)

select
       sysdate + 15   -- 15일 후      
     , sysdate - 15   -- 15일 전
     , sysdate - to_date('22/10/07','yy-mm-dd') -- 경과한 일수
  from  
       dual;


















