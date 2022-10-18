package Lib_Req is
  type Mod_Int is mod 2**64;

  type Extended_Euclidean_Result is record
    Is_Result     : Integer;
    First_Number  : Integer;
    Second_Number : Integer;
  end record;

  function Factorial (N : Mod_Int) return Mod_Int with
   Export => True, Convention => C, External_Name => "factorial_req";

  function Gcd
   (First_Number : Integer; Second_Number : Integer) return Integer with
   Export => True, Convention => C, External_Name => "gcd_req";

  function Extended_Euclidean
   (First_Number : Integer; Second_Number : Integer; Third_Number : Integer)
    return Extended_Euclidean_Result with
   Export => True, Convention => C, External_Name => "extended_euclidean_req";
end Lib_Req;
