declare
   type t_currency is
      table of varchar2(3) index by pls_integer;
   v_currency t_currency;
begin
   v_currency(1) := 'USD';
   v_currency(2) := 'EUR';
   v_currency(3) := 'JPY';
   for i in 1..v_currency.count loop
      dbms_output.put_line(v_currency(i));
   end loop;

end;



