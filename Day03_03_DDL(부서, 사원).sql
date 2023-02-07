/*
    DML (Data Manipulation Language - 데이터 조작어)
    1. 데이터(행, Row)를 삽입, 수정, 삭제할 때 사용하는 언어이다.
    2. DML 사용 후에는 TRANSACTION(COMMIT 또는 ROLLBACK) 처리를 해야 한다.
    3. 종류
        1) 삽입 : INSERT INTO 테이블명(컬럼1,컬럼2,컬럼3,...) VALUES(값1,값2,값3,...)
        2) 수정 : UPDATE 테이블명 SET 수정할 내용(컬럼 = 변경내용) WHERE 변경할 컬럼(컬럼 = 컬럼값);
        3) 삭제 : DELETE FROM 테이블명 WHERE 삭제할 컬럼(컬럼 = 컬럼값);
*/

-- 참고. 자격증에서는 DML을 INSERT, UPDATE, DELETE + SELECT로 보는 경우도 있다.

DROP TABLE EMPLOYEE_TBL;
DROP TABLE DEPARTMENT_TBL;

CREATE TABLE DEPARTMENT_TBL (
    DEPT_NO         NUMBER              NOT NULL,
    DEPT_NAME       VARCHAR2(15 BYTE)   NOT NULL,
    LOCATION        VARCHAR2(15 BYTE)   NOT NULL,
    CONSTRAINT PK_DEPT PRIMARY KEY(DEPT_NO)
);

CREATE TABLE EMPLOYEE_TBL (
    EMP_NO          NUMBER              NOT NULL,
    NAME            VARCHAR2(20 BYTE)   NOT NULL,
    DEPART          NUMBER              NULL,
    POSITION        VARCHAR2(20 BYTE)   NULL,
    GENDER          CHAR(2 BYTE)        NULL,
    HIRE_DATE       DATE                NULL,
    SALARY          NUMBER              NULL,
    CONSTRAINT PK_EMP PRIMARY KEY(EMP_NO),
    CONSTRAINT FK_DEPT FOREIGN KEY(DEPART) REFERENCES DEPARTMENT_TBL(DEPT_NO) ON DELETE SET NULL
);

-- 시퀀스(번호생성시) 삭제
DROP SEQUENCE DEPARTMENT_SEQ;

-- 시퀀스(번호생성기) 만들기
CREATE SEQUENCE DEPARTMENT_SEQ
    INCREMENT BY 1  -- 1씩 증가하는 번호를 생성(생략 가능)
    START WITH 1    -- 1부터 번호를 생성(생략 가능)
    NOMAXVALUE      -- 번호의 상한선 없음(생략 가능) MAXVALUE 100 : 번호의 최댓값이 100
    NOMINVALUE      -- 번호의 하한선 없음(생략 가능) MINVALUE 100 : 번호의 최솟값이 100
    NOCYCLE         -- 번호 순환이 없음(생략 가능)   CYCLE : 번호가 MAXVALUE에 도달하면 다음 번호는 MINVALUE
    NOCACHE         -- 메모리 캐시를 사용안함        CACHE : 메모리 캐시를 사용 (미사용 권장) : 번호를 미리 뽑아둬서 다음 출력에 문제가 생길 수 있음
    ORDER           -- 번호 건너뛰기 안함            
;
-- 시퀀스에서 번호 뽑는 함수 : NEXTVAL
--SELECT DEPARTMENT_SEQ.NEXTVAL FROM DUAL; -- 테이블에 없는 데이터를 조회하려면 DUAL 테이블을 사용한다.

-- 데이터 입력하기(Parent Key를 먼저 입력해야 한다.)
/*
INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME) VALUES(2, '인사부');
ㄴ칼럼명을 적어주는 경우는 데이터를 삽입하지 않을 칼럼이 있는 경우에 사용(현재 LOCATION 안적음)
*/
INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME,LOCATION) VALUES(DEPARTMENT_SEQ.NEXTVAL,'영업부','대구');
INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME,LOCATION) VALUES(DEPARTMENT_SEQ.NEXTVAL,'인사부','서울');
INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME,LOCATION) VALUES(DEPARTMENT_SEQ.NEXTVAL,'총무부','대구');
INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME,LOCATION) VALUES(DEPARTMENT_SEQ.NEXTVAL,'기획부','서울');
COMMIT;


DROP SEQUENCE EMPLOYEE_SEQ;
CREATE SEQUENCE EMPLOYEE_SEQ
    START WITH 1001
    NOCACHE;
    
INSERT INTO EMPLOYEE_TBL VALUES(EMPLOYEE_SEQ.NEXTVAL, '구창민', 1, '과장', 'M', '95-05-01', 5000000);
INSERT INTO EMPLOYEE_TBL VALUES(EMPLOYEE_SEQ.NEXTVAL, '김민서', 1, '사원', 'M', '17-09-01', 2500000);
INSERT INTO EMPLOYEE_TBL VALUES(EMPLOYEE_SEQ.NEXTVAL, '이은영', 2, '부장', 'F', '90-09-01', 5500000);
INSERT INTO EMPLOYEE_TBL VALUES(EMPLOYEE_SEQ.NEXTVAL, '한성일', 2, '과장', 'M', '93-04-01', 5000000);
COMMIT;

-- 데이터 수정하기
-- 1. 부서번호(DEPT_NO)가 1인 부서의 지역(LOCATION)을 '경기'로 수정하시오.
UPDATE DEPARTMENT_TBL
   SET LOCATION = '경기' -- 수정할 내용 ('='는 대입 연산자)
 WHERE DEPT_NO = 1;      -- 조건문 ('='는 비교 연산자)
COMMIT;

-- 2. 부서번호(DEPART)가 1인 부서의 근무하는 사원들의 급여를 50만원 인상시키시오
UPDATE EMPLOYEE_TBL
   SET SALARY = SALARY + 500000
 WHERE DEPART = 1 AND POSITION = '사원';   
COMMIT;

-- 데이터 삭제하기
-- 1. 지역(LOCATION)이 '대구'인 부서를 삭제하시오.
DELETE FROM DEPARTMENT_TBL WHERE LOCATION = '대구';
COMMIT;
-- 2. 지역(LOCATION)이 '서울'인 부서를 삭제하시오.
DELETE FROM DEPARTMENT_TBL WHERE LOCATION = '서울'; -- 외래키 옵션(ON DELETE SET NULL)으로 인해 사원의 부서번호는 null로 처리된다.
COMMIT;

















