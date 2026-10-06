declare
   type t_employee is
      table of employee%rowtype index by pls_integer;
   v_employee t_employee;
begin
   select employee_id,
          first_name,
          last_name,
          email,
          hire_date,
          salary
   bulk collect
     into v_employee
     from employee;
   for i in 1..v_employee.count loop
      dbms_output.put_line(v_employee(i).first_name
                           || ' ' || v_employee(i).last_name);
   end loop;
   dbms_output.put_line('Total employees: ' || v_employee.count);
end;
/

