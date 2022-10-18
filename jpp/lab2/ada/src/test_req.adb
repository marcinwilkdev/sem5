with Ada.Text_IO; use Ada.Text_IO;
with Test_Lib;    use Test_Lib;
with Lib_Req;     use Lib_Req;

procedure Test_Req is
  procedure Extended_Euclidean_Test_No_Zeros
   (First_Number : Integer; Second_Number : Integer; Third_Number : Integer)
  is
    Extended_Euclidean_R : Extended_Euclidean_Result;
  begin
    Extended_Euclidean_R :=
     Extended_Euclidean (First_Number, Second_Number, Third_Number);
    Assert (Extended_Euclidean_R.Is_Result = 0);
    Assert
     (
      ((First_Number * Extended_Euclidean_R.First_Number) +
       (Second_Number * Extended_Euclidean_R.Second_Number)) =
      Third_Number);
  end Extended_Euclidean_Test_No_Zeros;
begin
  Assert (Factorial (0) = 1);
  Assert (Factorial (1) = 1);
  Assert (Factorial (5) = 120);
  Assert (Factorial (15) = 1_307_674_368_000);
  Assert (Factorial (10) = 3_628_800);

  Assert (Gcd (0, 0) = 0);
  Assert (Gcd (1, 0) = 0);
  Assert (Gcd (0, 1) = 0);
  Assert (Gcd (-52, 1) = 1);
  Assert (Gcd (1, 123) = 1);
  Assert (Gcd (147, 13) = 1);
  Assert (Gcd (-839, 60) = 1);
  Assert (Gcd (52, 13) = 13);
  Assert (Gcd (248, -94) = 2);
  Assert (Gcd (8, 6) = 2);

  Extended_Euclidean_Test_No_Zeros (82, 12, 8);
  Extended_Euclidean_Test_No_Zeros (12, 63, 12);
  Extended_Euclidean_Test_No_Zeros (8, 15, 19);
  Extended_Euclidean_Test_No_Zeros (1_234, 432, 8);
  Extended_Euclidean_Test_No_Zeros (90, 5, 25);

  Put_Line ("All tests passed");
end Test_Req;
