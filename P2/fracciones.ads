package Fracciones is
	type fraccion_t is private;

	function "+" (X, Y: fraccion_t) return fraccion_t;
	function "-" (X: fraccion_t) return fraccion_t;
	function "-" (X, Y: fraccion_t) return fraccion_t;
	function "*" (X, Y: fraccion_t) return fraccion_t;
	function "/" (X, Y: fraccion_t) return fraccion_t;
	function "=" (X, Y: fraccion_t) return Boolean;

	-- Operaciones de entrada/salida con la consola
	procedure Leer (F: out fraccion_t);
	procedure Escribir (F: fraccion_t);

	-- Constructor de números fraccionarios a partir de números enteros
	function "/" (X, Y: Integer) return fraccion_t;

	-- Operaciones para obtener las partes de una fracción
	function Numerador (F: fraccion_t) return Integer;
	function Denominador(F:fraccion_t) return Positive;

	--operaciones propias
	function  invertir (x:fraccion_t) return fraccion_t;
    function mcm (x,y:Integer) return Integer;
    function mcd (a,b:Integer) return Integer;
    function reducir (X:fraccion_t) return fraccion_t;



	private
		type fraccion_t is record
			Num: Integer;
			Den: Positive;
		end record;
end Fracciones;