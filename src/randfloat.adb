with ada.Calendar; use ada.calendar;
Package body Randfloat is

 x: integer := 9531;  -- seed
 function next_float return float is
 n : integer;
 begin


 x := x*29+37;
 n := x;
 x := x mod 1001;
 return float(n mod 101) / 100.0;
 end next_float;
end Randfloat;
