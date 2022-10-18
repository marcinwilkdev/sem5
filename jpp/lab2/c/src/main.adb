with Interfaces.C; use Interfaces.C;
with Ada.Text_IO;  use Ada.Text_IO;

procedure Main is
  function gcd (First_Number : int; Second_Number : int) return int with
   Import => True, Convention => C;
  Result : Interfaces.C.int;
begin
  Result := gcd (82, 12);
  if Result = 2 then
    Put_Line ("It works");
  end if;
end Main;
