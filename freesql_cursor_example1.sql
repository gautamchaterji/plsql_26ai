declare
   cursor c_country (
      p_code hr.countries.country_id%type
   ) is
   select country_id,
          country_name
     from hr.countries
    where country_id = p_code;
   c_id   hr.countries.country_id%type;
   c_name hr.countries.country_name%type;
begin
   open c_country('SG');
   loop
      fetch c_country into
         c_id,
         c_name;
      exit when c_country%notfound;
      dbms_output.put_line(c_id
                           || '-->' || c_name);
   end loop;
   close c_country;
end;
/
declare
   cursor c1 (
      c_code hr.countries.country_id%type
   ) is
   select *
     from hr.countries
    where country_id = c_code;
   c_countries hr.countries%rowtype;
begin
   open c1('CN');
   loop
      fetch c1 into c_countries;
      exit when c1%notfound;
      dbms_output.put_line(c_countries.country_id
                           || '-->' || c_countries.country_name);
   end loop;
   close c1;
end;
/

CREATE OR REPLACE PROCEDURE PROC_TEST (
    P_SHAPE BRICKS.SHAPE%TYPE
) IS

    CURSOR C_BRICKS_1 (
        P_SHAPE BRICKS.SHAPE%TYPE
    ) IS
    SELECT
        BRICK_ID,
        COLOUR,
        SHAPE,
        WEIGHT
    FROM
        BRICKS
    WHERE
        SHAPE = P_SHAPE;

    TYPE T_BRICKS IS
        TABLE OF BRICKS%ROWTYPE;
    V_BRICKS T_BRICKS;
    V_LIMIT  PLS_INTEGER DEFAULT 2;
BEGIN
    OPEN C_BRICKS_1(P_SHAPE);
    LOOP
        FETCH C_BRICKS_1
        BULK COLLECT INTO V_BRICKS LIMIT V_LIMIT;
        DBMS_OUTPUT.PUT_LINE(V_BRICKS.COUNT);
        EXIT WHEN V_BRICKS.COUNT = 0;
        FOR I IN 1..V_BRICKS.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(V_BRICKS(I).BRICK_ID
                                 || '-->' || V_BRICKS(I).WEIGHT);
        END LOOP;

    END LOOP;

    forall i in 1..V_BRICKS.COUNT
        DBMS_OUTPUT.PUT_LINE(V_BRICKS(i).BRICK_ID
                                 || '-->' || V_BRICKS(i).WEIGHT);

    CLOSE C_BRICKS_1;
END PROC_TEST;
/

CREATE OR REPLACE PROCEDURE PROC_TEST (
    P_SHAPE BRICKS.SHAPE%TYPE
) IS

    CURSOR C_BRICKS_1 (
        P_SHAPE BRICKS.SHAPE%TYPE
    ) IS
    SELECT
        BRICK_ID,
        COLOUR,
        SHAPE,
        WEIGHT
    FROM
        BRICKS
    WHERE
        SHAPE = P_SHAPE;

    TYPE T_BRICKS IS
        TABLE OF BRICKS%ROWTYPE;
    V_BRICKS T_BRICKS;
    V_LIMIT  PLS_INTEGER DEFAULT 2;
BEGIN
    OPEN C_BRICKS_1(P_SHAPE);
    LOOP
        FETCH C_BRICKS_1
        BULK COLLECT INTO V_BRICKS LIMIT V_LIMIT;
        DBMS_OUTPUT.PUT_LINE(V_BRICKS.COUNT);
        EXIT WHEN V_BRICKS.COUNT = 0;
    END LOOP;

    forall i in 1..V_BRICKS.COUNT
        DBMS_OUTPUT.PUT_LINE(V_BRICKS(i).BRICK_ID
                                 || '-->' || V_BRICKS(i).WEIGHT);

    CLOSE C_BRICKS_1;
END PROC_TEST;
/

begin
    proc_test('cube');
end;
/

select * from bricks;