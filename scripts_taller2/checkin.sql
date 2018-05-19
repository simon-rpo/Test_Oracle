/*
Simon Restrepo
Procedimiento que realiza el check in de los pasajeros y sus estados.
*/
CREATE OR REPLACE PROCEDURE realizar_CheckIn(
    vuelo_id IN int, 
    pasajero_id IN int, 
    tipo_Asiento IN varchar) 
IS
    vuelo int := vuelo_id;
    pasajero int := pasajero_id;
    asiento varchar(30) := tipo_Asiento;
    total_asientos int;
    total_confirmados int;
BEGIN
    
    INSERT INTO CHECK_IN (ID, PASAJERO_ID, ITINERARIO_ID, 
                          CIUDAD_ID, HORA_CHECK_IN)
    SELECT 
        id_check_in.NEXTVAL,
        P.ID,
        I.ID,
        A.CIUDAD_ID,
        sysdate
    FROM VUELOS V 
        INNER JOIN ITINERARIOS I ON V.ID = I.VUELO_ID 
        INNER JOIN PASAJEROS P ON P.ID = pasajero
        INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
        INNER JOIN AEROPUERTOS A ON A.ID = R.AEROPUERTO_ORIGEN_ID
    WHERE V.ID = vuelo;
    
    DBMS_OUTPUT.PUT_LINE('CHECK IN OK!');
    
    SELECT A.asientos_ejecutivos + A.asientos_economicos + A.asientos_estandar
    INTO total_asientos
    FROM VUELOS V 
        INNER JOIN ITINERARIOS I ON V.ID = I.VUELO_ID 
        INNER JOIN AVIONES A ON A.ID = I.AVION_ID
    WHERE V.ID = vuelo;
    
    SELECT I.PASAJEROS_ECONOMICA + i.PASAJEROS_EJECUTIVA
    INTO total_confirmados
    FROM VUELOS V 
        INNER JOIN ITINERARIOS i ON V.ID = I.VUELO_ID 
    WHERE V.ID = vuelo;
    
    IF (total_confirmados < total_asientos)
        THEN
            UPDATE ITINERARIOS 
            SET PASAJEROS_ECONOMICA = PASAJEROS_ECONOMICA + CASE WHEN asiento = 'ECONOMICA' THEN 1 ELSE 0 END,
                PASAJEROS_EJECUTIVA = PASAJEROS_EJECUTIVA + CASE WHEN asiento = 'EJECUTIVA' THEN 1 ELSE 0 END
            WHERE ID = (SELECT I.ID 
                        FROM VUELOS V 
                            INNER JOIN ITINERARIOS I ON V.ID = I.VUELO_ID 
                        WHERE V.ID = vuelo);
                        

                        
            DBMS_OUTPUT.PUT_LINE('CHECK IN STATUS OK!');
        END IF;
    
END;

/*
EXEC realizar_CheckIn(4, 6, 'ECONOMICA');
*/
