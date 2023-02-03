/*
    KEY 제약조건
    1. 기본키(PK : Primary Key)
        1) 개체 무결성
        2) PK는 NOT NULL + UNIQUE해야 한다.
    2. 외래키(FK : Forign Key)
        1) 참조 무결성
        2) FK는 참조하는 값만 가질 수 있다.
        
*/

/* 
    일대다(1:M) 관계
    1. PK와 FK를 가진 테이블 간의 관계이다.
        1) 부모 테이블 : 1, PK를 가진 테이블
        2) 자식 테이블 : M, FK를 가진 테이블
    2. 생성과 삭제 규칙
        1) 생성 규칙 : 반드시 부모 테이블을 먼저 생성한다.
        2) 삭제 규칙 : 반드시 자식 테이블을 먼저 삭제한다.
*/

-- 테이블 삭제
DROP TABLE PROD_TBL;

DROP TABLE ORDER_TBL; -- 삭제는 자식테이블 먼저 삭제해야한다.
DROP TABLE PRODUCT_TBL;

-- 제품 테이블(부모 테이블)
CREATE TABLE PRODUCT_TBL (
    PROD_NO NUMBER NOT NULL, -- KEY의 이름을 지정하는 법 : CONSTRAINT "이름" PRIMATY KEY
    PROD_NAME VARCHAR2(10 BYTE),
    PROD_PRICE NUMBER,
    PROD_STOCK NUMBER,
    CONSTRAINT PK_PROD PRIMARY KEY(PROD_NO) -- PK의 이름을 지정하는 법2
);

-- 주문 테이블(자식 테이블)
CREATE TABLE ORDER_TBL (
    ORDER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(10 BYTE),
    PROD_NO NUMBER, -- FK 지정하는 법 : REFERENCES "테이블명(칼럼명)"
    ORDER_DATE DATE,
    CONSTRAINT PK_ORDER PRIMARY KEY(ORDER_NO),
    CONSTRAINT FK_ORDER_PROD FOREIGN KEY(PROD_NO) REFERENCES PRODUCT_TBL(PROD_NO) -- FK를 지정하는 법2
    
);

/*
    제약조건 테이블
    1. SYS, SYSTEM 관리 계정으로 접속해서 확인한다.
    2. 종류
        1) ALL_CONSTRAINTS
        2) USER_CONSTRAINTS
        3) DBA_CONSTRAINTS
*/

-- 테이블 구조를 확인하는 쿼리 (설명)
DESCRIBE USER_CONSTRAINTS;

SELECT * FROM ALL_CONSTRAINTS WHERE CONSTRAINT_NAME LIKE 'FK%';

SELECT * FROM ALL_TABLES WHERE OWNER = 'GDJ61';

































