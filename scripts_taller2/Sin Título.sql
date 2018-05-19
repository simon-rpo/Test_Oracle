/*
Simon Restrepo
Procedimiento que realiza la Programacion de Tripulacion para el Vuelo.
*/
CREATE OR REPLACE PROCEDURE prog_Tripulacion(vuelo_id IN int) IS
    avion_id int;
    piloto_id int;
    copiloto_id int;
    total_asientos int;
BEGIN
    
    DECLARE
    vuelo int := vuelo_id;
    BEGIN
    
    -- Asignacion del avion       
    SELECT VP.AVION_ID
    INTO avion_id
    FROM VUELOS_PROGRESO VP --> vista
    WHERE VP.AEROPUERTO_DESTINO_ID = (SELECT R.AEROPUERTO_ORIGEN_ID 
                                      FROM VUELOS V 
                                        INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
                                      WHERE V.ID = vuelo) --> Filtrado por aeropuerto de salida                      
        AND abs( extract(HOUR FROM (VP.FECHA_ESTIMADA_LLEGADA - 
                                    (SELECT I.FECHA_ESTIMADA_salida
                                     FROM VUELOS V 
                                        INNER JOIN ITINERARIOS I ON I.VUELO_ID = V.ID
                                    WHERE V.ID = vuelo)))) <= 2 --> Filtrado por tiempo minimo para salir
        AND ROWNUM = 1;
    

    DBMS_OUTPUT.PUT_LINE(avion_id);
    
    -- Asignacion de PILOTO
    SELECT P.ID
    INTO piloto_id
    FROM EMPLEADOS E
        INNER JOIN PILOTOS P ON P.EMPLEADO_ID = E.ID
    WHERE E.ESTADO = 'ACTIVO' 
        AND P.TIPO_CARGO = 'PILOTO'
        AND E.HORAS_DESCANSO > 2
        AND E.CIUDAD_ID = (  SELECT C.ID
                             FROM VUELOS V
                                INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
                                INNER JOIN AEROPUERTOS AE ON R.AEROPUERTO_ORIGEN_ID = AE.ID
                                INNER JOIN CIUDADES C ON AE.CIUDAD_ID = C.ID
                             WHERE V.ID = vuelo)
        AND ROWNUM = 1;
        
    DBMS_OUTPUT.PUT_LINE(piloto_id);
    
    -- Asignacion de COPILOTO
    SELECT P.ID
    INTO copiloto_id
    FROM EMPLEADOS E
        INNER JOIN PILOTOS P ON P.EMPLEADO_ID = E.ID
    WHERE E.ESTADO = 'ACTIVO' 
        AND P.TIPO_CARGO = 'COPILOTO'
        AND E.HORAS_DESCANSO > 2
        AND E.CIUDAD_ID = (  SELECT C.ID
                             FROM VUELOS V
                                INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
                                INNER JOIN AEROPUERTOS AE ON R.AEROPUERTO_ORIGEN_ID = AE.ID
                                INNER JOIN CIUDADES C ON AE.CIUDAD_ID = C.ID
                             WHERE V.ID = vuelo)
        AND ROWNUM = 1;
        
    DBMS_OUTPUT.PUT_LINE(copiloto_id);
    
    --Actualizo el itinerario con el avion y pilotos...
    DECLARE
    avion_u int := avion_id;
    piloto_u int := piloto_id;
    copiloto_u int := copiloto_id;
    BEGIN
        UPDATE ITINERARIOS 
        SET AVION_ID = avion_u,
            PILOTO_ID = piloto_u,
            COPILOTO_ID = copiloto_u,
            ESTADO = 'Confirmado'
        WHERE ID = (SELECT I.ID 
                    FROM VUELOS V 
                        INNER JOIN ITINERARIOS I ON V.ID = I.VUELO_ID 
                    WHERE V.ID = vuelo);
    END;
    
    
    --Query de asientos del avion que se asigno.
    SELECT A.asientos_ejecutivos + A.asientos_economicos + A.asientos_estandar
    INTO total_asientos
    FROM AVIONES A
    WHERE A.ID = avion_id;
    
    
    DBMS_OUTPUT.PUT_LINE(total_asientos);
    
    -- Business logic por asiento y asignacion de tripulantes.
    IF total_asientos > 0 AND total_asientos <= 19 then
        
        INSERT INTO TRIPULANTE_PROGRAMACIONES (id, ITINERARIO_ID, EMPLEADO_ID)
            SELECT id_tripulante_prog.NEXTVAL, 
                (SELECT I.ID 
                 FROM VUELOS V 
                    INNER JOIN ITINERARIOS I ON V.ID = I.VUELO_ID 
                    WHERE V.ID = vuelo),
                E.ID 
        FROM EMPLEADOS E
        WHERE E.TIPO_EMPLEADO = 'Tripulante'
            AND E.ESTADO = 'ACTIVO'
            AND E.HORAS_DESCANSO > 2
