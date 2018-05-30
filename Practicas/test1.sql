/*
Simon Restrepo
    1. Distinct values & table.
*/

CREATE TABLE distinct_numbers (
  value integer NOT NULL
);

CREATE TYPE arreglo IS VARRAY(100000) OF integer;

CREATE OR REPLACE FUNCTION distinct_values(datos IN arreglo) 
RETURN INT 
IS 
    TYPE t_tab IS TABLE OF NUMBER;
    l_tab1 t_tab := t_tab();
BEGIN
    
    l_tab1.EXTEND(datos.COUNT);
    
    FOR i IN 1 .. datos.COUNT 
    LOOP 
        l_tab1(i) := datos (i);
    END LOOP;
        
    l_tab1 := l_tab1 MULTISET INTERSECT DISTINCT l_tab1;
      
    RETURN l_tab1.COUNT;
END;

CREATE OR REPLACE PROCEDURE table_distinct_values(datosArray IN arreglo) 
IS
    TYPE t_tab IS TABLE OF NUMBER;
    l_tab1 t_tab := t_tab();
BEGIN

    DECLARE
    datos arreglo := datosArray;
    BEGIN
    
    -- DML De la tabla distinct 
    l_tab1.EXTEND(datos.COUNT);
    
    
    FOR i IN 1 .. datos.COUNT 
    LOOP 
        l_tab1(i) := datos (i);
    END LOOP;
        
        
    l_tab1 := l_tab1 MULTISET INTERSECT DISTINCT l_tab1;
    
    -- Borro la tabla 
    DELETE FROM distinct_numbers;
    
    
    FOR i IN l_tab1.first .. l_tab1.last
    LOOP
        -- Inserto en tabla
       INSERT INTO  distinct_numbers values (l_tab1(i));
       -- DBMS_OUTPUT.put_line('Distinct values are '||l_tab1(i));
    END LOOP;
    
    end;

END;



DECLARE
  numbers arreglo;
begin
    numbers := arreglo(2,1,1,2,3,1);
    dbms_output.put_line(distinct_values(numbers));
end;


EXEC table_distinct_values (arreglo(2,1,1,2,3,1));
SELECT * FROM distinct_numbers;
