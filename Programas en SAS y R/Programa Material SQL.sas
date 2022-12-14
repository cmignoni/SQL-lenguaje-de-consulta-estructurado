libname datos "c:\Users\Cesar\Documents\GitHub\SQL-lenguaje-de-consulta-estructurado\Datos\";
RUN;

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

data Datos.mundo;
set DATOS.MUNDO_n;
label PAIS="Pa?s"
	  POBLAC="Poblaci?n"
	  RELIG="Religi?n";
run;

PROC SQL;
*	create table MundoInfo as;
	SELECT pais, 
		   poblac, 
		   relig
	FROM Datos.mundo;
quit;

/*
Los resultados de un SQL SELECT se muestran en todos los destinos ODS abiertos.
El siguiente c?digo produce resultados en los tres destinos ODS abiertos.
*/

ods html body='C:\Users\Cesar\Documents\Resultados SQL\Mundo.html';
ods pdf file='C:\Users\Cesar\Documents\Resultados SQL\Mundo.pdf';
proc sql;
select pais, 
poblac, 
relig
from Datos.Mundo; 
quit;
ods html close;
ods pdf close;

PROC SQL;
	title "Creaci?n del dataset InfoMundo";
	create table InfoMundo as;
	SELECT PAIS as PS, 
		   POBLAC as PB, 
		   RELIG label='Rel_Pa?s' length= 12
	FROM Datos.mundo;
quit;

proc print data=InfoMundo noobs;
run;
proc sql;
/*	create table MundoCopia as*/
	select pais, poblac, densidad, urbana, relig, alfabet
	from Datos.Mundo
	where relig eq 'Musulmana' and
		  alfabet > 50;
quit;

DATA datos.CURSO;
INFILE "C:\Users\Cesar\Google Drive\SQL lenguaje de consulta estructurado\CURSO.DAT";
INPUT ID SEXO $ EDAD ALTURA PESO TIPOTRAN TPO;
LABEL ID="Identificaci?n"
	  SEXO="Sexo alumno"
	  EDAD="Edad Alumno"
	  ALTURA="Estatura alumno"
	  PESO="Peso alumno"
	  TIPOTRAN="Tipo Transporte que usa"
	  TPO="Tiempo demora";
RUN;


proc sql;
	Select sexo,
		edad,
		altura,
		peso, 
		(peso/(altura/100)**2)
	from Datos.curso;
quit; 

proc sql;
/*	create table MundoCopia as*/
	title "Creaci?n de una variable nueva";
	select sexo,
		   edad,
		   altura,
		   peso, 
		   (peso/(altura/100)**2) as IMC /*label="Indice de masa corporal"  */
	from Datos.curso;
quit;


title "";
data ResulData;
set Datos.curso;
where tpo > '20';
run;

proc sql;
create table ResulConsul as
select *
from Datos.curso
where tpo > '20';
quit;

    proc sql;
      select *
      from Datos.curso
      where tipotran is null;
    quit;


proc sql;
select *
from Datos.curso
where tpo between 20 and 40;
quit;

proc sql;
	title "Creaci?n de Mundo_ord";
*	create table Mundo_ord as;
	select relig, pais, alfabet
	from Datos.Mundo
	where alfabet < 50
	order by relig desc, pais;
quit;

    proc sql;
    	select pais, poblac, densidad, relig
    	from Datos.Mundo
    	where relig eq 'Musulmana'
    	order by pais;
    quit;

title " ";
proc sql;
*create table datos.Tpob_localidades as;
select localidad length=20,
	   depart length=20,
	   Tmuj,
	   Tvar,
sum(Tvar,Tmuj) as TPob
from datos.localidades;
quit;

proc sql;
select sum(TPob) as TotalTPob,
mean(TPob) as MeanTPob,
max(TPob) as MaxTPob,
nmiss(TPob) as TPobMiss
from datos.Tpob_localidades;
quit;

proc sql;
select depart length=15,
		prov,
		sum(TPob) as TotalTPob length=7
from datos.Tpob_localidades;
quit;


proc sql;
select depart length=15,
	   prov,
	   sum(TPob) as TotalTPob length=7
from datos.Tpob_localidades
group by prov, depart;
quit;

    proc sql;
      select distinct relig
      from datos.mundo;
    quit;

    Proc sql;
  	  select distinct Make,
  	  origin
  	  from SASHELP.CARS;
    quit;

proc sql;
select count(distinct relig)
from datos.mundo;
quit;

    proc sql;
      select depart length=15,
      	   prov,
      	   sum(TPob) as TotalTPob length=7
      from datos.Tpob_localidades
      group by prov, depart;
      having TotalTPob gt 50000;
    quit;


	proc sql;
        title "Consulta con WHERE";
    	select pais,
    	poblac,
    	densidad
    	from Datos.Mundo
    	where relig eq 'Musulmana';
    quit;

    proc sql;
        title "Consulta con HAVING";
    	select pais,
    	poblac,
    	densidad
    	from Datos.Mundo
    	having relig eq 'Musulmana';
    quit;
