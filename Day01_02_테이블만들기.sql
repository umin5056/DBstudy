/*
    테이블
    1. 데이터베이스의 가장 대표적인 객체이다.
    2. 데이터를 보관하는 객체이다.
    3. 표 형식으로 데이터를 보관한다.
    4. 테이블 기본 용어
        1) 열 : column, 속성(attribute), 필드(field)
        2) 행 : row,    개체(entity),    레코드(record)
*/    

/*
    오라클의 데이터 타입
    1. CHAR(size)     : 고정 길이 문자 타입(size : 1 ~ 2000byte까지 가능)
    2. VARCHAR2(size) : 가변 길이 문자 타입(size : 1 ~ 4000byte까지 가능)
    3. DATE           : 날짜/시간 타입
    4. TIMESTAMP      : 날짜/시간 타입(DATE보다 좀 더 정밀한 타입)
    5. NUMBER(p,s)    : 정밀도(p), 스케일(s)로 표현하는 숫자 타입   
        1) 정밀도 : 정수부와 소수부를 모두 포함하는 전체 유효 숫자가 몇 개인가?
        2) 스케일 : 소수부의 전체 유효 숫자가 몇 개인가?
        예시)
            (1) NUMBER      : 최대 38자리 숫자(22byte)
            (2) NUMBER(3)   : 정수부가 최대 3자리인 숫자(최대 999)
            (3) NUMBER(5,2) : 최대 전체 5자리, 소수부 2자리인 숫자(ex 123.45)
            (4) NUMBER(2,2) : 1미만의 소수부 두자리 실수(ex 0.15) - 정수부의 0은 유효 자리가 아님
*/

/*
    제약조건(Constraint)
    1. 널
        1) NULL 또는 생략
        2) NOT NULL
        
    2. 중복 데이터 방지    
        1) UNIQUE
        
    3. 값의 제한
        1) CHECK
        
    4. 기본키 (Primary Key)
        1) NOT NULL + UNIQUE를 기본으로 포함한다. (개체 무결성)
            (학번, 군번, 주민번호 등등)
        2) 기본키는 테이블당 1개만 가질 수 있다.    
    
    5. 외래키 (Foreign Key) : 다른 테이블에 있는 기본키를 참조한다.
        1) 기본키를 참조하지만 NOT NULL, UNIQUE 등의 제약 조건은 일체 없다.
           (ex. 게시물에 들어간 여러개의 이미지는 같은 게시물 번호를 갖는다.)
        2) 참조하는 기본키의 값만 가질 수 있다. (참조 무결성)
        3) 기본키 1개와 그 값을 참조한 외래키들의 관계는 "1 : M" 관계라고 부른다.
        4) "M : M" 관계
          - 상    품 : 기본키 (1,2)
          - 회    원 : 기본키 (a,b)
                      두 테이블 사이에 "주문 내역"이라는 "새로운 테이블"을 작성해야 한다.
          - 주문 내역 : (1,a) (2,a)
                      (1,b) (2,b)  세로는 상품 외래키, 가로는 회원 외래키   
                    위와 같은 "1 : M" 관계를 여러개 가진 테이블 : 1,2,a,b를 담은 외래키들(1:M)을 묶는다(?)
        
*/

-- 예시 테이블
DROP TABLE PRODUCT;

CREATE TABLE PRODUCT(
    CODE         VARCHAR2(2 BYTE)   NOT NULL UNIQUE, 
    MODEL        VARCHAR2(10 BYTE)  NULL,
    CATEGORY     VARCHAR2(5 BYTE)   CHECK(CATEGORY = 'MAIN' OR CATEGORY = 'SUB'), -- == CHECK(CATEGORY IN('MAIN','SUB'))
    PRICE        NUMBER             CHECK(PRICE >= 0),
    AMOUNT       NUMBER(2)          CHECK(0 <= AMOUNT AND AMOUNT <=100),          -- == CHECK(AMOUNT BETWEEN 0 AND 100)
    MANUFACTURED DATE
);






















