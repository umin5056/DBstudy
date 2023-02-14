/*
    트리거(trigger)
    1. dml(insert, update, delete) 작업 후 자동으로 실행되는 데이터베이스 객체
    2. 행(row) 단위로 트리거가 동작한다.
    3. 종류
        1) before 트리거 : dml 동작 이전에 수행된다.
        2) after 트리거  : dml 동작 이후에 수행된다.
    4. 형식
        create [or replace] trigger 트리거명
        before | after
        insert or update or delete
        on 테이블명
        for each row
        begin
            트리거 본문
        end;
    
*/