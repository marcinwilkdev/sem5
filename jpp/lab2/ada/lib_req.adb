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

  function Extended_Euclidean_Req
   (Data : Extended_Euclidean_Data) return Extended_Euclidean_Data
  is
    Quotient : Integer;
  begin
    if Data.Remainder = 0 then
      return Data;
    end if;

    Quotient := Data.Old_Remainder / Data.Remainder;

    return
     Extended_Euclidean_Req
      ((Data.Old_First_Coefficient - Quotient * Data.First_Coefficient,
        Data.Old_Second_Coefficient - Quotient * Data.Second_Coefficient,
        Data.Old_Remainder - Quotient * Data.Remainder, Data.First_Coefficient,
        Data.Second_Coefficient, Data.Remainder));
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
   (First_Number : Integer; Second_Number : Integer)
    return Extended_Euclidean_Result
  is
    Flipped                   : Boolean := False;
    Extended_Euclidean_Data_R : Extended_Euclidean_Data;
  begin
    if First_Number = 0 or Second_Number = 0 then
      return (0, 0);
    end if;

    if First_Number < Second_Number then
      Extended_Euclidean_Data_R :=
       Extended_Euclidean_Req ((0, 1, First_Number, 1, 0, Second_Number));
      return
       (Extended_Euclidean_Data_R.Old_Second_Coefficient,
        Extended_Euclidean_Data_R.Old_First_Coefficient);
    else
      Extended_Euclidean_Data_R :=
       Extended_Euclidean_Req ((0, 1, Second_Number, 1, 0, First_Number));
      return
       (Extended_Euclidean_Data_R.Old_First_Coefficient,
        Extended_Euclidean_Data_R.Old_Second_Coefficient);
    end if;

  end Extended_Euclidean;
end Lib_Req;
