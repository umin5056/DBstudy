-- 학생 이름, 담당 교수 이름 조회하기.
select s.s_name, p.p_name
  from professor_tbl p inner join student_tbl s
    on p.p_no = s.p_no;
    
select s.s_name, p.p_name
  from professor_tbl p, student_tbl s
 where p.p_no = s.p_no; 
 
 -- 교수번호, 교수이름, 교수전공, 강좌이름, 강좌 위치
select p.p_no, p.p_name, p.p_major, l.l_name, l.l_location
  from professor_tbl p inner join lecture_tbl l
    on p.p_no = l.p_no;
    
-- 학번, 학생 이름, 수강신청한 과목이름, 조회하시오.
SELECT s.s_no, s.s_name, c.c_name
  FROM student_tbl s left outer JOIN enroll_tbl e
    ON s.s_no = e.s_no inner JOIN course_tbl c
    ON e.c_no = c.c_no;

SELECT s.s_no, s.s_name, c.c_name
  FROM student_tbl s, enroll_tbl e, course_tbl c
 where s.s_no = e.s_no
   AND e.c_no = c.c_no;
   
-- 모든 교수들의 교수이름, 교수전공, 강의이름을 조회하시오.
SELECT p.p_name, p.p_major, l.l_name
  FROM professor_tbl p LEFT OUTER JOIN lecture_tbl l
    ON p.p_no = l.p_no;
    
SELECT p.p_name, p.p_major, l.l_name
  FROM professor_tbl p, lecture_tbl l
 where p.p_no = l.p_no(+);
 



































