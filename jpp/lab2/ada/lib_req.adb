package body Lib_Req is
  function Factorial_Req (N : Mod_Int; Fac : Mod_Int) return Mod_Int is
  begin
    if N = 0 then
      return Fac;
    end if;

    return Factorial_Req (N - 1, N * Fac);
  end Factorial_Req;

  function Gcd_Req
   (First_Number : Integer; Second_Number : Integer) return Integer
  is
  begin
    if Second_Number = 0 then
      return First_Number;
    end if;

    return Gcd_Req (Second_Number, First_Number rem Second_Number);
  end Gcd_Req;

  type Extended_Euclidean_Data is record
    First_Coefficient      : Integer;
    Second_Coefficient     : Integer;
    Remainder              : Integer;
    Old_First_Coefficient  : Integer;
    Old_Second_Coefficient : Integer;
    Old_Remainder          : Integer;
  end record;

  procedure Extended_Euclidean_Req
   (Extended_Euclidean_Data_R : in out Extended_Euclidean_Data)
  is
    Tmp_Remainder          : Integer;
    Tmp_First_Coefficient  : Integer;
    Tmp_Second_Coefficient : Integer;
    Quotient               : Integer;
  begin
    if Extended_Euclidean_Data_R.Remainder = 0 then
      return;
    end if;

    Quotient :=
     Extended_Euclidean_Data_R.Old_Remainder /
     Extended_Euclidean_Data_R.Remainder;

    Tmp_Remainder                       := Extended_Euclidean_Data_R.Remainder;
    Extended_Euclidean_Data_R.Remainder :=
     Extended_Euclidean_Data_R.Old_Remainder -
     Quotient * Extended_Euclidean_Data_R.Remainder;
    Extended_Euclidean_Data_R.Old_Remainder := Tmp_Remainder;

    Tmp_First_Coefficient := Extended_Euclidean_Data_R.First_Coefficient;
    Extended_Euclidean_Data_R.First_Coefficient :=
     Extended_Euclidean_Data_R.Old_First_Coefficient -
     Quotient * Extended_Euclidean_Data_R.First_Coefficient;
    Extended_Euclidean_Data_R.Old_First_Coefficient := Tmp_First_Coefficient;

    Tmp_Second_Coefficient := Extended_Euclidean_Data_R.Second_Coefficient;
    Extended_Euclidean_Data_R.Second_Coefficient :=
     Extended_Euclidean_Data_R.Old_Second_Coefficient -
     Quotient * Extended_Euclidean_Data_R.Second_Coefficient;
    Extended_Euclidean_Data_R.Old_Second_Coefficient := Tmp_Second_Coefficient;

    Extended_Euclidean_Req (Extended_Euclidean_Data_R);
  end Extended_Euclidean_Req;

  function Factorial (N : Mod_Int) return Mod_Int is
  begin
    return Factorial_Req (N, 1);
  end Factorial;

  function Gcd (First_Number : Integer; Second_Number : Integer) return Integer
  is
  begin
    if First_Number = 0 or Second_Number = 0 then
      return 0;
    end if;

    if First_Number < Second_Number then
      return Gcd_Req (Second_Number, First_Number);
    else
      return Gcd_Req (First_Number, Second_Number);
    end if;
  end Gcd;

  function Extended_Euclidean
   (First_Number :    Integer; Second_Number : Integer; Third_Number : Integer;
    Result       : in out Pair) return Integer
  is
    Tmp_Number                : Integer;
    First_Number_Copy         : Integer := First_Number;
    Second_Number_Copy        : Integer := Second_Number;
    Gcd_Result                : Integer;
    Multiplier                : Integer;
    Flipped                   : Boolean := False;
    Extended_Euclidean_Data_R : Extended_Euclidean_Data;
  begin

    if First_Number_Copy = 0 or Second_Number_Copy = 0 then
      Result := (0, 0);
      return -1;
    end if;

    if First_Number_Copy < Second_Number_Copy then
      Tmp_Number    := First_Number_Copy;
      First_Number_Copy  := Second_Number_Copy;
      Second_Number_Copy := Tmp_Number;

      Flipped := True;
    end if;

    Gcd_Result := Gcd (First_Number_Copy, Second_Number_Copy);

    if Third_Number rem Gcd_Result /= 0 then
      Result := (0, 0);
      return -1;
    end if;

    Multiplier := Third_Number / Gcd_Result;

    Extended_Euclidean_Data_R := (0, 1, Second_Number_Copy, 1, 0, First_Number_Copy);

    Extended_Euclidean_Req (Extended_Euclidean_Data_R);

    Extended_Euclidean_Data_R.Old_First_Coefficient :=
     Extended_Euclidean_Data_R.Old_First_Coefficient * Multiplier;
    Extended_Euclidean_Data_R.Old_Second_Coefficient :=
     Extended_Euclidean_Data_R.Old_Second_Coefficient * Multiplier;

    if Flipped then
      Result :=
       (Extended_Euclidean_Data_R.Old_Second_Coefficient,
        Extended_Euclidean_Data_R.Old_First_Coefficient);
      return 0;
    else
      Result :=
       (Extended_Euclidean_Data_R.Old_First_Coefficient,
        Extended_Euclidean_Data_R.Old_Second_Coefficient);
      return 0;
    end if;

  end Extended_Euclidean;
end Lib_Req;
