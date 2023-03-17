with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body Colas is
    procedure Liberar is new Ada.Unchecked_Deallocation (Nodo, ref_Nodo);
    procedure Poner (el_Elemento : elemento_t; en_la_Cola : in out cola_t) is
        nodoaux : ref_Nodo;
    begin
        nodoaux       := new Nodo;
        nodoaux.Datos := el_Elemento;

        if Esta_Vacia (en_la_Cola) then
            en_la_Cola.ptr_Primero := nodoaux;
            nodoaux.ptr_Siguiente  := null;
            en_la_Cola.ptr_Ultimo  := nodoaux;
        else
            -- Actualizamos el ultimo para que apunte al nuevo elemento
            en_la_Cola.ptr_Ultimo.ptr_Siguiente := nodoaux;
            -- Actualizamos el nodo ultimo
            en_la_Cola.ptr_Ultimo               := nodoaux;
        end if;

    end Poner;
    procedure Quitar (un_Elemento : out elemento_t; de_la_Cola : in out cola_t)
    is
        nodoaux : ref_Nodo;
    begin
        nodoaux := new Nodo;
        if (Esta_Vacia (de_la_Cola)) then
            Put ("Error cola vacia");
        else
            nodoaux                := de_la_Cola.ptr_Primero;
            un_Elemento            := nodoaux.Datos;
            de_la_Cola.ptr_Primero := nodoaux.ptr_Siguiente;
        -- comprobamos que en el caso de que el primero sea nulo
            if de_la_Cola.ptr_Primero = null then
                de_la_Cola.ptr_Ultimo := null;
            end if;
            Liberar (nodoaux);
        end if;
    end Quitar;

    procedure Copiar (Origen : cola_t; Destino : in out cola_t) is
-- elementos auxiliares
        elemento_tirar : elemento_t;
        nodoaux        : ref_Nodo;
        Cola_aux       : cola_t;
    begin
        nodoaux := new Nodo;
--
        -- comprobamos si la  cola de destino esta vacia antes de copiarla
        while not Esta_Vacia (Destino) loop
            Quitar (elemento_tirar, Destino);
        end loop;
-- rellenamos la segunda cola utilizando las funciones de quitar y poner
        nodoaux := Origen.ptr_Primero;
        while nodoaux /= null loop
            Poner (nodoaux.Datos, Cola_aux);
            -- actuzliazmos el puntero al siguiente
            nodoaux := nodoaux.ptr_Siguiente;
        end loop;
-- para darle la vuelta a la cola lo metemos en otra cola
        nodoaux := Cola_aux.ptr_Primero;
        while nodoaux /= null loop
            Poner (nodoaux.Datos, Destino);
            -- actuzliazmos el puntero al siguiente
            nodoaux := nodoaux.ptr_Siguiente;
        end loop;
    end Copiar;

    function "=" (La_Cola, Con_La_Cola : cola_t) return Boolean is
        nodoaux_1, nodoaux_2 : ref_Nodo;
    begin
        nodoaux_1 := La_Cola.ptr_Primero;
        nodoaux_2 := Con_La_Cola.ptr_Primero;
        --recorremos ambas listas
        while nodoaux_1 /= null or nodoaux_2 /= null loop
            -- comprobamos que ambos sean distintos de null, en el caso de que sean de distinto tamanio devuelve false
            if (nodoaux_1 /= null) and (nodoaux_2 /= null) then
                if (nodoaux_1.Datos /= nodoaux_2.Datos) then
                    return False;
                end if;
            else
                return False;
            end if;
            -- aztualizar el puntero al siguiente
            nodoaux_1 := nodoaux_1.ptr_Siguiente;
            nodoaux_2 := nodoaux_2.ptr_Siguiente;
        end loop;
        return True;
    end "=";

    procedure MostrarCola (La_Cola : cola_t) is
        nodoaux : ref_Nodo;
    begin
        nodoaux := new Nodo;

        nodoaux := La_Cola.ptr_Primero;
        Put_Line ("(");
        while nodoaux /= null loop
            -- mostrar dato correspondiente
            Put (toString (nodoaux.Datos));
            -- aztualizar el puntero al siguiente
            nodoaux := nodoaux.ptr_Siguiente;
        end loop;
        Put_Line ("");
        Put_Line (")");
    end MostrarCola;

    function Esta_Vacia (La_Cola : cola_t) return Boolean is
    begin
        return (La_Cola.ptr_Primero = null);
    end Esta_Vacia;
    function Esta_Llena (La_Cola : cola_t) return Boolean is
    begin
        return (La_Cola.ptr_Primero /= null);
    end Esta_Llena;

end Colas;
