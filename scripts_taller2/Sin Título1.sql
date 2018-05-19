/*
Simon Restrepo
Vista que trae la informacion basica de los vuelos en progreso.
*/
CREATE OR REPLACE VIEW Vuelos_Progreso
AS
SELECT 
    i.id itinerario_id,
    fecha_estimada_salida,
    fecha_real_salida,
    fecha_estimada_llegada,
    fecha_real_llegada,
    i.estado,
    R.AEROPUERTO_DESTINO_ID,
    R.AEROPUERTO_ORIGEN_ID,
    i.AVION_ID
FROM ITINERARIOS I
    INNER JOIN VUELOS V ON V.ID = I.VUELO_ID
    INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
ORDER BY fecha_estimada_llegada DESC;
    
    
    
    
    
    /*
    SELECT *   
    FROM AVIONES A
    WHERE A.ESTADO = 'Tierra'
        AND A.ID NOT IN (SELECT I.AVION_ID
                         FROM ITINERARIOS I
                            INNER JOIN AVIONES A ON A.ID = I.AVION_ID 
                            INNER JOIN VUELOS V ON V.ID = I.VUELO_ID
                            INNER JOIN RUTAS R ON R.ID = V.RUTA_ID)
        AND rownum = 1;
        
                            
                            
                           update vuelos set ruta_id = 22 where id = 5
                            select * from aeropuertos
                            select * from ciudades
                            select * from vuelos
                            
INSERT INTO aeropuertos (id,nombre,abreviatura,latitud,longitud,ciudad_id) VALUES (id_aeropuerto.NEXTVAL,'Alfonso Bonilla Aragon International Airport','CLO',3.543961,-76.384065, 42);
INSERT INTO aeropuertos (id,nombre,abreviatura,latitud,longitud) VALUES (id_aeropuerto.NEXTVAL,'Rafael Nunez International Airport','CTG',10.446315,-75.516454);
INSERT INTO aeropuertos (id,nombre,abreviatura,latitud,longitud) VALUES (id_aeropuerto.NEXTVAL,'San Salvador International Airport','SAL',13.445138,-89.057036);
INSERT INTO aeropuertos (id,nombre,abreviatura,latitud,longitud) VALUES (id_aeropuerto.NEXTVAL,'Jorge Chavez International Airport','LIM',-12.024053,-77.112036);
INSERT INTO aeropuertos (id,nombre,abreviatura,latitud,longitud) VALUES (id_aeropuerto.NEXTVAL,'Barajas Airport','MAD', 40.498332 , -3.567598);
INSERT INTO aeropuertos (id,nombre,abreviatura,latitud,longitud) VALUES (id_aeropuerto.NEXTVAL,'Miami International Airport','MIA', 25.795865 ,-80.287046);
INSERT INTO aeropuertos (id,nombre,abreviatura,latitud,longitud) VALUES (id_aeropuerto.NEXTVAL,'John F. Kennedy International Airport','JFK',40.641311,-73.778139);
                            
                            
                            select * from ciudades
                            INSERT INTO ciudades (id,ciudad,pais) VALUES (id_ciudad.NEXTVAL,'Cali','Colombia');
                            
                            INSERT INTO RUTAS VALUES (id_ruta.nextval, 21, 2, 419, 0.6)
                            
                            
                            SELECT * FROM VUELOS_PROGRESO
                 SELECT *           
                 FROM ITINERARIOS I
                                INNER JOIN VUELOS V ON V.ID = I.VUELO_ID
                                INNER JOIN RUTAS R ON R.ID = V.RUTA_ID            
         
         
         insert into ITINERARIOS values (id_itinerario.NEXTVAL, SYSDATE, '15/05/2018 10:00',null,'En Vuelo',0,0,null,'15/05/2018 09:00',null,null,5,null,null);
 
         SELECT * FROM ITINERARIOS
             insert into rutas values (id_ruta.nextval, 2,1, 419, 0.6)
             select * from rutas
             update vuelos set ruta_id = 41 where id = 5
             select * from vuelos
             update rutas set AEROPUERTO_ORIGEN_ID = 2,  AEROPUERTO_DESTINO_ID = 1 where id = 2
          
          select * from itinerarios
          commit
          
          update itinerarios set FECHA_ESTIMADA_SALIDA = '15/05/2018 10:00' where 
                            
SELECT VP.AVION_ID            
FROM VUELOS_PROGRESO VP
    WHERE VP.AEROPUERTO_DESTINO_ID = (SELECT R.AEROPUERTO_ORIGEN_ID 
                                      FROM VUELOS V 
                                        INNER JOIN RUTAS R ON R.ID = V.RUTA_ID
                                      WHERE V.ID = 4)                           
        AND abs( extract(hour from (VP.FECHA_ESTIMADA_LLEGADA - (select I.FECHA_ESTIMADA_salida
                                    FROM VUELOS V 
                                INNER JOIN ITINERARIOS I ON I.VUELO_ID = V.ID
                            WHERE V.ID = 4)))) <= 2
        AND ROWNUM = 1;
        
        
        UPDATE ITINERARIOS SET AVION_ID = 17 WHERE ID = 41
        */
        