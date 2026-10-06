select *
  from bricks;

select object_type,
       count(*)
  from user_objects
 group by object_type;

select *
  from user_triggers;

desc user_source;

select text
  from user_source
 where name = 'SECURE_EMPLOYEES'
 order by line;

select text
  from user_source
 where name = 'SECURE_DML'
 order by line;

select *
  from employees;

create table employee2
   as
      select *
        from employees;

rename employee2 to employees2;

select *
  from employees2;



create or replace trigger trg_checksal before
   insert or update on employees2
   for each row
begin
   insert into trg_log ( msg ) values
      ( 'trigger fired: ' || :new.salary );
   if :new.salary <= 0 then
      raise_application_error(
         -20001,
         'Salary cannot be negative'
      );
   end if;
end;
/

drop trigger trg_checksal;

/* Formatted on 10/6/2026 11:25:04 AM (QP5 v5.423) */
CREATE OR REPLACE TRIGGER trg_compound_employees2
    FOR INSERT OR UPDATE
    ON employees2
    COMPOUND TRIGGER
    minsal   employees2.salary%TYPE DEFAULT 0;
    maxsal   employees2.salary%TYPE DEFAULT 0;

    BEFORE STATEMENT
    IS
    BEGIN
        SELECT MAX (salary), MIN (salary)
          INTO maxsal, minsal
          FROM employees2;

        DBMS_OUTPUT.put_line (
            'Max salary: ' || maxsal || ', Min salary: ' || minsal);
    --    exception
    --       when others then
    --          dbms_output.put_line('Error occurred while calculating max and min salary: ' || sqlerrm);
    END BEFORE STATEMENT;

    BEFORE EACH ROW
    IS
    BEGIN
        IF :new.salary > maxsal
        THEN
            raise_application_error (
                -20002,
                'Salary cannot exceed the maximum salary: ' || maxsal);
        END IF;

        IF :new.salary < minsal
        THEN
            raise_application_error (
                -20003,
                'Salary cannot be less than the minimum salary: ' || minsal);
        END IF;
    --    exception
    --       when others then
    --          dbms_output.put_line('Error occurred while checking salary: ' || sqlerrm);
    --          rollback;
    END BEFORE EACH ROW;

    AFTER STATEMENT
    IS
    BEGIN
        INSERT INTO trg_log (msg)
             VALUES ('trigger fired after statement');
    EXCEPTION
        WHEN OTHERS
        THEN
            DBMS_OUTPUT.put_line (
                'Error occurred in after statement: ' || SQLERRM);
    END AFTER STATEMENT;
END trg_compound_employees2;
/


delete from employees2
 where salary = 0;
commit;


insert into employees2 (
   employee_id,
   first_name,
   last_name,
   email,
   phone_number,
   hire_date,
   job_id,
   salary,
   commission_pct,
   manager_id,
   department_id
) values
   ( 99,
     'John',
     'Doe',
     'jdoe@example.com',
     '123-456-7890',
     sysdate,
     'IT_PROG',
     24500,
     null,
     101,
     60 );

update employees2
   set
   salary = 0
 where employee_id = 99;

rollback;

select *
  from user_triggers
 where trigger_name = 'TRG_CHECKSAL';

create table trg_log (
   msg varchar2(200),
   ts  timestamp default systimestamp
);

select *
  from trg_log;

select max(salary),
       min(salary)
  from employees2;

delete from trg_log
 where 1 = 1;
commit;

select *
  from employees2
 order by salary;