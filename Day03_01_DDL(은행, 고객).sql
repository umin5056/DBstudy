/*
    DDL (Data Definition Language, 데이터 정의어)
    0. 행(가로) 단위의 데이터를 정의한다.
    1. 데이터 베이스 객체 (user, table, sequence, view, index 등)를 생성, 수정, 삭제하는 언어
    2. 완료된 작업을 취소할 수 없다. (COMIIT 할 필요가 없다. ROLLBACK을 할 수 없다.)
    3. 종류
        1) CREATE : 생성
        2) ALTER  : 수정
        3) DROP   : 삭제
        
*/

DROP TABLE CUSTOMER_TBL;
DROP TABLE BANK_TBL;

CREATE TABLE BANK_TBL(
    BANK_CODE       VARCHAR2(20 BYTE) NOT NULL,
    BANK_NAME       VARCHAR2(30 BYTE),
    CONSTRAINT PK_BANK PRIMARY KEY(BANK_CODE)
);

CREATE TABLE CUSTOMER_TBL (
    NO              NUMBER            NOT NULL,
    NAME            VARCHAR2(30 BYTE) NOT NULL,
    PHONE           VARCHAR2(30 BYTE) UNIQUE,
    AGE             NUMBER            CHECK(AGE BETWEEN 0 AND 100),
    BANK_CODE       VARCHAR2(20 BYTE),
    CONSTRAINT PD_CUSTOMER PRIMARY KEY(NO),
    CONSTRAINT FK_CUSTOMER_BANK FOREIGN KEY(BANK_CODE) REFERENCES BANK_TBL(BANK_CODE)
);

/*
    테이블 수정하기
    1. 칼럼 추가   : ALTER TABLE 테이블명 ADD 칼럼명 데이터타입 [제약조건];
    2. 칼럼 삭제   : ALTER TABLE 테이블명 DROP COLUMN 칼럼명;
    3. 칼럼 수정   : ALTER TABLE 테이블명 MODIFY 칼럼명 데이터타입 [제약조건];
    4. 칼럼 이름   : ALTER TABLE 테이블명 RENAME COLUMN 기존칼럼명 TO 신규칼럼명;
    5. 테이블 이름 : ALTER TABLE 테이블명 RENAME TO 신규테이블명;
*/

-- 1. BANK_TBL 테이블에 연락처(BANK_TEL) 칼럼을 추가하시오.
ALTER TABLE BANK_TBL 
    ADD BANK_TEL VARCHAR2(20 BYTE) NOT NULL;
    
-- 2. CUMSTOMER_TBL 테이블에서 AGE 컬럼을 삭제하시오.
ALTER TABLE CUSTOMER_TBL
    DROP COLUMN AGE; 

-- 3. BANK_TBL 테이블의 BANK_NAME의 데이터 타입을 VARCHAR2(15BYTE)로 변경하시오.
ALTER TABLE BANK_TBL
    MODIFY BANK_NAME VARCHAR2(15 BYTE);

-- 4. CUSTOMER_TBL 테이블에서 NAME을 CUST_NAME으로 변경하시오.
ALTER TABLE CUSTOMER_TBL
    RENAME COLUMN NAME TO CUST_NAME;

-- 개인 실습.

-- 5. CUSTOMER_TBL 테이블에 GRADE 칼럼을 추가하시오.
--    GRADE 칼럼은 'VIP','GOLD','SILVER','BRONZE' 중 하나의 값만 가질 수 있도록 CHECK를 지정하시오.

ALTER TABLE CUSTOMER_TBL
    ADD GRADE VARCHAR2(6 BYTE) CHECK(GRADE IN ('VIP','GOLD','SILVER','BRONZE'));

-- 6. BANK_TBL 테이블의 BANK_NAME 칼럼에 NOT NULL 제약 조건을 추가하시오.
ALTER TABLE BANK_TBL
    MODIFY BANK_NAME VARCHAR2(15 BYTE) NOT NULL;

-- 7. CUSTOMER_TBL에 NO 칼럼을 CUST_NO로 변경하시오.
ALTER TABLE CUSTOMER_TBL
    RENAME COLUMN NO TO CUST_NO;

-- 8. CUSTOMER_TBL의 PHONE 칼럼을 삭제하시오.
ALTER TABLE CUSTOMER_TBL
    DROP COLUMN PHONE;

-- 9. CUSTOMER_TBL에 CUST_NAME 칼럼의 NOT NULL 조건을 NULL로 변경하시오.
ALTER TABLE CUSTOMER_TBL
    MODIFY CUST_NAME VARCHAR2(30 BYTE) NULL; -- NULL을 명시하지 않으면 기존 제약이 유지되므로 NULL을 반드시 적어야 함.



















