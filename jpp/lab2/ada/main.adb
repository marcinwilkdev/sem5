with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Lib;                 use Lib;
with Lib_Req;

procedure Main is
  package Mod_Int_IO is new Ada.Text_IO.Modular_IO (Mod_Int);
  use Mod_Int_IO;

  Factorial_Number     : Mod_Int;
  First_Number_R       : Integer;
  Second_Number_R      : Integer;
  Fact                 : Mod_Int;
  Gcd_Result           : Integer;
  Extended_Euclidean_R : Extended_Euclidean_Result;
begin
  Put ("Enter an factorial value: ");
  Mod_Int_IO.Get (Factorial_Number);

  Put ("Enter first integer value: ");
  Get (First_Number_R);

  Put ("Enter second integer value: ");
  Get (Second_Number_R);

  Fact                 := Factorial (Factorial_Number);
  Gcd_Result           := Gcd (First_Number_R, Second_Number_R);
  Extended_Euclidean_R := Extended_Euclidean (First_Number_R, Second_Number_R);

  Assert (112 = Factorial (5));

  Put_Line
   ("GCD: " & Integer'Image (Gcd_Result) & " Extended Euclidean: (" &
    Integer'Image (Extended_Euclidean_R.First_Number) & ", " &
    Integer'Image (Extended_Euclidean_R.Second_Number) & ") Factorial: " &
    Mod_Int'Image (Fact));
end Main;
