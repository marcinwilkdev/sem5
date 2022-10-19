package Lib_Req is
  type Mod_Int is mod 2**64;

  type Pair is record
    First_Number  : Integer;
    Second_Number : Integer;
  end record with
   Convention => C;

  function Factorial (N : Mod_Int) return Mod_Int with
   Export => True, Convention => C, External_Name => "factorial";

  function Gcd
   (First_Number : Integer; Second_Number : Integer) return Integer with
   Export => True, Convention => C, External_Name => "gcd";

  function Extended_Euclidean
   (First_Number :    Integer; Second_Number : Integer; Third_Number : Integer;
    Result       : in out Pair) return Integer with
   Export => True, Convention => C, External_Name => "extendedEuclidean";
end Lib_Req;
