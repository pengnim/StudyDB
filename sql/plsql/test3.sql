 set SERVEROUTPUT ON
DECLARE
-- 테이블 타입 정의
   type ename_table_type is table of  emp.ename%TYPE
   index by BINARY_INTEGER;
   type job_table_type is table of  emp.job%TYPE
   index by BINARY_INTEGER;

-- 변수 정의
   ename_table  ename_table_type;
   job_table job_table_type;
   i BINARY_INTEGER := 0;
BEGIN
    -- emp에서 사원이름과 직급 얻어오기
    for k in(select ename,job from emp) loop
        i := i+1;
        ename_table(i) := k.ename;
        job_table(i) := k.job;
    end loop;

   for j in  1..i loop
       --DBMS_OUTPUT.PUT_LINE(ename_table(j)||' / '||job_table(j));
       DBMS_OUTPUT.PUT_LINE(RPAD(ename_table(j),12)||' / '|| LPAD(job_table(j), 9));
   end loop; 

END;