with Ada.Text_Io, Ada.Real_Time, Calefactor, Sensor, Horno;
use Ada.Text_Io, Ada.Real_Time;
procedure medir1 is
    TempEx, TempInterna_ant, TempInterna : Sensor.Temperaturas;
    potencia                             : Calefactor.Potencias:=1000.0;
    Tiempo_ini, Tiempo_fin               : Time;
    Tiempo_L                             : Time_Span := Milliseconds (5);
    Periodo : constant Time_Span:=Milliseconds (1000);
    Proximo_Periodo                      : Time      := Clock;
begin
    Put_Line ("La temperatura  interna es de ");
    Sensor.Leer (TempInterna);
    Put_Line (Sensor.Temperaturas'Image (TempInterna));

    Sensor.Leer (TempEx);-- leemos la temperatura exterior
    Put_Line ("La temperatura  externa es de ");
    Put_Line (Sensor.Temperaturas'Image (TempEx));
    Tiempo_ini := Clock;
    Tiempo_fin := Tiempo_ini;
    Calefactor.Escribir (potencia);
    --se declara un while para ver en que momento cambia la temperatura
    while Float (TempEx) = Float (TempInterna) loop
        Tiempo_fin := Clock;
        Sensor.Leer (TempInterna);-- leemos la temperatura exterior
    end loop;
    --queremos sacar cp para eso vamos hacer un while que compruebe el crecimiento de la temperatura hasta que deje de crecer
    TempInterna_ant:=TempEx;
    while Float(TempInterna_ant) /= Float(TempInterna) loop
        Sensor.Leer (TempInterna_ant);
        --incremeto de tiempo dt es de 50 milisegundos
        Proximo_Periodo := Proximo_Periodo + Periodo;
        delay until Proximo_Periodo;
        --leemos la temperatura actua y comprobamos
        Sensor.Leer (TempInterna);
    end loop;
    -- mostramos L  para eso hay que sumarlo en una variable Duration
    Put_Line ("(L ) el retardo en la respuesta ");
    Tiempo_L := Tiempo_fin - Tiempo_ini;
    Put_Line (Duration'Image (Ada.Real_Time.To_Duration (Tiempo_L)));
    Put_Line ("La temperatura  interna es de ");
    Put_Line (Sensor.Temperaturas'Image (TempInterna));
    Calefactor.Escribir (0.0);
end medir1;
