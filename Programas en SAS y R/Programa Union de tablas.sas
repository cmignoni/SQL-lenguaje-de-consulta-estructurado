*libname datos "c:\Users\Cesar\Documents\GitHub\SQL-lenguaje-de-consulta-estructurado\Datos\";
libname datos "c:\Users\cmignoni\Documents\GitHub\SQL-lenguaje-de-consulta-estructurado\Datos\";


*Union Interna o Inner Join con las Tablas Empleados y Departamentos;

Proc sql;
title "Empleados por Departamento";
*create table Datos.inter as;
SELECT * 
FROM datos.Empleados E, Datos.Departamentos D
WHERE E.DepartamentoId = D.DepartamentoId
ORDER BY E.nombre desc;
quit;

*proc print data=datos.inter;
*run;

*Union izquierda o LEFT JOIN con las Tablas Empleados y Departamentos;

proc sql;
SELECT *
FROM datos.Empleados E LEFT JOIN Datos.Departamentos D
on E.DepartamentoId = D.DepartamentoId
ORDER BY E.nombre;
quit;

*Union izquierda o RIGHT JOIN con las Tablas Empleados y Departamentos;

proc sql;
SELECT *
FROM datos.Empleados as E RIGHT JOIN Datos.Departamentos as D
on E.DepartamentoId = D.DepartamentoId
ORDER BY D.nombre;
quit;

*Unión completa o FULL JOIN con las Tablas Empleados y Departamentos;

proc sql;
SELECT *
FROM datos.Empleados as E FULL JOIN Datos.Departamentos as D
on E.DepartamentoId = D.DepartamentoId;
*ORDER BY E.nombre;
quit;
