libname Datos "C:\Users\Cesar\Google Drive\SQL lenguaje de consulta estructurado\Datos";
run;

FILENAME REFFILE 'C:\Users\Cesar\Google Drive\SQL lenguaje de consulta estructurado\Datos\Localidades.XLSX';

PROC IMPORT DATAFILE=REFFILE
	OUT=Datos.Localidades 
	DBMS=XLSX;
RUN;

options nodate;

DATA DATOS.MUNDO_NEW;
SET DATOS.MUNDO;
LABEL PAIS="País"
		POBLAC="Población"
		RELIG="Religión";
RUN;

/* Uso de SQL en SAS
PROC SQL es la sentencia SAS que permite ejecutar las estructuras del lenguaje SQL 
encerando las cláusulas del mismo.
*/

proc sql;
	select pais, 
		   poblac, 
		   relig 
	from Datos.Mundo_NEW; 
quit;

/* Una salida distinta para los resultados
Los resultados de un SQL SELECT se muestran en todos los destinos ODS abiertos.
El siguiente código produce resultados en los tres destinos ODS abiertos.
*/

ods html body='C:\Users\Cesar\Documents\Resultados SQL\Mundo.html';
ods pdf file='C:\Users\Cesar\Documents\Resultados SQL\Mundo.pdf';
proc sql;
	select pais, 
		poblac, 
		relig
	from Datos.Mundo_new; 
quit;
ods html close;
ods pdf close;

/* Creación de una Tabla
También se puede crear un conjunto de datos SAS (una tabla) a partir 
de los resultados de la consulta precediendo la instrucción 
SELECT con una instrucción CREATE TABLE.
*/
proc sql;
	create table MundoInfo as
	select pais, 
		poblac, 
		relig
	from Datos.Mundo_new; 
quit;

/*
Las columnas en una instrucción SELECT se pueden renombrar, etiquetar o reformatear.
La siguiente consulta crearía un conjunto de datos SAS temporal llamado MundoInfo2 que tiene tres variables:
• PS
• PB
• RELIG
*/

PROC SQL;
	create table MundoInfo2 as
	SELECT PAIS as PS, 
		   POBLAC as PB, 
		   RELIG label='Rel_País' length= 12
	FROM Datos.mundo;
quit;

/* Seleccionar todas las columnas */

proc sql;
	create table MundoCopia as
	select *
	from Datos.Mundo;
quit;

/*
CREACION DE UN DATASET NUEVO LLAMADO CURSO
*/
DATA datos.CURSO;
INFILE "C:\Users\Cesar\Google Drive\cmignoni\RAPD\SAS Studio\Datos\CURSO.DAT";
INPUT ID SEXO $ EDAD ALTURA PESO TIPOTRAN TPO;
LABEL ID="Identificaciòn"
	  SEXO="Sexo alumno"
	  EDAD="Edad Alumno"
	  ALTURA="Estatura alumno"
	  PESO="Peso alumno"
	  TIPOTRAN="Tipo Transporte que usa"
	  TPO="Tiempo demora";
RUN;
/* 
Crear nuevas columnas
Se puede ver que la nueva columna tiene la etiqueta "IMC", que habría sido 
el nombre de la variable si se hubiera tenido una instrucción CREATE TABLE.
*/

proc sql;
	select sexo,
		   edad,
		   altura,
		   peso, 
		   (peso/(altura/100)**2) as IMC /*label="Indice de masa corporal"  */
	from Datos.curso;
quit;

/*Aparece sin nombre cuando no se le coloca AS*/

proc sql;
	Select sexo,
		edad,
		altura,
		peso, 
		(peso/(altura/100)**2)
	from Datos.curso;
quit; 

/*
La cláusula WHERE para la Selección de filas
Creamos una tabla de salida para visualizar bien los datos
de la consulta
*/

proc sql;
	create table MundoMusul as
	select *
	from Datos.Mundo
	where relig eq 'Musulmana';
quit; 

proc sql;
	create table MundoMusul2 as
	select *
	from Datos.Mundo
	where relig eq 'Musulmana' and
		alfabet > 50;
quit;

