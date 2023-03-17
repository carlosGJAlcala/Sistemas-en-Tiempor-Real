with Ada.Real_Time; use Ada.Real_Time;
with Horno;
package body Sensor is
    procedure Leer (la_Temperatura: out Temperaturas) is
    miTemperatura: Horno.Temperaturas;
    begin
    miTemperatura:=0.0;
        Horno.Leer(miTemperatura);
    la_Temperatura:=Temperaturas(miTemperatura);
    end Leer;
end Sensor;