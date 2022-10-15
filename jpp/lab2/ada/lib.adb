package body Lib is
  function Factorial
    (N : Mod_Int) return Mod_Int is
    Fact : Mod_Int := 1;
  begin
    for I in 1..N loop
      Fact := Fact * I;
    end loop;

    return Fact;
  end Factorial;

  function Gcd
    (First_Number : Integer;
     Second_Number : Integer) return Integer is
     A : Integer;
     B : Integer;
     Tmp : Integer;
  begin
    if First_Number = 0 or Second_Number = 0
    then
      return 0;
    end if;

    if First_Number < Second_Number
    then
      A := Second_Number;
      B := First_Number;
    else
      A := First_Number;
      B := Second_Number;
    end if;

    while B /= 0 loop
      Tmp := B;
      B := A mod B;
      A := Tmp;
    end loop;

  return abs A;
  end Gcd;

  function Extended_Euclidean
    (First_Number : Integer;
     Second_Number : Integer) return Extended_Euclidean_Result is
     Tmp_Remainder : Integer;
     Tmp_First_Coefficient : Integer;
     Tmp_Second_Coefficient : Integer;
     Flipped : Boolean := False;
     First_Coefficient: Integer := 0;
     Second_Coefficient: Integer := 1;
     Remainder : Integer := Second_Number;
     Old_First_Coefficient : Integer := 1;
     Old_Second_Coefficient : Integer := 0;
     Old_Remainder : Integer := First_Number;
     Quotient : Integer;
  begin

  if First_Number < Second_Number
  then
    Tmp_Remainder := Remainder;
    Remainder := Old_Remainder;
    Old_Remainder := Remainder;
    Flipped := True;
  end if;

  while Remainder /= 0 loop
    Quotient := Old_Remainder / Remainder;

    Tmp_Remainder := Remainder;
    Remainder := Old_Remainder - Quotient * Remainder;
    Old_Remainder := Tmp_Remainder;

    Tmp_First_Coefficient := First_Coefficient;
    First_Coefficient := Old_First_Coefficient - Quotient * First_Coefficient;
    Old_First_Coefficient := Tmp_First_Coefficient;

    Tmp_Second_Coefficient := Second_Coefficient;
    Second_Coefficient := Old_Second_Coefficient - Quotient * Second_Coefficient;
    Old_Second_Coefficient := Tmp_Second_Coefficient;
  end loop;

  if Flipped
  then
    return (Old_Second_Coefficient, Old_First_Coefficient);
  else
    return (Old_First_Coefficient, Old_Second_Coefficient);
  end if;
  
  end Extended_Euclidean;
end Lib;
