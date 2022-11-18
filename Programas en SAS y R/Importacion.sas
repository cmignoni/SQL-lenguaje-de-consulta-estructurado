PROC IMPORT OUT= DATOS.Localidades 
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
