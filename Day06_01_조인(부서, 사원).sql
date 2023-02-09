/*
    드라이브(drive) 테이블과 드리븐(driven) 테이블
    1. 드라이브(drive) 테이블
        1) 조인 관계를 처리하는 메인 테이블
        2) 1:m 관계에서 1에 해당하는 테이블
        3) 행(row)의 개수가 일반적으로 적고, pk를 조인 조건으로 사용하기 때문에 인덱스(index) 활용이 가능하다.
    2. 드리븐(driven) 테이블
        1) 1:m 관계에서 m에 해당하는 테이블
        2) 행(row)의 개수가 일반적으로 많고, fk를 조인 조건으로 사용하기 때문에 인덱스(index) 활용이 불가능하다.
    3. 조인 성능 향상을 위해서 가급적 드라이브(drive) 테이블을 먼저 작성하고, 드리븐(driven) 테이블은 나중에 작성한다.
        
*/



select e.emp_no, e.name, d.dept_no, d.dept_name
  from department_tbl d inner join employee_tbl e
    on d.dept_no = e.depart;

select e.emp_no, e.name, d.dept_no, d.dept_name
  from department_tbl d, employee_tbl e
 where d.dept_no = e.depart; 