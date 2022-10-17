package Lib_Req is
  type Mod_Int is mod 2**64;

  type Extended_Euclidean_Result is record
    First_Number  : Integer;
    Second_Number : Integer;
  end record;

  function Factorial (N : Mod_Int) return Mod_Int;

  function Gcd
   (First_Number : Integer; Second_Number : Integer) return Integer;

  function Extended_Euclidean
   (First_Number : Integer; Second_Number : Integer)
    return Extended_Euclidean_Result;
end Lib_Req;
