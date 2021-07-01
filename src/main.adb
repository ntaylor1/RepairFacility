-- main.adb
with Ada.Text_IO;
use Ada.Text_IO;
with stack;
with ada.Calendar;
with ada.strings.unbounded;
use ada.strings.unbounded;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with randfloat; use randfloat;

procedure Main is

 use ada.Calendar;
 package FloatIO is new Ada.Text_IO.Float_IO(float);
 use FloatIO;
 package Int_IO is new Ada.Text_IO.Integer_IO(integer);
 use Int_IO;


   type MaintenanceRecord is tagged record
     Vtype: Unbounded_String;
     Vname: Unbounded_String;
     RepairTime: Duration;
     StartTime: Ada.Calendar.Time;
     FinishTime: Ada.Calendar.Time;
   end record;
   m: MaintenanceRecord;
   subtype LastCharOfName is Character range 'A'..'Z';

  package RecStack is new stack(20,MaintenanceRecord); use RecStack;

  function NumberNewArrivals return Integer is
   randNum: float;
   begin
      randNum := next_float; -- 0.0 <= randNumm <= 1.0.
      if randNum <= 0.25 then
         return 1;
      elsif randNum <= 0.5 then
         return 2;
      elsif
        randNum <= 0.75 then
         return 3;
      else
         return 4;
      end if;
   end NumberNewArrivals;


  procedure Report(x: in MaintenanceRecord) is
   begin
      put("Type: "); put(To_String(x.Vtype)); put(" Name: "); put(To_String(x.Vname)); new_line(2);
   end Report;
   numberArrivals: Integer;



   knt : integer := 0;

   Start_Time : Ada.Calendar.Time;
   Next_Cycle : Ada.Calendar.Time;
   Period : constant Duration := 5.5;

   Seconds: constant Duration := 1.0;
   Minutes: constant Duration := 60.0;
   Hours: constant Duration := 3600.0;
   r: float;
   k: MaintenanceRecord;
   tknt : integer := 0;
   sknt : integer := 0;
   LastCharStar: LastCharOfName;
   LastCharTie: LastCharOfName;
   charString : Unbounded_String;
   SpaceAvail : Boolean;
   StarAvail: Boolean;
   TieAvail: Boolean;
begin

   LastCharStar := 'A';
   LastCharTie := 'A';

   Start_Time := Ada.Calendar.Clock;
   Next_Cycle := Start_Time;


   put("The start time is: "); Ada.Text_IO.Put_Line(Duration'Image(next_Cycle - Start_Time));  new_line;
   put("Initial 3 Vehicles: "); new_line;
   for x in 1..3 loop
      r := next_float;
      if r >= 0.75 then
         m.Vtype := To_Unbounded_String("Star Destroyer");
         m.Vname := To_Unbounded_String("Star");
         m.RepairTime := 7.0;
         append(m.Vname,LastCharStar);
         m.StartTime := Ada.Calendar.Clock;


         pushS(m);
         Report(m);
         if LastCharStar = 'Z' then
            LastCharStar := 'A';
         else
            LastCharStar := LastCharOfName'SUCC(LastCharStar);
         end if;


      else
         m.Vtype := To_Unbounded_String("Tie Fighter");
         m.VName := To_Unbounded_String("Tie");
         m.RepairTime := 3.0;
         append(m.Vname,LastCharTie);
         m.StartTime := Ada.Calendar.Clock;
         pushT(m);
         Report(m);
         if LastCharTie = 'Z' then
            LastCharTie := 'A';
         else
            LastCharTie := LastCharOfName'SUCC(LastCharTie);
         end if;

      end if;

   end loop;

   while knt < 5 loop
   numberArrivals := NumberNewArrivals;
   put("The number of new arrivals is "); put(numberArrivals); new_line(2);

   for x in 1..numberArrivals loop
         if knt = 5 then exit;
            end if;
      SpaceAvail := SpaceAvailable;

      r:= randfloat.next_float;
       if r >= 0.75 then
         m.Vtype := To_Unbounded_String("Star Destroyer");
         m.Vname := To_Unbounded_String("Star");
         m.RepairTime := 7.0;
         append(m.VName, LastCharStar);
         if LastCharStar = 'Z' then
            LastCharStar := 'A';
         else
            LastCharStar := LastCharOfName'SUCC(LastCharStar);

         end if;

         if SpaceAvail = True then
            m.StartTime := Clock;
            pushS(m);
            put(To_String(m.Vname)); put(" has entered the facility at: "); put(Duration'Image(Clock - Start_Time)); put("s"); new_line(2);
         else
            put(To_String(m.Vname)); put(" has been rejected and sent to the Dagaba system at: "); put(Duration'Image(Clock - Start_Time)); put("s"); new_line(2);
            knt := knt + 1;
         end if;

      else
         m.Vtype := To_Unbounded_String("Tie Fighter");
         m.VName := To_Unbounded_String("Tie");

         m.RepairTime := 3.0;
         append(m.VName, LastCharTie);
         if LastCharTie = 'Z' then
               LastCharTie := 'A';


         else
            LastCharTie := LastCharOfName'SUCC(LastCharTie);
         end if;
         if SpaceAvail = True then
            m.StartTime := Clock;
            pushT(m);
            put(To_String(m.Vname)); put(" has entered the facility at: "); put(Duration'Image(Clock - Start_Time)); put("s"); new_line(2);
         else
            put(To_String(m.Vname)); put(" has been rejected and sent to the Dagaba system at: "); put(Duration'Image(Clock - Start_Time)); put("s"); new_line(2);
            knt := knt + 1;
         end if;


         end if;
      end loop;

      if knt = 5 then exit;
            end if;
      TieAvail := TieAvailable;
      StarAvail := StarAvailable;
      if StarAvail = True then
         delay 7.0;
         k := peekS;
         k.FinishTime := Clock;
         put(To_String(k.Vname)); put(" has been repaired at "); put(Duration'Image(Clock - Start_Time));
         put("s"); new_line(2);
         popS(k);
         sknt := sknt + 1;

      elsif TieAvail = True then
         delay 3.0;
         k := peekT;
         k.FinishTime := Clock;
         put(To_String(k.Vname)); put(" has been repaired at "); put(Duration'Image(Clock - Start_Time));
         put("s"); new_line(2);
         popT(k);
         tknt := tknt + 1;
      else
         put("No vehicles to repair");

         end if;
      delay 2.0;

     end loop;

   put("Star Destroyers repaired: "); put(Integer'Image(sknt)); new_line;
   put("Tie Fighters repaired: "); put(Integer'Image(tknt)); new_line;
   put("Total Vehicles repaired: "); put(Integer'Image(sknt + tknt));

end Main;
