/*
Simon Restrepo
Procedimiento que realiza el check in de los pasajeros y sus estados.
*/
CREATE OR REPLACE PROCEDURE realizar_CheckIn(
    vuelo_id IN int, 
    pasajero_id IN int, 
    tipo_Asiento IN varchar) 
IS
    avion_id int;
    piloto_id int;
    copiloto_id int;
    total_asientos int;
BEGIN
    
    SELECT * FROM pasajeros
    select * from check_in
END;