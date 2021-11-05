

--java_procedure 연결 사용
--[결과]
--2^3 = 8
--a_exponent가 음수이면 값을 0으로 변경하고 1을 반환

create or replace PROCEDURE compute_power (
    a_num      IN NUMBER,
    a_exponent IN OUT NUMBER,
    a_power    OUT NUMBER
) 
IS 
BEGIN
	IF 
	(a_exponent < 0)
	THEN
	a_exponent := 0;
	END IF;

a_power := 1;

FOR i IN 1..a_exponent LOOP
    a_power := a_power * a_num;
END LOOP;

end;