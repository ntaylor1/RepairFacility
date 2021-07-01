generic
   max: integer;
   type Item is private;
package stack is

   procedure pushT(x: in Item);
   procedure pushS(x: in Item);
   procedure popT(x: out Item);
   procedure popS(x: out Item);
   function peekT return Item;
   function peekS return Item;
   function SpaceAvailable return Boolean;
   function StarAvailable return Boolean;
   function TieAvailable return Boolean;
end stack;
