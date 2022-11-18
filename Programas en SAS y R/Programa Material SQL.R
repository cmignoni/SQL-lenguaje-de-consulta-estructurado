setwd("C:/Users/Cesar/Google Drive/SQL lenguaje de consulta estructurado")

install.packages("sqldf")
library("sqldf")
# Leer los datos del archivo
library(openxlsx)
Mundo <- read.xlsx("Datos/mundo_nuevo.xlsx")

# Manipular conjuntos de datos en R con SQL

sqldf("select pais, 
		   poblac, 
		   relig 
	from Mundo")

# Una salida distinta para los resultados

# Creación de una Tabla
# También se puede crear un conjunto de datos en R (una tabla) a partir 
# de los resultados de la consulta asignando la instrucción 
# SELECT con <-.

MundoInfo<-sqldf("select pais, 
		   poblac, 
		   relig 
	from Mundo")

# Las columnas en una instrucción SELECT se pueden renombrar, etiquetar o reformatear.
# La siguiente consulta crearía un conjunto de datos SAS temporal llamado MundoInfo2 que tiene tres variables:
# • PS
# • PB
# • RELIG

MundoInfo2<-sqldf("SELECT PAIS as PS, 
		   POBLAC as PB, 
		   RELIG as Rel_País
	FROM Mundo
")

# Seleccionar todas las columnas

MundoCopia <- sqldf("select *
  from Mundo")


# CREACION DE UN DATASET NUEVO LLAMADO CURSO

#curso<-read.delim("Datos/CURSO.DAT", sep=" ", header = F)

curso<-read.delim("Datos/curso.txt", stringsAsFactors = FALSE, sep=" ", header = T)

curso.IMC<-sqldf("select sexo,
		   edad,
		   altura,
		   peso 
      from curso")



