library(sqldf)
setwd("c:/Users/Cesar/Documents/SQL lenguaje de consulta estructurado/Datos")

data("iris")
data(Orange)
data(BOD) 
data(rock) 

iris <- as.data.frame(iris)
Orange <- as.data.frame(Orange)
BOD <- as.data.frame(BOD)
rock <- as.data.frame(rock)
chickwts <- as.data.frame(chickwts)


write.csv(iris,file = "iris.csv", row.names = F)
write.csv(Orange,file = "Naranjo.csv", row.names = F)
write.csv(BOD,file = "BOD.csv", row.names = F)
write.csv(rock,file = "rock.csv", row.names = F)
write.csv(chickwts,file = "chickwts.csv", row.names = F)

iris <- read.csv(file = "iris.csv", sep=",", header = T, dec = ".")
Naranjo <- read.csv(file = "Naranjo.csv", sep=",", header = T, dec = ".")
BOD <- read.csv(file = "BOD.csv", sep=",", header = T, dec = ".")
rock <- read.csv(file = "rock.csv", sep=",", header = T, dec = ".")
chickwts <- read.csv(file = "chickwts.csv", sep=",", header = T, dec = ".")
