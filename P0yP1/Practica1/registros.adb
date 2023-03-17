with Ada.Text_IO;
use Ada.Text_IO;

procedure registros is
    type temperatura_t is delta 0.01 range -25.0 .. 75.0 ;
    type meses_t is(enero,febrero,marzo,abril,mayo,junio,julio,agosto,septiembre,octubre,noviembre,diciembre);
    type dia_t is new Integer range 1..31;
    type year_t is new Integer range 1900..2100;

    package ES_meses_t is new Ada.Text_IO.Enumeration_IO(meses_t);
    package Es_dia_t is new Ada.Text_IO.Integer_IO(dia_t);
    package Es_year_t is new Ada.Text_IO.Integer_IO(year_t);

    package Es_temperatura is new Ada.Text_IO.Fixed_IO(temperatura_t);


    package Es_int is new Ada.Text_IO.Integer_IO(Integer);
    package Es_float is new Ada.Text_IO.Float_IO(Float);

    type fecha_t is record
        dia : dia_t;
        mes : meses_t;
        year : year_t;
    end record;

    type registro_t is record
        Fecha: fecha_t;
        Temperatura: temperatura_t;
    end record;
    type arrayregistro_t  is array (integer range <>) of registro_t;
    type pregistro_t is access arrayregistro_t;
    v:pregistro_t;
    registro_tempmin:registro_t;
    registro_tempmax:registro_t;

    tempMax:temperatura_t;
    tempMin:temperatura_t;
    tempSumatorio: temperatura_t;

--funcion que pide al usuario la fecha
function introducirFecha(registro:registro_t) return registro_t is
   

    registro1:registro_t;
    begin
    registro1:=registro;
    Put_line("Introduce el dia");
    Es_dia_t.get(registro1.Fecha.dia);
    
    
    --registro1.Fecha.dia:=Integer'Value(dia);
    Put_Line("Introduce el mes");
    ES_meses_t.get(registro1.Fecha.mes);
    Put_Line("Introduce el anyo");
    Es_year_t.get(registro1.Fecha.year);
    --registro1.Fecha.year:=Integer'Value(year);
    return registro1;
end introducirFecha;
--funcion que pide al usuario la temperatura
function introducirTemperatura(registro:registro_t) return registro_t is
    registro1:registro_t;

    begin
    registro1:=registro;
    Put_Line("Introduce la temperatura");
    Es_temperatura.get(registro1.Temperatura);
    
    return registro1;
end introducirTemperatura;
--metodo que comprueba si el parametro de la izquierda es mayor que el de la derecha 
-- si es mayor devuelve 1 y si no 0, se utiliza este método para ordenar el array con bublesort
function isMayor(registro:registro_t;registro1:registro_t) return Integer is
    dia1:dia_t;
    dia2:dia_t;
    year1:year_t;
    year2:year_t;
    mes1:meses_t;
    mes2:meses_t;
    begin
    dia1:=registro.Fecha.dia;
    dia2:=registro1.Fecha.dia;
    mes1:=registro.Fecha.mes;
    mes2:=registro1.Fecha.mes;
    year1:=registro.Fecha.year;
    year2:=registro1.Fecha.year;
    Put_line("es mayor?");
    if year1>year2 then
    Put_line("Es mayor");
    Es_year_t.Put(year1);
    return 1;
    elsif year1=year2 then
    Put_line("Es igual");
        if mes1>mes2 then
            Put_line("El mes 1 es mayor");
            return 1;
        elsif mes1=mes2 then
            Put_line("El mes 1 es igual");
            if dia1>dia2 then
                Put_line("El dia 1 es mayor");
                return 1;
            else
                return 0;
            end if;
        else
            return 0;
        end if; 
    else
        return 0;
    end if;
end isMayor;

procedure Swap (v: pregistro_t;I,J:Integer)is
    temp: registro_t;
begin
    Put_Line("intercambio");
    temp:=v(I);
    v(I):=v(J);
    v(J):=temp;