/*
Hay una diferencia entre cómo SAS maneja los tipos de datos no coincidentes en las cláusulas WHERE 
y otras partes del lenguaje. (Esto es cierto si se utiliza WHERE en PROC SQL o en un paso data u 
otro procedimiento). En la mayoría de los casos, SAS realizará una conversión de tipo automática, 
de carácter a numérico o viceversa, para que la comparación sea válida.
*/

data ResulData;
	set Datos.curso;
	if tpo > '20';
run;
/*
La instrucción IF en el paso data realiza una conversión automática del '20' a numérico y evalúa 
la expresión. Se escribe una nota en la ventana Log 
*/
proc sql;
	*create table ResulConsul as;
	select *
	from Datos.curso
	where tpo > '20';
quit;

/*Puede usar los operadores IS NULL o IS MISSING para devolver filas con valores faltantes. */
proc sql;
	select *
	from Datos.curso
	where tipotran is missing;
quit;

/* El operador BETWEEN le permite buscar un valor que se encuentre entre otros dos valores. */

proc sql;
	select *
	from Datos.curso
	where tpo between 20 and 40;
quit;

/*
Los datos de selección ordenandos 
*/
proc sql;
	create table Mundo_Musul_Ord as
	select *
	from Datos.Mundo
	where relig eq 'Musulmana'
	order by pais;
quit;


proc sql;
	create table Mundo_ord as
	select relig,
 		 pais, 
 		 alfabet
	from Datos.Mundo
	where alfabet < 50
	order by relig, 
             pais desc;
quit;


proc sql;
	select count(distinct relig||pais)
	from datos.mundo;
quit;

proc freq data=datos.mundo;
tables relig;
run;

proc sql;
	select distinct sexo
	from datos.curso;
quit;

Proc sql;
	select distinct Make,
	origin
	from SASHELP.CARS;
quit;

proc sql;
select count(distinct Make)
from SASHELP.CARS;
quit;

/* CREACION DE UN DATASET NUEVO LLAMADO LOCALIDADES */

PROC IMPORT OUT= Localidades 
            DATAFILE= "C:\Users\cmignoni\Google Drive\SQL lenguaje de co
nsulta estructurado\Datos\LOCALIDADES.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="LOCALIDADES$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

/* CREACION DE UN DATASET NUEVO LLAMADO TPOB_LOCALIDADES 
	A PARTIR DE LOCALIDADES CON UNA VAR. NUEVA CON EL TOTAL DE POBLACIÓN
*/

proc sql;
create table datos.Tpob_localidades as
select localidad length=20,
	   depart length=20,
	   prov,
	   Tmuj,
	   Tvar,
sum(Tvar,Tmuj) as TPob
from datos.localidades;
quit;
/*
CREAMOS ALGUNOS DESCRIPTIVOS UTILIZANDO FUNCIONES AGREGADAS
*/

proc sql;
	select sum(TPob) as TotalTPob,
 		   mean(TPob) as MeanTPob,
		   max(TPob) as MaxTPob,
		   nmiss(TPob) as TPobMiss
	from datos.Tpob_localidades;
quit;

/*
OBTENER EL TOTAL DE POBLACION SEGUN EL DEPARTAMENTO DE CADA PROVINCIA
*/

proc sql;
select depart length=15,
	   prov,
	   sum(TPob) as TotalTPob length=7
from datos.Tpob_localidades
group by prov, depart;
quit;

/*
OBTENER EL TOTAL DE POBLACION SEGUN EL DEPARTAMENTO DE CADA PROVINCIA
Y SE QUEDA CON LOS DEPARTAMENTOS QUE TIENE UNA POBLACION MAYOR A 50000
*/

proc sql;
select depart length=15,
	   prov,
	   sum(TPob) as TotalTPob length=7
from datos.Tpob_localidades
group by prov, depart
having TotalTPob gt 50000;
quit;


/*
LA DIFERENCIA ENTRE HAVING Y WHERE CUANDO NO HAY COLUMNAS RESUMEN
*/

proc sql;
	select pais,
	poblac,
	densidad
	from Datos.Mundo
	where relig eq 'Musulmana';
quit;

proc sql;
	select pais,
	poblac,
	densidad
	from Datos.Mundo
	having relig eq 'Musulmana';
quit;
