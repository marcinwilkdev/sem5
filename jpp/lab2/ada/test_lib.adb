package body Test_Lib is
  procedure Assert (Assertion : Boolean) is
  begin
    if not Assertion then
      raise Program_Error with "Assertion failed";
    end if;
  end Assert;
end Test_Lib;
