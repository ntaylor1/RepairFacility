with Ada.Text_IO; use Ada.Text_IO;
package body stack is


--max: integer; -- Declare the stack
s: array(1..max) of Item;
TTop: integer range 0..max; 
STop: integer range 0..21;    

         
procedure pushT(x:in Item) is
   begin 
      if TTop < (STop - 1) then
        TTop:= TTop + 1; s(TTop):= x;
      end if;
        
    
end pushT;
procedure popT(x: out Item) is
begin
      if TTop = 0 then 
         put("Underflow");
      else
         x := s(TTop); TTop := TTop - 1; 
      end if;
      
      
   end popT;       
procedure pushS(x: in Item) is
   begin
      if STop > (TTop + 1) then
        STop := STop - 1; s(STop) := x;
      end if;
      
   end pushS;
procedure popS(x: out Item) is
   begin
      if STop > max then
        put("Underflow"); new_line(2);
      else
         x := s(STop); STop := STop + 1; 
      end if;
      
    end popS;
          
function peekT return Item is
   i: Item;  
   begin
      
      i := s(TTop);
      return i;
   end peekT;   
function peekS return Item is
   i: Item;  
   begin
      
      i := s(STop);
      return i;
   end peekS;    
function SpaceAvailable return Boolean is
   begin
   if (STop - TTop) > 1 then
      return True;
   else
      return False;
   end if;
   end SpaceAvailable;
function TieAvailable return Boolean is
   begin
      if TTop > 0 then
         return True;
      else
         return False;
      end if;
   end TieAvailable;
function StarAvailable return Boolean is
   begin
      if STop < 21 then
         return True;
      else
         return False;
      end if;
   end StarAvailable;
    
begin
   TTop:=0; STop:= 21;
end stack;
