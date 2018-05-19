CREATE SEQUENCE id_empleado
INCREMENT BY 1 
START WITH 1 MINVALUE 1;

CREATE SEQUENCE id_piloto
INCREMENT BY 1 
START WITH 1 MINVALUE 1;

CREATE SEQUENCE id_ciudad
INCREMENT BY 1 
START WITH 2 MINVALUE 1;



CREATE SEQUENCE id_itinerario
INCREMENT BY 1 
START WITH 1 MINVALUE 1;


CREATE SEQUENCE id_tripulante_prog
INCREMENT BY 1 
START WITH 1 MINVALUE 1;

CREATE SEQUENCE id_aeropuerto
INCREMENT BY 1 
START WITH 1 MINVALUE 1;


CREATE SEQUENCE id_ruta
INCREMENT BY 1 
START WITH 1 MINVALUE 1;

CREATE SEQUENCE id_vuelo
INCREMENT BY 1 
START WITH 1 MINVALUE 1;


CREATE SEQUENCE id_check_in
INCREMENT BY 1 
START WITH 1 MINVALUE 1;

CREATE SEQUENCE id_pasajero
INCREMENT BY 1 
START WITH 1 MINVALUE 1;

CREATE SEQUENCE id_avion
INCREMENT BY 1 
START WITH 1 MINVALUE 1;

CREATE SEQUENCE id_log_vuelo
INCREMENT BY 1 
START WITH 1 MINVALUE 1;


-- Adecuaciones del modelo
ALTER TABLE AVIONES
ADD ESTADO VARCHAR(15);

ALTER TABLE AVIONES
ADD CONSTRAINT CK_AVIONES_ESTADO 
CHECK (ESTADO in('Vuelo', 'Tierra', 'Mantenimiento', 'Reparación'));

ALTER TABLE ITINERARIOS
ADD CONSTRAINT CK_ITINERARIOS_ESTADO 
CHECK (ESTADO in('En Vuelo', 'Cancelado', 'Retrasado', 'Confirmado', 'Abordando', 'Programado'));

/*
1) Se desea asignar un avión a un vuelo confirmado, para esto es 
necesario una vista que dado el id de
un vuelo confirmado, busque los aviones que se encuentran en el 
aeropuerto de salida (Utilizando la
hora estimada de llegada a esa ciudad / aeropuerto de otros vuelos) 2 horas antes 
de la fecha estimada de salida. (0.3)
*/


SELECT a.id 
FROM AVIONES A
    CROSS JOIN VUELOS V
WHERE A.ESTADO = 'Tierra'
    AND A.ID NOT IN (SELECT I.AVION_ID
                 FROM ITINERARIOS I
                    INNER JOIN AVIONES A ON A.ID = I.AVION_ID 
                    INNER JOIN VUELOS V ON V.ID = I.VUELO_ID
                    INNER JOIN RUTAS R ON R.ID = V.RUTA_ID)
    AND rowNUM = 1;


