with Ada.Text_IO;
use Ada.Text_IO;

package  body Fracciones is



--operaciones definidas en el paquete    
	function "+" (X, Y: fraccion_t) return fraccion_t is
	resultado: fraccion_t;
	begin
		resultado := (X.Num*Y.Den+Y.Num*X.Den)/(X.Den*Y.Den);
		return (reducir(resultado));
	end "+";

	function "-" (X, Y: fraccion_t) return fraccion_t is 
    resultado: fraccion_t;
    begin
        
        resultado:=X+(-Y);
        return resultado;
    end "-";
  function "-" (X: fraccion_t) return fraccion_t is 
    resultado: fraccion_t;
    begin 
    resultado:=(-X.Num)/(X.Den);
    return resultado;
  end "-";

	function "*" (X, Y: fraccion_t) return fraccion_t is 
    resultado: fraccion_t;
    numerador,denominador:Integer;
    begin
        numerador:=x.Num*y.Num;
        denominador:=x.Den*y.Den;

        resultado:=numerador/denominador;

        resultado:=reducir(resultado);

        return resultado;
    end "*";


	function "/" (X, Y: fraccion_t) return fraccion_t is 
    resultado: fraccion_t;
    begin
        resultado:=x*(invertir(y));
        return reducir(resultado);
    end "/";
    --constructor de fracciones
	function "/" (X, Y: Integer) return fraccion_t is 
    resultado: fraccion_t;
    begin
        if  x=0 then
        resultado.Num:=1;
        resultado.Den:=1; 
        
        elsif y<0 then
        resultado.Num:=-X;
        resultado.Den:=y*(-1);
        else 
        resultado.Num:=X;
        resultado.Den:=y;   
        end if;
  
        return resultado;
    end "/";

	function "=" (X, Y: fraccion_t) return Boolean is
	begin
		if((X.Num*Y.Den) = (X.Den*Y.Num)) then
			return True;
		else
			return False;
		end if;
	end "=";
    --operaciones definidas para uso propio
    -- maximo comun divisor
    function mcd (a,b:Integer) return Integer is
    begin
        if b=0 then
            return a;
        else
            return mcd(b, a mod b);
        end if;
    end mcd;
    -- minimo comun multiplo
    function mcm (x,y:Integer) return Integer is
    resultado: Integer;
    begin
        resultado:= x*y/mcd(x,y);
        return resultado;
    end mcm;
    -- invierte una funcion util para la division
	function  invertir (x:fraccion_t) return fraccion_t is 
        resultado: fraccion_t;
        begin
        --comprobar signo
        if x.Num<=0 then

            resultado:=(-x.Den)/(-x.Num);
        else
            resultado:=(x.Den)/x.Num;
        end if;
            resultado:=reducir(resultado);
            return resultado;
    end invertir;

    function reducir (X:fraccion_t) return fraccion_t is
    resultado : fraccion_t;
    numeradorA,denominadorA: Integer;
    begin 
        numeradorA:=x.Num/mcd(x.Num,x.Den);
        denominadorA:=x.Den/mcd(x.Num,x.Den);
        resultado:=numeradorA/denominadorA;
        return resultado;
    end reducir;
 

	-- Operaciones de entrada/salida con la consola
	procedure Leer (F: out fraccion_t) is
	package ES_int is new Ada.Text_Io.Integer_Io(Integer);
	Num, Den:Integer;
    resultado: fraccion_t;
	begin
		Put_Line("Introduzca Numerador: ");
		Es_int.Get(Num); 
		Put_Line("Introduzca Denominador: ");
		Es_int.Get(Den);
        F.Den:=Den;
        F.Num:=Num;
        resultado:=reducir(F);
        F:=resultado;
	end Leer;

	procedure Escribir (F: fraccion_t) is
    resultado:fraccion_t;
	begin
        resultado:=reducir(F);
		Put(Integer'Image(Numerador(resultado)) & "/" & Positive'Image(Denominador(resultado)));
		New_line(1);
	end Escribir;

	-- Operaciones para obtener las partes de una fracción
	function Numerador (F: fraccion_t) return Integer is
	resultado: fraccion_t;
	begin
		resultado:=reducir(F);
		return resultado.Num;
	end Numerador;

   	function Denominador(F: fraccion_t) return Positive is
	resultado: fraccion_t;
	begin
        resultado:=reducir(F);
		return resultado.Den;
	end Denominador;


end Fracciones;
