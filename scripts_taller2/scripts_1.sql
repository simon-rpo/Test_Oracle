CREATE TABLE empleados(
id int primary key,
tipo_empleado varchar(30),
nombre varchar(150),
apellido varchar(150),
sexo varchar(1),
fecha_nacimiento date,
antiguedad int,
fecha_ultimo_entrenamiento date,
direccion varchar(100),
email varchar(150),
celular varchar(20),
horas_descanso int,
estado varchar(30),
ciudad_id int not null
);


CREATE TABLE pilotos(
id int primary key,
horas_vuelo int,
certificado_ICAO varchar(10),
tipo_licencia varchar(10), --> ATPL, CPL_IFR, CPL_ME
tipo_cargo varchar(30),
empleado_id int
);

CREATE TABLE ciudades(
id int primary key,
ciudad varchar(30),
pais varchar(30)
);

CREATE TABLE itinerarios(
id int primary key,
fecha date,
fecha_estimada_salida timestamp,
fecha_real_salida timestamp,
estado varchar2(40 byte),
pasajeros_economica int,
pasajetos_ejecutiva int,
duracion_real int,
fecha_estimada_llegada timestamp,
fecha_real_llegada timestamp,
avion_id int,
vuelo_id int,
piloto_id int,
copiloto_id int
);

CREATE TABLE tripulante_programaciones(
id int primary key,
itinerario_id int not null,
empleado_id int not null
);

CREATE TABLE aeropuertos(
id int primary key,
nombre  varchar(200),
abreviatura varchar(20),
latitud number(18,5),
longitud number(18,5),
ciudad_id int
);

CREATE TABLE rutas(
id int primary key,
aeropuerto_origen_id int,
aeropuerto_destino_id int,
distancia_km int,
duracion_promedio number()
);


CREATE TABLE vuelos(
id int primary key,
codigo_vuelo varchar(20),
frecuencia_semanal number,
ruta_id int not null
);

CREATE TABLE check_in(
id int primary key,
pasajero_id int,
itinerario_id int,
ciudad_id int,
hora_check_in date,
nombre_contacto varchar(50),
telefono_contacto varchar(20),
email_contacto varchar(30)
);

CREATE TABLE pasajeros(
id int primary key,
nombre varchar(50),
apellido varchar(50),
identificacion int,
tipo_documento int,
vuelo_id int
);

CREATE TABLE aviones(
id  int primary key,
matricula varchar(30),
serial varchar(50),
edad int,
marca varchar(70),
asientos_ejecutivos int,
asientos_economicos int,
asientos_estandar int
);

CREATE TABLE log_vuelos(
id int primary key,
time_stamp varchar(30),
hora_utc timestamp,
latitud varchar(20),
longitud varchar(20),
altitud varchar(20),
velocidad varchar(20),
direccion varchar(50),
itinerario_id int
);


/*foreign keys*/
                                          
ALTER TABLE empleados
ADD CONSTRAINT fk_empleados_ciudades
foreign key (ciudad_id)
references ciudades(id);

ALTER TABLE pilotos
ADD CONSTRAINT fk_pilotos_empleados
foreign key (empleado_id)
references empleados(id);  

ALTER TABLE rutas
ADD CONSTRAINT fk_rutas_aeropuertos_o
foreign key (aeropuerto_origen_id)
references aeropuertos (id);

ALTER TABLE rutas
ADD CONSTRAINT fk_rutas_aeropuertos_d
foreign key (aeropuerto_destino_id)
references aeropuertos (id);

ALTER TABLE vuelos
ADD CONSTRAINT fk_vuelos_rutas
foreign key (ruta_id)
references rutas (id);

ALTER TABLE tripulante_programaciones
ADD CONSTRAINT fk_tripulante_programaciones_itinerarios
foreign key (itinerario_id)
references itinerarios (id);

ALTER TABLE tripulante_programaciones
ADD CONSTRAINT fk_tripulante_programaciones_empleados
foreign key (empleado_id)
references empleados (id);

ALTER TABLE log_vuelos
ADD CONSTRAINT fk_log_vuelos_itinerarios
foreign key (itinerario_id)
references itinerarios (id);

ALTER TABLE itinerarios
ADD CONSTRAINT fk_itinerarios_aviones
foreign key (avion_id)
references aviones (id);

ALTER TABLE itinerarios
ADD CONSTRAINT fk_itinerarios_vuelos
foreign key (vuelo_id)
references vuelos (id);

ALTER TABLE itinerarios
ADD CONSTRAINT fk_itinerarios_pilotos
foreign key (piloto_id)
references pilotos (id);

ALTER TABLE itinerarios
ADD CONSTRAINT fk_itinerarios_copilotos
foreign key (copiloto_id)
references pilotos (id);

ALTER TABLE check_in
ADD CONSTRAINT fk_check_in_pasajeros
foreign key (pasajero_id)
references pasajeros (id);

ALTER TABLE check_in
ADD CONSTRAINT fk_check_in_itinerarios
foreign key (itinerario_id)
references itinerarios (id);

ALTER TABLE check_in
ADD CONSTRAINT fk_check_in_ciudades
foreign key (ciudad_id)
references ciudades (id);

ALTER TABLE pasajeros
ADD CONSTRAINT fk_pasajeros_in_vuelos
foreign key (vuelo_id)
references vuelos (id);

ALTER TABLE aeropuertos
ADD CONSTRAINT fk_aeropuertos_ciudades
foreign key (ciudad_id)
references ciudades (id);








