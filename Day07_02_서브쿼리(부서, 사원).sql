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


/* select절의 서브쿼리 */


/* from절의 서브쿼리 */









