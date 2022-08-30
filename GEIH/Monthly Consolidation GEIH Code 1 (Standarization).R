#################################################################################################################
##################################### GEIH MONTHLY STANDARIZATION #####################################################
#################################################################################################################

##### Load the packages

Pkgs <- c("ggplot2", "tidyverse", "dplyr", "highcharter", "hrbrthemes", "ggrepel", 
          "stringr", "skimr", "stats", "viridis", "haven", "readxl", "skimr", 
          "stats", "RColorBrewer", "plotly", "kableExtra", "ggpubr",
          "knitr", "broom", "ggthemes", "zoo", "readxl", "lubridate", "highcharter",
          "ggalt", "htmltools", "gridExtra", "tsibble")

lapply(Pkgs, library, character.only = TRUE)

##### Install the required packages

# Function to install new packages

ipak <- function(pkg){
new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
if (length(new.pkg))
  install.packages(new.pkg, dependencies = TRUE)
sapply(pkg, require, character.only = TRUE)
}

ipak(Pkgs)

##### Set working directory

setwd("C:/Users/OneDrive/PNUD trabajo/Microsim/2020/ConsolidacionGEIH")

##################################### Load data bases ########################################################

##### General Characteristics #####

### Urban

U_GC <- read.csv("Cabecera - Características generales (Personas).csv",
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

### Rural

R_GC <- read.csv("Resto - Características generales (Personas).csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")


### Area (13 Cities)

A_GC <- read.csv("Área - Características generales (Personas).csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

##### Unemployed #####

### Urban

U_Un <- read.csv("Cabecera - Desocupados.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

summary(U_Un)


### Rural

R_Un <- read.csv("Resto - Desocupados.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

summary(R_Un)

### Area (13 Cities)

A_Un <- read.csv("Área - Desocupados.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

summary(A_Un)


##### Labor Force #####

### Urban

U_LF <- read.csv("Cabecera - Fuerza de trabajo.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

### Rural

R_LF <- read.csv("Resto - Fuerza de trabajo.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

### Area (13 Cities)

A_LF <- read.csv("Área - Fuerza de trabajo.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

##### Inactives #####

### Urban

U_In <- read.csv("Cabecera - Inactivos.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")


### Rural

R_In <- read.csv("Resto - Inactivos.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

### Area (13 Cities)

A_In <- read.csv("Área - Inactivos.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")


##### Employed #####

### Urban

U_Em <- read.csv("Cabecera - Ocupados.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

summary(U_Em)

### Rural

R_Em <- read.csv("Resto - Ocupados.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

summary(R_Em)

### Area (13 Cities)

A_Em <- read.csv("Área - Ocupados.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

##### Other Activities #####

### Urban

U_OA <- read.csv("Cabecera - Otras actividades y ayudas en la semana.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")


### Rural

R_OA <- read.csv("Resto - Otras actividades y ayudas en la semana.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

### Area (13 Cities)

A_OA <- read.csv("Área - Otras actividades y ayudas en la semana.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")


##### Other Income #####

### Urban

U_OI <- read.csv("Cabecera - Otros ingresos.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")


### Rural

R_OI <- read.csv("Resto - Otros ingresos.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

### Area (13 Cities)

A_OI <- read.csv("Área - Otros ingresos.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

##### House and Households #####

### Urban

U_HH <- read.csv("Cabecera - Vivienda y Hogares.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")


### Rural

R_HH <- read.csv("Resto - Vivienda y Hogares.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")

### Area (13 Cities)

A_HH <- read.csv("Área - Vivienda y Hogares.csv", 
                 sep = ";", 
                 dec = ".",
                 fileEncoding = "UTF-8-BOM")


##################################### Woodwork ########################################################

#################### Change the names to Upper case to make the append ##########

##### 13 Cities Data ####

names(A_Em) <- toupper(names(A_Em)) 
names(A_GC) <- toupper(names(A_GC)) 
names(A_HH) <- toupper(names(A_HH)) 
names(A_In) <- toupper(names(A_In)) 
names(A_LF) <- toupper(names(A_LF))
names(A_OA) <- toupper(names(A_OA)) 
names(A_OI) <- toupper(names(A_OI)) 
names(A_Un) <- toupper(names(A_Un))

###### Rural Data #####

names(R_Em) <- toupper(names(R_Em)) 
names(R_GC) <- toupper(names(R_GC)) 
names(R_HH) <- toupper(names(R_HH)) 
names(R_In) <- toupper(names(R_In)) 
names(R_LF) <- toupper(names(R_LF)) 
names(R_OA) <- toupper(names(R_OA)) 
names(R_OI) <- toupper(names(R_OI)) 
names(R_Un) <- toupper(names(R_Un))

###### Urban Data #####

names(U_Em) <- toupper(names(U_Em))
names(U_GC) <- toupper(names(U_GC))
names(U_HH) <- toupper(names(U_HH)) 
names(U_In) <- toupper(names(U_In))
names(U_LF) <- toupper(names(U_LF))
names(U_OA) <- toupper(names(U_OA)) 
names(U_OI) <- toupper(names(U_OI)) 
names(U_Un) <- toupper(names(U_Un))




########## Replace the points by NAs ##########

##### 13 Cities Data ####

A_Em[A_Em== "." ] <- NA
A_GC[A_GC== "." ] <- NA
A_HH[A_HH== "." ] <- NA
A_In[A_In== "." ] <- NA
A_LF[A_LF== "." ] <- NA
A_OA[A_OA== "." ] <- NA
A_OI[A_OI== "." ] <- NA
A_Un[A_Un== "." ] <- NA

###### Rural Data #####

R_Em[R_Em== "." ] <- NA
R_GC[R_GC== "." ] <- NA
R_HH[R_HH== "." ] <- NA
R_In[R_In== "." ] <- NA
R_LF[R_LF== "." ] <- NA
R_OA[R_OA== "." ] <- NA
R_OI[R_OI== "." ] <- NA
R_Un[R_Un== "." ] <- NA


###### Urban Data #####

U_Em[U_Em== "." ] <- NA
U_GC[U_GC== "." ] <- NA
U_HH[U_HH== "." ] <- NA
U_In[U_In== "." ] <- NA
U_LF[U_LF== "." ] <- NA
U_OA[U_OA== "." ] <- NA
U_OI[U_OI== "." ] <- NA
U_Un[U_Un== "." ] <- NA

##################################### Save data ########################################################

##### Save the files ready to merge #####

write.csv2(A_GC, "Área - Características generales (Personas).csv", row.names = FALSE)
write.csv2(U_GC, "Cabecera - Características generales (Personas).csv", row.names = FALSE)
write.csv2(R_GC, "Resto - Características generales (Personas).csv", row.names = FALSE)

write.csv2(A_Un, "Área - Desocupados.csv", row.names = FALSE)
write.csv2(U_Un, "Cabecera - Desocupados.csv", row.names = FALSE)
write.csv2(R_Un, "Resto - Desocupados.csv", row.names = FALSE)

write.csv2(A_LF, "Área - Fuerza de trabajo.csv", row.names = FALSE)
write.csv2(U_LF, "Cabecera - Fuerza de trabajo.csv", row.names = FALSE)
write.csv2(R_LF, "Resto - Fuerza de trabajo.csv", row.names = FALSE)

write.csv2(A_In, "Área - Inactivos.csv", row.names = FALSE)
write.csv2(U_In, "Cabecera - Inactivos.csv", row.names = FALSE)
write.csv2(R_In, "Resto - Inactivos.csv",row.names = FALSE)

write.csv2(A_Em, "Área - Ocupados.csv", row.names = FALSE)
write.csv2(U_Em, "Cabecera - Ocupados.csv", row.names = FALSE)
write.csv2(R_Em, "Resto - Ocupados.csv", row.names = FALSE)

write.csv2(A_OA, "Área - Otras actividades y ayudas en la semana.csv", row.names = FALSE)
write.csv2(U_OA, "Cabecera - Otras actividades y ayudas en la semana.csv", row.names = FALSE)
write.csv2(R_OA, "Resto - Otras actividades y ayudas en la semana.csv", row.names = FALSE)

write.csv2(A_OI, "Área - Otros ingresos.csv", row.names = FALSE)
write.csv2(U_OI, "Cabecera - Otros ingresos.csv", row.names = FALSE)
write.csv2(R_OI, "Resto - Otros ingresos.csv", row.names = FALSE)

write.csv2(A_HH, "Área - Vivienda y Hogares.csv", row.names = FALSE)
write.csv2(U_HH, "Cabecera - Vivienda y Hogares.csv", row.names = FALSE)
write.csv2(R_HH, "Resto - Vivienda y Hogares.csv", row.names = FALSE)

