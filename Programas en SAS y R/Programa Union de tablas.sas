libname datos "c:\Users\Cesar\Documents\GitHub\SQL-lenguaje-de-consulta-estructurado\Datos\";

*Union Interna o Inner Join con las Tablas Empleados y Departamentos;

Proc sql;
title "Empleados por Departamento";
*create table Datos.inter as;
SELECT * 
FROM datos.Empleados E, Datos.Departamentos D
WHERE E.DepartamentoId = D.Id
ORDER BY E.nombre desc;
quit;

proc print data=datos.inter;
run;
