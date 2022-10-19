package body Lib is
  function Factorial (N : Mod_Int) return Mod_Int is
    Fact : Mod_Int := 1;
  begin
    for I in 1 .. N loop
      Fact := Fact * I;
    end loop;

    return Fact;
  end Factorial;

  function Gcd (First_Number : Integer; Second_Number : Integer) return Integer
  is
    A   : Integer;
    B   : Integer;
    Tmp : Integer;
  begin
    if First_Number = 0 or Second_Number = 0 then
      return 0;
    end if;

    if First_Number < Second_Number then
      A := Second_Number;
      B := First_Number;
    else
      A := First_Number;
      B := Second_Number;
    end if;

    while B /= 0 loop
      Tmp := B;
      B   := A rem B;
      A   := Tmp;
    end loop;

    return abs A;
  end Gcd;

  function Extended_Euclidean
   (First_Number :    Integer; Second_Number : Integer; Third_Number : Integer;
    Result       : in out Pair) return Integer
  is
    Gcd_Result             : Integer;
    Multiplier             : Integer;
    Tmp_Remainder          : Integer;
    Tmp_First_Coefficient  : Integer;
    Tmp_Second_Coefficient : Integer;
    Flipped                : Boolean := False;
    First_Coefficient      : Integer := 0;
    Second_Coefficient     : Integer := 1;
    Remainder              : Integer := Second_Number;
    Old_First_Coefficient  : Integer := 1;
    Old_Second_Coefficient : Integer := 0;
    Old_Remainder          : Integer := First_Number;
    Quotient               : Integer;
  begin

    if First_Number = 0 or Second_Number = 0 then
      Result := (0, 0);
      return -1;
    end if;

    if First_Number < Second_Number then
      Tmp_Remainder := Remainder;
      Remainder     := Old_Remainder;
      Old_Remainder := Tmp_Remainder;
      Flipped       := True;
    end if;

    Gcd_Result := Gcd (First_Number, Second_Number);

    if Third_Number rem Gcd_Result /= 0 then
      Result := (0, 0);
      return -1;
    end if;

    Multiplier := Third_Number / Gcd_Result;

    while Remainder /= 0 loop
      Quotient := Old_Remainder / Remainder;

      Tmp_Remainder := Remainder;
      Remainder     := Old_Remainder - Quotient * Remainder;
      Old_Remainder := Tmp_Remainder;

      Tmp_First_Coefficient := First_Coefficient;
      First_Coefficient     :=
       Old_First_Coefficient - Quotient * First_Coefficient;
      Old_First_Coefficient := Tmp_First_Coefficient;

      Tmp_Second_Coefficient := Second_Coefficient;
      Second_Coefficient     :=
       Old_Second_Coefficient - Quotient * Second_Coefficient;
      Old_Second_Coefficient := Tmp_Second_Coefficient;
    end loop;

    Old_First_Coefficient  := Old_First_Coefficient * Multiplier;
    Old_Second_Coefficient := Old_Second_Coefficient * Multiplier;

    if Flipped then
      Result := (Old_Second_Coefficient, Old_First_Coefficient);
      return 0;
    else
      Result := (Old_First_Coefficient, Old_Second_Coefficient);
      return 0;
    end if;

  end Extended_Euclidean;
end Lib;
