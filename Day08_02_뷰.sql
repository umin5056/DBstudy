/*
    뷰(view)
    1. 테이블이나 뷰를 이용해서 만들어 낸 가상 테이블이다.
    2. 쿼리문 자체를 저장하고 있다.
    3. 자주 사용하는 복잡한 쿼리문이 있다면 이를 뷰를 만들어두고 편하게 호출한다.
    4. 뷰로 인한 성능상의 이점은 없다.    
*/

-- 뷰 만들기
create view view_tmp
    as (select e.emp_no, e.name, e.depart, d.dept_name, e.gender, e.position, e.hire_date, e.salary
          from department_tbl d inner join employee_tbl e
            on d.dept_no = e.depart);
            
-- 뷰 조회하기
select * from view_tmp;

-- 뷰 삭제하기
drop view view_tmp;