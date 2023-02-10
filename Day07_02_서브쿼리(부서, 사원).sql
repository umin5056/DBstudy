/*
	서브쿼리(Sub Query)
	1. 메인쿼리에 포함하는 하위 쿼리를 의미한다.
	2. 일반적으로 하위쿼리는 괄호()로 묶어서 메인쿼리에 포함한다. (괄호는 필수 아님)
	3. 하위쿼리가 항상 메인쿼리보다 먼저 실행된다.
*/

/*
 	서브쿼리가 포함되는 위치에 따른 명칭
 	1. select절	: 스칼라 서브쿼리
 	2. from절	: 인라인 뷰
 	3. where절	: 서브쿼리 
 */

/*
    서브쿼리의 실행 결과에 의한 구분
    1. 단일 행 서브쿼리
    	1) 결과 행이 1개이다.
    	2) 단일 행 서브쿼리 예시
    		(1) where절에서 사용한 동등비교(=) 칼럼이 pk,unique 칼럼인 경우
    		(2) 집계함수처럼 결과가 1개의 값을 반환하는 경우
    	3) 단일 행 서브쿼리에서 사용하는 연산자
    		단일 행 연산자를 사용(=, !=, >, >=, <, <=)
    2. 다중 행 서브쿼리
    	1) 결과 행이 1개 이상이다.
    	2) from절, where절에서 많이 사용된다.
    	3) 다중 행 서브쿼리에서 사용하는 연산자
    		다중 행 연산자를 사용 : (in, any, all 등)
 */

/* where절의 서브쿼리 */
-- 1. 사원번호가 1001인 사원과 동일한 직급(position)을 가진 사원을 조회하시오.
SELECT emp_no, name, depart, gender, POSITION, hire_date, salary
  FROM employee_tbl 
 WHERE POSITION = (SELECT position
 					 FROM employee_tbl
 					WHERE emp_no = 1001);
 				
-- 2. 부서번호가 2인 부서와 동일한 지역에 있는 부서를 조회하시오.
SELECT dept_no, dept_name, location
  FROM department_tbl
 WHERE location = (SELECT location
 					 FROM department_tbl
 					WHERE dept_no = 2);

-- 3. 가장 높은 급여를 받는 사원을 조회하시오.
SELECT emp_no, name, depart, gender, POSITION, hire_date, salary  	
  FROM employee_tbl
 WHERE salary = (SELECT max(salary)
 				   FROM employee_tbl);

-- 4. 평균 급여 이상을 받는 사원을 조회하시오. 
SELECT emp_no, name, depart, gender, POSITION, hire_date, salary
  FROM employee_tbl
 WHERE salary >= (SELECT avg(salary)
  	 				FROM employee_tbl);

-- 5. 평균 근속 개월 수 이상을 근무한 사원을 조회하시오.
SELECT emp_no, name, depart, gender, POSITION, hire_date, salary
  FROM employee_tbl
 WHERE months_between(sysdate, hire_date) >= (SELECT avg(months_between(sysdate, hire_date))
 												FROM employee_tbl);

-- 6. 부서 번호가 2인 부서에 근무하는 사원들의 직급과 일치하는 사원을 조회하시오.
SELECT emp_no, name, depart, gender, POSITION, hire_date, salary
  FROM employee_tbl
 WHERE position IN (SELECT position
   					FROM employee_tbl
 				   WHERE depart = 2); -- where절에 사용된 칼럼이 pk나 unique가 아니라 '=' 대신 'in'을 사용해야함	
 				   					  -- (결과 값이 여러개이기 때문 : '='는 1개의 값만 받을 수 있다.)

-- 7. 부서명이 '영업부'인 부서에 근무하는 사원을 조회하시오.
SELECT emp_no, name, depart, gender, POSITION, hire_date, salary
  FROM employee_tbl
 WHERE depart in (SELECT dept_no
 				   FROM department_tbl
 				  WHERE dept_name = '영업부');

-- 8. 직급이 '과장'인 사원들이 근무하는 부서 정보를 조회하시오.
SELECT dept_no, dept_name, location
  FROM department_tbl
 WHERE dept_no IN (SELECT depart
					 FROM employee_tbl
					WHERE POSITION IN ('과장')); 

-- 9. '영업부'에서 가장 높은 급여보다 더 높은 급여를 받는 사원을 조회하시오.
SELECT emp_no, name, depart, gender, POSITION, hire_date, salary
  FROM employee_tbl
 WHERE salary > (SELECT max(salary)
 					FROM employee_tbl
 				   WHERE depart IN (SELECT dept_no
 				   					 FROM department_tbl
 				   					WHERE dept_name = '영업부'));

 				   				
/* select절의 서브쿼리 */ 

SELECT



/*
   인라인 뷰(Inline View)
   1. 쿼리문에 포함된 뷰(가상 테이블)이다.
   2. from절에 포한되는 서브쿼리를 의미한다.
   3. 단일 행, 다중 행 개념이 필요 없다.
   4. 인라인 뷰에 포한된 칼럼만 메인쿼리에서 사용 할 수 있다.
   5. 인라인 뷰를 이용해서 select문에 실행 순서를 조정할 수 있다.
 */

/*
   가상 칼럼
   1. pseudo column
   2. 존재하지만 저장되어 있지 않은 칼럼을 의미한다.
   3. 사용할 수 있지만 일부 사용에 제약이 있다.
   4. 종료
   		1) rowid  : 행(row) id, 어떤 행이 어디에 저장되어 있는지 알고 있는 칼럼(물리적 저장 위치)
   		2) rownum : 행(row) 번, 어떤 행의 순번
 */

-- rowid
SELECT rowid, emp_no, name
  FROM employee_tbl;

-- 오라클의 가장 빠른 검색은 rowid를 이용한 검색이다.
-- 실무에선 사용이 불가능하기 때문에 대신 인덱스(index)를 활용. 
SELECT emp_no, name
  FROM employee_tbl
 WHERE rowid = 'AAATIeAAHAAAAGjAAA';
 
/*
   rownum의 제약 사항
   1. rownum이 1을 포함하는 조건이 아니면 사용할 수 없다.
   2. 모든 rownum을 사용하려면 rownum에 별명을 지정하고 그 별명을 사용하면 된다. 
 */

-- rownum 1번 제약사항 예시
-- 가능
SELECT emp_no, name
  FROM employee_tbl
 WHERE rownum = 1;
-- 가능
SELECT emp_no, name
  FROM employee_tbl
 WHERE rownum <= 2;
-- 불가능
SELECT emp_no, name
  FROM employee_tbl
 WHERE rownum = 2;

/*
   제약 조건 2번 예시
   -- 인라인 뷰를 이용해 가장 where절보다 별명을 먼저 지정하면 된다.
   
 */
SELECT e.emp_no, e.name, e.depart
  FROM (SELECT emp_no, name, depart, rownum r
  		  FROM employee_tbl) e
 WHERE e.r = 2; 		 


/* from절의 서브쿼리 */

SELECT e.emp_no, e.name, e.depart
  FROM (SELECT emp_no, name, depart, rownum r
  		  FROM employee_tbl) e
 WHERE r =2; 		 



















