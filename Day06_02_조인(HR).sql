/*
    셀프 조인
    1. 하나의 테이블에 pk와 fk가 모두 있는 경우에 사용되는 조인이다.
    2. 동일한 테이블을 조인하기 때문에 별명을 다르게 지정해서 조인한다.
    3. 문법은 기본적으로 내부 조인과 동일하다.
*/

-- 모든 사원들의 employee_id, first_name, last_name, manager의 first_name을 조회하시오.

-- 1:m 관계 파악
-- pk           fk
-- employee_id  manager_id

-- 조인 조건 파악
-- 사원테이블 E        -  매니저테이블 M
-- 사원들의 매니저번호 -  매니저의 사원번호

-- 스티븐 출력안됨 
select 
       e.employee_id, e.first_name, e.last_name -- 각 사원들의 정보
     , m.first_name                             -- 매니저 정보 
  from 
       employees e inner join employees m       
    on      
       e.manager_id = m.employee_id
 order by 
       e.employee_id;
       
  -- 스티븐 출력됨
select 
       e.employee_id, e.first_name, e.last_name -- 각 사원들의 정보
     , m.first_name                             -- 매니저 정보 
  from 
       employees e left outer join employees m
    on
       e.manager_id = m.employee_id
 order by 
       e.employee_id;
         
-- 셀프 조인 연습
-- 각 사원 중에서 매니저보다 먼저 입사한 사원을 조회하시오.
select
       e.employee_id, e.first_name, e.hire_date as 입사일
     , m.employee_id, m.first_name, m.hire_date as 매니저입사일
  from 
       employees e inner join employees m
    on e.manager_id = m. employee_id
 where 
       to_date(e.hire_date, 'yy/mm/dd') < to_date(m.hire_date, 'yy/mm/dd')
 order by 
       e.employee_id;
       
-- pk, fk가 아닌 일반 칼럼을 이용한 셀프 조인

-- 동일한 부서에서 근무하는 사원들을 조인하기 위해 department_id로 조인조건을 생성.

-- 사원 (나)        사원 (남)
-- employees me     employees you

-- 문제. 같은 부서에서 근무하는 사원 중에서 나보다 salary가 높은 사원을 조회하시오.
select 
       me.employee_id, me.first_name, me.salary as 내급여
     , you.first_name, you.salary as 너급여
     , me.department_id, you.department_id
  from 
       employees me inner join employees you
    on 
       me.department_id = you.department_id
 where me.salary < you.salary
 order by
       me.employee_id;  



