end Swap;
--metodo de ordenamiento basado en bublesort
function sortArraybyDates(v:pregistro_t) return pregistro_t is
    array1:pregistro_t;
    I,J:Integer;
    begin
    array1:=v;
    J:=0;
    for J in 1..(array1'Length-1 )loop
        I:=0;
        for I in 1..J loop
     
            if (isMayor(v(I),v(I+1))=1) then
       
             Swap(v,I,J);  
            end if; 
          
           
        end loop;     
    end loop;
    
    return array1;
end sortArraybyDates;

    i:Integer;
    tamArray:Integer;
--Empieza el programa principal
begin
    i:=0;
--Pide al usuario el numero de registros que se van a utilizar.
    Put_Line("Introduzca el numero de fechas que se van guardar");
    Es_int.get(tamArray);
    v:= new arrayregistro_t(1..tamArray);

    for i in 1..tamArray loop
        v(i):=introducirFecha(v(i));
        v(i):=introducirTemperatura(v(i));
      
    end loop;




--miramos cual es la temperatura maxima
tempMax:=0.0;
tempMin:=0.0;
tempSumatorio:=0.0;

 i:=0;
--bucle que obtiene la temperatura máxima con la fecha
for i in 1..tamArray loop
    if i=1 then
        registro_tempmax:=v(i);
        registro_tempmin:=v(i);
    end if;
    tempSumatorio:=tempSumatorio+v(i).Temperatura;
    if (v(i).Temperatura )>tempMax then
        tempMax:=v(i).Temperatura;
        registro_tempmax:=v(i);
    
    end if; 
        tempMin:=v(i).Temperatura;
        registro_tempmin:=v(i);
    
end loop; 
put("datos:");
put("Temperatura max: ");
Es_temperatura.put(registro_tempmax.Temperatura);
put(" grados, alcalzada el ");
Es_dia_t.put(registro_tempmax.Fecha.dia);
put(" de ");
ES_meses_t.put(registro_tempmax.Fecha.mes);
put(" del ");
put(year_t'Image(registro_tempmax.Fecha.year));
New_Line;

--miramos cual es la temperatura minima
tempMin:=0.0;

 i:=0;
--bucle que obtiene la temperatura minima con la fecha

put("Temperatura minima: ");
Es_temperatura.put(registro_tempmin.Temperatura);
put(" grados, alcalzada el ");
Es_dia_t.put(registro_tempmin.Fecha.dia);
put(" de ");
ES_meses_t.put(registro_tempmin.Fecha.mes);
put(" del ");
put(year_t'Image(registro_tempmin.Fecha.year));
New_Line;
--ordenamos el array
v:=sortArraybyDates(v);
--comprobamos que está ordenado
Put("array ordenado");
i:=1;
New_Line;
--Es un for para comprobar el funcionamiento correcto de bublesort
for i in 1..tamArray loop
    put("Temperatura max: ");
    Es_temperatura.put(v(i).Temperatura);
    put(" grados, alcalzada el ");
    Es_dia_t.put(v(i).Fecha.dia);
    put(" de ");
    ES_meses_t.put(v(i).Fecha.mes);
    put(" del ");
    put(year_t'Image(v(i).Fecha.year));
    New_Line;
end loop; 

put("Temperatura media: ");
tempSumatorio:=tempSumatorio/tamArray;
Es_temperatura.Put(tempSumatorio);
New_Line;
New_Line;
New_Line;
--Aparatado 1.2 de la hoja de problemas
put("Ejercicios: 1.2 ");
New_Line;
put("El numero entero mas pequenio es:" );
Es_int.Put(Integer'First);
New_Line;
put("El numero entero mas grande es:" );
Es_int.Put(Integer'Last);
New_Line;
put("El numero natural mas pequenio es:" );
Es_int.Put(Natural'First);
New_Line;
put("El numero natura mas grande es:" );
Es_int.Put(Natural'Last);
New_Line;
put("El numero positivo mas pequenio es:" );
Es_int.Put(Positive'First);
New_Line;
put("El numero de digitos significativos de un numero real" );
Es_int.Put(Float'Digits);

end registros;