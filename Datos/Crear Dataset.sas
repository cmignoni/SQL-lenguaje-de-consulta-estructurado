libname datos "c:\Users\Cesar\Documents\GitHub\SQL-lenguaje-de-consulta-estructurado\Datos\";

data datos.Habilidades_Piloto;
input piloto $ avion $;
datalines;
Celko Piper Cub
Higgins B-52 Bomber
Higgins F-14 Fighter
Higgins Piper Cub
Jones B-52 Bomber
Jones F-14 Fighter
Smith B-1 Bomber
Smith B-52 Bomber
Smith F-14 Fighter
Wilson B-1 Bomber
Wilson B-52 Bomber
Wilson F-14 Fighter
Wilson F-17 Fighter
;
run;

data datos.hangar;
input avion $;
datalines;
B-1 Bomber
B-52 Bomber
F-14 Fighter
; 
run;

data datos.pilotos;
input nombre $;
datalines;
Smith
Wilson
;
run;

* Program 2.1-2: Creación de las tabas con PROC SQL;

*HABILIDADES DEL PILOTO;
proc sql ;
create table datos.Habilidades_Piloto_SQL
(piloto char (30) NOT NULL label="Nombre del Piloto",
avion char (30) NOT NULL label="Habilidad de vuelo") ;
quit ;

*HANGAR;
proc sql ;
create table datos.hangar_SQL
(ID num NOT NULL,
avion char (30) NOT NULL label="Habilidad de vuelo") ;
quit ;
*PILOTOS;
proc sql ;
create table datos.Pilotos_SQL
(ID num NOT NULL,
nombre char (30) NOT NULL label="Nombre y Apellido");
quit ;

*Program Insertar Datos en los dataset;
proc sql ;
insert into datos.Habilidades_Piloto_SQL
values('Celko', 'Piper Cub')
values('Higgins', 'B-52 Bomber')
values('Higgins', 'F-14 Fighter')
values('Higgins', 'Piper Cub')
values('Jones', 'B-52 Bomber')
values('Jones', 'F-14 Fighter')
values('Smith', 'B-1 Bomber')
values('Smith', 'B-52 Bomber')
values('Smith', 'F-14 Fighter')
values('Wilson', 'B-1 Bomber')
values('Wilson', 'B-52 Bomber')
values('Wilson', 'F-14 Fighter')
values('Wilson', 'F-17 Fighter');
quit ;

proc sql ;
insert into datos.hangar_SQL
values(1,'B-1 Bomber')
values(2,'B-52 Bomber')
values(3,'F-14 Fighter');
quit ;

proc sql ;
insert into datos.Pilotos_SQL
values(1,'Smith')
values(2,'Wilson');
quit ;

*CREACION DE LAS TABLAS DEPARTAMENTOS Y EMPLEADOS;

proc sql ;
create table datos.Departamentos
(ID num NOT NULL,
Nombre char (20) NOT NULL label="Nombre Departameto");
quit ;
*PILOTOS;
proc sql ;
create table datos.Empleados
(Nombre char (30) NOT NULL label="Nombre Empleado",
departamentoID num);
quit ;

proc sql;
insert into datos.Departamentos
  VALUES(31, 'Sales')
  VALUES(33, 'Engineering')
  VALUES(34, 'Clerical')
  VALUES(35, 'Marketing');
quit ;

proc sql ;
insert into datos.Empleados
  VALUES('Rafferty', 31)
  VALUES('Jones', 33)
  VALUES('Heisenberg', 33)
  VALUES('Robinson', 34)
  VALUES('Smith', 34)
  VALUES('Williams', NULL);
quit ;

