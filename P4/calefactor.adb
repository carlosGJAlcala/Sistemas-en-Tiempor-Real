with Ada.Real_Time,Horno; use Ada.Real_Time;
package body Calefactor is
    procedure Escribir (la_Potencia: Potencias)is
    miPotencia:Horno.Potencias;
    begin
    miPotencia:=Horno.Potencias(la_Potencia);
    Horno.Escribir(miPotencia);
    end Escribir;
 
end Calefactor;