--            AND E.CIUDAD_ID = (  SELECT C.ID
--                                 FROM VUELOS V
--                                    INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
--                                    INNER JOIN AEROPUERTOS AE ON R.AEROPUERTO_ORIGEN_ID = AE.ID
--                                    INNER JOIN CIUDADES C ON AE.CIUDAD_ID = C.ID
--                                 WHERE V.ID = 4)
        AND ROWNUM = 1;
    ELSIF total_asientos > 19  AND total_asientos <= 50 then

            INSERT INTO TRIPULANTE_PROGRAMACIONES (id, ITINERARIO_ID, EMPLEADO_ID)
            SELECT id_tripulante_prog.NEXTVAL, 
                (SELECT I.ID 
                 FROM VUELOS V 
                    INNER JOIN ITINERARIOS I ON V.ID = I.VUELO_ID 
                    WHERE V.ID = vuelo),
                E.ID 
            FROM EMPLEADOS E
            WHERE E.TIPO_EMPLEADO = 'Tripulante'
                AND E.ESTADO = 'ACTIVO'
                AND E.HORAS_DESCANSO > 2
    --            AND E.CIUDAD_ID = (  SELECT C.ID
    --                                 FROM VUELOS V
    --                                    INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
    --                                    INNER JOIN AEROPUERTOS AE ON R.AEROPUERTO_ORIGEN_ID = AE.ID
    --                                    INNER JOIN CIUDADES C ON AE.CIUDAD_ID = C.ID
    --                                 WHERE V.ID = 4)
            AND ROWNUM <= 1;
            
            
            INSERT INTO TRIPULANTE_PROGRAMACIONES (id, ITINERARIO_ID, EMPLEADO_ID)
            SELECT id_tripulante_prog.NEXTVAL, 
                (SELECT I.ID 
                 FROM VUELOS V 
                    INNER JOIN ITINERARIOS I ON V.ID = I.VUELO_ID 
                    WHERE V.ID = vuelo),
                E.ID 
            FROM EMPLEADOS E
            WHERE E.TIPO_EMPLEADO = 'Auxiliar de Servicio'
                AND E.ESTADO = 'ACTIVO'
                AND E.HORAS_DESCANSO > 2
    --            AND E.CIUDAD_ID = (  SELECT C.ID
    --                                 FROM VUELOS V
    --                                    INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
    --                                    INNER JOIN AEROPUERTOS AE ON R.AEROPUERTO_ORIGEN_ID = AE.ID
    --                                    INNER JOIN CIUDADES C ON AE.CIUDAD_ID = C.ID
    --                                 WHERE V.ID = 4)
            AND ROWNUM <= 2;
    ELSIF total_asientos > 50  AND total_asientos <= 180 then
    
            INSERT INTO TRIPULANTE_PROGRAMACIONES (id, ITINERARIO_ID, EMPLEADO_ID)
            SELECT id_tripulante_prog.NEXTVAL, 
                (SELECT I.ID 
                 FROM VUELOS V 
                    INNER JOIN ITINERARIOS I ON V.ID = I.VUELO_ID 
                    WHERE V.ID = vuelo),
                E.ID
            FROM EMPLEADOS E
            WHERE E.TIPO_EMPLEADO = 'Tripulante'
                AND E.ESTADO = 'ACTIVO'
                AND E.HORAS_DESCANSO > 2
    --            AND E.CIUDAD_ID = (  SELECT C.ID
    --                                 FROM VUELOS V
    --                                    INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
    --                                    INNER JOIN AEROPUERTOS AE ON R.AEROPUERTO_ORIGEN_ID = AE.ID
    --                                    INNER JOIN CIUDADES C ON AE.CIUDAD_ID = C.ID
    --                                 WHERE V.ID = 4)
            AND ROWNUM <= (total_asientos / 50);
            
            
            INSERT INTO TRIPULANTE_PROGRAMACIONES (id, ITINERARIO_ID, EMPLEADO_ID)
            SELECT id_tripulante_prog.NEXTVAL, 
                (SELECT I.ID 
                 FROM VUELOS V 
                    INNER JOIN ITINERARIOS I ON V.ID = I.VUELO_ID 
                    WHERE V.ID = vuelo),
                E.ID 
            FROM EMPLEADOS E
            WHERE E.TIPO_EMPLEADO = 'Auxiliar de Servicio'
                AND E.ESTADO = 'ACTIVO'
                AND E.HORAS_DESCANSO > 2
    --            AND E.CIUDAD_ID = (  SELECT C.ID
    --                                 FROM VUELOS V
    --                                    INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
    --                                    INNER JOIN AEROPUERTOS AE ON R.AEROPUERTO_ORIGEN_ID = AE.ID
    --                                    INNER JOIN CIUDADES C ON AE.CIUDAD_ID = C.ID
    --                                 WHERE V.ID = 4)
            AND ROWNUM <= 4;
    ELSE 

            INSERT INTO TRIPULANTE_PROGRAMACIONES (id, ITINERARIO_ID, EMPLEADO_ID)
            SELECT id_tripulante_prog.NEXTVAL, 
                (SELECT I.ID 
                 FROM VUELOS V 
                    INNER JOIN ITINERARIOS I ON V.ID = I.VUELO_ID 
                    WHERE V.ID = vuelo),
                E.ID 
            FROM EMPLEADOS E
            WHERE E.TIPO_EMPLEADO = 'Tripulante'
                AND E.ESTADO = 'ACTIVO'
                AND E.HORAS_DESCANSO > 2
    --            AND E.CIUDAD_ID = (  SELECT C.ID
    --                                 FROM VUELOS V
    --                                    INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
    --                                    INNER JOIN AEROPUERTOS AE ON R.AEROPUERTO_ORIGEN_ID = AE.ID
    --                                    INNER JOIN CIUDADES C ON AE.CIUDAD_ID = C.ID
    --                                 WHERE V.ID = 4)
            AND ROWNUM <= (total_asientos / 50);
            
            
            INSERT INTO TRIPULANTE_PROGRAMACIONES (id, ITINERARIO_ID, EMPLEADO_ID)
            SELECT id_tripulante_prog.NEXTVAL, 
                (SELECT I.ID 
                 FROM VUELOS V 
                    INNER JOIN ITINERARIOS I ON V.ID = I.VUELO_ID 
                    WHERE V.ID = vuelo),
                E.ID 
            FROM EMPLEADOS E
            WHERE E.TIPO_EMPLEADO = 'Auxiliar de Servicio'
                AND E.ESTADO = 'ACTIVO'
                AND E.HORAS_DESCANSO > 2
    --            AND E.CIUDAD_ID = (  SELECT C.ID
    --                                 FROM VUELOS V
    --                                    INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
    --                                    INNER JOIN AEROPUERTOS AE ON R.AEROPUERTO_ORIGEN_ID = AE.ID
    --                                    INNER JOIN CIUDADES C ON AE.CIUDAD_ID = C.ID
    --                                 WHERE V.ID = 4)
            AND ROWNUM <= (SELECT CASE WHEN R.DURACION_PROMEDIO >= 6 THEN 19 ELSE 18 END
                           FROM VUELOS V
                                INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
                           WHERE V.ID = 4);
    END IF;
    
    END;    
END;

/*   
exec prog_Tripulacion (4)
*/
    
    