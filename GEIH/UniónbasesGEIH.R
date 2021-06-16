library(data.table)
library(haven)
library(plyr)
library(dplyr)
library(ggplot2)
library(rio)
library(openxlsx)


## VAMOS HA AHCER  GEIH 2020
##UNIMOS ENERO 
setwd("~/Desktop/GEIH/Enero.csv")
dir()
#llamammos todos archivos para rural (RESTO) de enero
cargenru <-read.csv("Resto - Caracter°sticas generales (Personas).csv", sep = ";", dec = ",")
ftru<-read.csv("Resto - Fuerza de trabajo.csv", sep = ";", dec = ",")
ocuru<-read.csv("Resto - Ocupados.csv", sep = ";", dec = ",")
otingru<-read.csv("Resto - Otros ingresos.csv", sep = ";", dec = ",")
desocuru<-read.csv("Resto - Desocupados.csv", sep = ";", dec = ",")
inaru<-read.csv("Resto - Inactivos.csv", sep = ";", dec = ",")
otrasactin<-read.csv("Resto - Otras actividades y ayudas en la semana.csv", sep = ";", dec = ",")
vivhogru<-read.csv("Resto - Vivienda y Hogares.csv", sep = ";", dec = ",")


##Renombramos la 1 variable para generar el unificador
colnames(cargenru)[1]
colnames(cargenru)[1]="DIRECTORIO"
colnames(ftru)[1]="DIRECTORIO"
colnames(ocuru)[1]="DIRECTORIO"
colnames(otingru)[1]="DIRECTORIO"
colnames(desocuru)[1]="DIRECTORIO"
colnames(inaru)[1]="DIRECTORIO"
colnames(otrasactin)[1]="DIRECTORIO"
colnames(vivhogru)[1]="DIRECTORIO"
colnames(cargenru)[1]

###Creamos una base (GEIH) y  hacemos los  merge
GEIHen=merge(vivhogru,cargenru,by=c("DIRECTORIO","SECUENCIA_P"),all=TRUE)
GEIHen=merge(GEIHen,ftru,by=c("DIRECTORIO","SECUENCIA_P","ORDEN"),all=TRUE)
GEIHen$factor=as.numeric(GEIHen$fex_c_2011)
GEIHen=select(GEIHen,-HOGAR.x,-REGIS.x,-AREA.x,-MES.x,-DPTO.x,-fex_c_2011.x,-HOGAR.y,-REGIS.y,-AREA.y,-MES.y,-DPTO.y,-fex_c_2011.y)
GEIHen=merge(GEIHen,ocuru,by=c("DIRECTORIO","SECUENCIA_P","ORDEN"),all=TRUE)
GEIHen=select(GEIHen,-HOGAR.x,-REGIS.x,-MES.x,-DPTO.x,-fex_c_2011.x,HOGAR.y,-REGIS.y,-MES.y,-DPTO.y,-fex_c_2011.y)
GEIHen=merge(GEIHen,desocuru,by=c("DIRECTORIO","SECUENCIA_P","ORDEN"),all=TRUE)
GEIHen=select(GEIHen,-CLASE.x,-CLASE.y)
GEIHen=merge(GEIHen,inaru,by=c("DIRECTORIO","SECUENCIA_P","ORDEN"),all=TRUE)
GEIHen=select(GEIHen,-HOGAR.y)
GEIHen=merge(GEIHen,otingru,by=c("DIRECTORIO","SECUENCIA_P","ORDEN"),all=TRUE)
GEIHen=merge(GEIHen,otrasactin,by=c("DIRECTORIO","SECUENCIA_P","ORDEN"),all=TRUE)
GEIHen=select(GEIHen,-HOGAR.x,-REGIS.x,-MES.x,-DPTO.x,-fex_c_2011.x,-REGIS.y,-MES.y,-DPTO.y,-fex_c_2011.y)



dim(GEIHen)
view(GEIHen$factor)

GEIHen[!is.na(DSI),sum(factor),by=c("DSI")]##saca ocupados rurales del mes de enero 
GEIHen[!is.na(OCI),sum(factor),by=c("OCI")]#saca ocupados rurales de enero

GEIHen<-as.data.table(GEIHen)
remove(list = setdiff(ls(), c("GEIHen")))
