/*
INSERT INTO AVIONES(id,matricula,serial,edad,asientos_ejecutivos,asientos_economicos,asientos_estandar)VALUES(id_avion.NEXTVAL,'N764AV','Airbus A320-251N	7887',0,12,138,0);
INSERT INTO AVIONES(id,matricula,serial,edad,asientos_ejecutivos,asientos_economicos,asientos_estandar)VALUES(id_avion.NEXTVAL,'N765AV','Airbus A320-251N	7928',0,12,138,0);
INSERT INTO AVIONES(id,matricula,serial,edad,asientos_ejecutivos,asientos_economicos,asientos_estandar)VALUES(id_avion.NEXTVAL,'N766AV','Airbus A320-251N	8096',0,12,138,0);
INSERT INTO AVIONES(id,matricula,serial,edad,asientos_ejecutivos,asientos_economicos,asientos_estandar)VALUES(id_avion.NEXTVAL,'PR-OBD','Airbus A320-251N	7175',1,12,138,0);
INSERT INTO AVIONES(id,matricula,serial,edad,asientos_ejecutivos,asientos_economicos,asientos_estandar)VALUES(id_avion.NEXTVAL,'PR-OBF','Airbus A320-251N	7323',1,12,138,0);
INSERT INTO AVIONES(id,matricula,serial,edad,asientos_ejecutivos,asientos_economicos,asientos_estandar)VALUES(id_avion.NEXTVAL,'PR-OBH','Airbus A320-251N	7484',1,12,138,0);
INSERT INTO AVIONES(id,matricula,serial,edad,asientos_ejecutivos,asientos_economicos,asientos_estandar)VALUES(id_avion.NEXTVAL,'PR-OBI','Airbus A320-251N	7514',1,12,138,0);
INSERT INTO AVIONES(id,matricula,serial,edad,asientos_ejecutivos,asientos_economicos,asientos_estandar)VALUES(id_avion.NEXTVAL,'PR-OBJ','Airbus A320-251N	7698',0,12,138,0);

INSERT INTO AVIONES VALUES(id_avion.NEXTVAL,'N764AV','Airbus A320-251N	7887',0,'Boeing 737',12,138,0,'Tierra');
INSERT INTO AVIONES VALUES(id_avion.NEXTVAL,'N765AV','Airbus A320-251N	7928',0,'Boeing 737',12,138,0,'Tierra');
INSERT INTO AVIONES VALUES(id_avion.NEXTVAL,'N766AV','Airbus A320-251N	8096',0,'Boeing 737',12,138,0,'Tierra');
INSERT INTO AVIONES VALUES(id_avion.NEXTVAL,'PR-OBD','Airbus A320-251N	7175',1,'Boeing 737',12,138,0,'Tierra');
INSERT INTO AVIONES VALUES(id_avion.NEXTVAL,'PR-OBF','Airbus A320-251N	7323',1,'Boeing 737',12,138,0,'Tierra');
INSERT INTO AVIONES VALUES(id_avion.NEXTVAL,'PR-OBH','Airbus A320-251N	7484',1,'Boeing 737',12,138,0,'Tierra');
INSERT INTO AVIONES VALUES(id_avion.NEXTVAL,'PR-OBI','Airbus A320-251N	7514',1,'Boeing 737',12,138,0,'Tierra');
INSERT INTO AVIONES VALUES(id_avion.NEXTVAL,'PR-OBJ','Airbus A320-251N	7698',0,'Boeing 737',12,138,0,'Tierra');


SELECT *
FROM ITINERARIOS I
    LEFT  JOIN AVIONES A ON A.ID = I.AVION_ID
    INNER JOIN VUELOS V ON V.ID = I.VUELO_ID
    INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
WHERE R.AEROPUERTO_DESTINO_ID = ( SELECT R.AEROPUERTO_ORIGEN_ID
                                  FROM ITINERARIOS I
                                    INNER JOIN VUELOS V ON V.ID = I.VUELO_ID
                                    INNER JOIN RUTAS R ON R.ID = V.RUTA_ID)
    
    
select
    24 * (to_date(to_char(sysdate, 'YYYY-MM-DD hh24:mi'), 'YYYY-MM-DD hh24:mi') - to_date('2018-02- 15:20', 'YYYY-MM-DD hh24:mi')) as diff_hours
from dual;    


    INSERT INTO CIUDADES VALUES (id_ciudad.NEXTVAL, 'MEDELLIN','COLOMBIA');
    INSERT INTO ciudades (id,ciudad,pais) VALUES (id_ciudad.NEXTVAL,'BOGOTA','COLOMBIA');
    
select * from ciudades
select * from AEROPUERTOS
 
    INSERT INTO AEROPUERTOS VALUES (id_aeropuerto.NEXTVAL,'Jose Maria Cordova International Airport','MDE',6.170763,-75.42762, 1);
    INSERT INTO AEROPUERTOS VALUES (id_aeropuerto.NEXTVAL,'El Dorado International Airport','BOG',4.701413 ,-74.144497, 2);
    SELECT * FROM vuelos
    INSERT INTO RUTAS VALUES (id_ruta.NEXTVAL,1,2,427,0.5);
INSERT INTO vuelos  VALUES (id_vuelo.NEXTVAL,'AV17',2,2); 
INSERT INTO vuelos  VALUES (id_vuelo.NEXTVAL,'AV8427',3,2);  
INSERT INTO vuelos  VALUES (id_vuelo.NEXTVAL,'AV8433',4,2);  


insert into ITINERARIOS values (id_itinerario.NEXTVAL, SYSDATE, '15/05/2018',null,'Confirmado',0,0,null,'15/05/2018',null,null,4,null,null);
    
    SELECT * FROM ITINERARIOS
    
    */
    
    -- AVION
    SELECT A.* 
    FROM AVIONES A
    WHERE A.ESTADO = 'Tierra'
        AND A.ID NOT IN (SELECT I.AVION_ID
                         FROM ITINERARIOS I
                            INNER JOIN AVIONES A ON A.ID = I.AVION_ID 
                            INNER JOIN VUELOS V ON V.ID = I.VUELO_ID
                            INNER JOIN RUTAS R ON R.ID = V.RUTA_ID)
        AND rownum = 1;
    
    
    -- PILOTO
    SELECT P.ID
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
                             WHERE V.ID = 4)
        AND ROWNUM = 1;
    
    -- COPILOTO
    SELECT P.ID
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
                             WHERE V.ID = 4)
        AND ROWNUM = 1;
        
        
        SELECT *
		FROM EMPLEADOS E 
		WHERE E.TIPO_EMPLEADO = 'Tripulante'
            AND E.ESTADO = 'ACTIVO'
            AND E.HORAS_DESCANSO >= 2;