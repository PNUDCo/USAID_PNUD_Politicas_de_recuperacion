#################################################################################################################
##################################### GEIH MONTHLY CONSOLIDATION #####################################################
#################################################################################################################

##### Load the packages

Pkgs <- c("ggplot2", "tidyverse", "dplyr", "highcharter", "hrbrthemes", "ggrepel", 
          "stringr", "skimr", "stats", "viridis", "haven", "readxl", "skimr", 
          "stats", "RColorBrewer", "plotly", "kableExtra", "bbplot", "ggpubr",
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

setwd("C:/Users/pjara/OneDrive/PNUD trabajo/Microsim/2020/ConsolidacionGEIH/Noviembre")

################################## Load data bases ################################################################ 

##### General Characteristics #####

### Urban

U_GC <- read.csv("Cabecera - Características generales (Personas).csv", 
                            sep = ";", 
                            dec = ",") 
                            

### Rural

R_GC <- read.csv("Resto - Características generales (Personas).csv", 
                  sep = ";", 
                  dec = ",")
                  

### Area (13 Cities)

A_GC <- read.csv("Área - Características generales (Personas).csv", 
                 sep = ";", 
                 dec = ",") 
                 

##### Unemployed #####

### Urban

U_Un <- read.csv("Cabecera - Desocupados.csv", 
                 sep = ";", 
                 dec = ",") 
                 

summary(U_Un)


### Rural

R_Un <- read.csv("Resto - Desocupados.csv", 
                 sep = ";", 
                 dec = ",") 
                 

summary(R_Un)

### Area (13 Cities)

A_Un <- read.csv("Área - Desocupados.csv", 
                 sep = ";", 
                 dec = ",") 
                 

summary(A_Un)


##### Labor Force #####

### Urban

U_LF <- read.csv("Cabecera - Fuerza de trabajo.csv", 
                 sep = ";", 
                 dec = ",") 
                 

### Rural

R_LF <- read.csv("Resto - Fuerza de trabajo.csv", 
                 sep = ";", 
                 dec = ",") 
                 

### Area (13 Cities)

A_LF <- read.csv("Área - Fuerza de trabajo.csv", 
                 sep = ";", 
                 dec = ",") 
                 

##### Inactives #####

### Urban

U_In <- read.csv("Cabecera - Inactivos.csv", 
                 sep = ";", 
                 dec = ",") 
                 


### Rural

R_In <- read.csv("Resto - Inactivos.csv", 
                 sep = ";", 
                 dec = ",") 
                 

### Area (13 Cities)

A_In <- read.csv("Área - Inactivos.csv", 
                 sep = ";", 
                 dec = ",") 
                 


##### Employed #####

### Urban

U_Em <- read.csv("Cabecera - Ocupados.csv", 
                 sep = ";", 
                 dec = ",") 
                 

summary(U_Em)

### Rural

R_Em <- read.csv("Resto - Ocupados.csv", 
                 sep = ";", 
                 dec = ",",
                 stringsAsFactors = FALSE) 
                 

summary(R_Em)

### Area (13 Cities)

A_Em <- read.csv("Área - Ocupados.csv", 
                 sep = ";", 
                 dec = ",") 
                 

##### Other Activities #####

### Urban

U_OA <- read.csv("Cabecera - Otras actividades y ayudas en la semana.csv", 
                 sep = ";", 
                 dec = ",") 
                 


### Rural

R_OA <- read.csv("Resto - Otras actividades y ayudas en la semana.csv", 
                 sep = ";", 
                 dec = ",") 
                 

### Area (13 Cities)

A_OA <- read.csv("Área - Otras actividades y ayudas en la semana.csv", 
                 sep = ";", 
                 dec = ",") 
                 


##### Other Income #####

### Urban

U_OI <- read.csv("Cabecera - Otros ingresos.csv", 
                 sep = ";", 
                 dec = ",") 
                 


### Rural

R_OI <- read.csv("Resto - Otros ingresos.csv", 
                 sep = ";", 
                 dec = ",") 
                 

### Area (13 Cities)

A_OI <- read.csv("Área - Otros ingresos.csv", 
                 sep = ";", 
                 dec = ",") 
                 

##### House and Households #####

### Urban

U_HH <- read.csv("Cabecera - Vivienda y Hogares.csv", 
                 sep = ";", 
                 dec = ",") 
                 


### Rural

R_HH <- read.csv("Resto - Vivienda y Hogares.csv", 
                 sep = ";", 
                 dec = ",") 
                 

### Area (13 Cities)

A_HH <- read.csv("Área - Vivienda y Hogares.csv", 
                 sep = ";", 
                 dec = ",") 
                 





################################## Consolidation process ###############################################

########## Merge the Area Data Base #########

###### Join Unemployed

Area <- A_GC %>%
  merge(A_Un, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Area)

### Delete y vars with same names but incomplete obs

Area = Area[,!grepl(".y$",names(Area))]

### Drop .x in repeated names

colnames(Area) <- sub("\\.x", "", colnames(Area))

###### Join Labor Force

Area <- Area %>%
  merge(A_LF, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Area)

Area = Area[,!grepl(".y$",names(Area))]

colnames(Area) <- sub("\\.x", "", colnames(Area))

###### Join Inactives

Area <- Area %>%
  merge(A_In, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Area)

Area = Area[,!grepl(".y$",names(Area))]

colnames(Area) <- sub("\\.x", "", colnames(Area))

###### Join Employed

Area <- Area %>%
  merge(A_Em, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Area)

Area = Area[,!grepl(".y$",names(Area))]

colnames(Area) <- sub("\\.x", "", colnames(Area))


########## Merge the Urban Data Base #########

###### Join Unemployed

Urban <- U_GC %>%
  merge(U_Un, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Urban)

### Delete y vars with same names but incomplete obs

Urban = Urban[,!grepl(".y$",names(Urban))]

### Drop .x in repeated names

colnames(Urban) <- sub("\\.x", "", colnames(Urban))

###### Join Labor Force

Urban <- Urban %>%
  merge(U_LF, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Urban)

Urban = Urban[,!grepl(".y$",names(Urban))]

colnames(Urban) <- sub("\\.x", "", colnames(Urban))

###### Join Inactives

Urban <- Urban %>%
  merge(U_In, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Urban)

Urban = Urban[,!grepl(".y$",names(Urban))]

colnames(Urban) <- sub("\\.x", "", colnames(Urban))

###### Join Employed

Urban <- Urban %>%
  merge(U_Em, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Urban)

Urban = Urban[,!grepl(".y$",names(Urban))]

colnames(Urban) <- sub("\\.x", "", colnames(Urban))

###### Join Other Activities

Urban <- Urban %>%
  merge(U_OA, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Urban)

Urban = Urban[,!grepl(".y$",names(Urban))]

colnames(Urban) <- sub("\\.x", "", colnames(Urban))

###### Join Other Income

Urban <- Urban %>%
  merge(U_OI, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Urban)

Urban = Urban[,!grepl(".y$",names(Urban))]

colnames(Urban) <- sub("\\.x", "", colnames(Urban))

###### Join House and Household

Urban <- Urban %>%
  merge(U_HH, 
        by = c("DIRECTORIO", "SECUENCIA_P"),
        all.x = TRUE
  ) 

summary(Urban)

Urban = Urban[,!grepl(".y$",names(Urban))]

colnames(Urban) <- sub("\\.x", "", colnames(Urban))


########## Merge the Rural Data Base #########

###### Join Unemployed

Rural <- R_GC %>%
  merge(R_Un, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Rural)

### Delete y vars with same names but incomplete obs

Rural = Rural[,!grepl(".y$",names(Rural))]

### Drop .x in repeated names

colnames(Rural) <- sub("\\.x", "", colnames(Rural))

###### Join Labor Force

Rural <- Rural %>%
  merge(R_LF, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Rural)

Rural = Rural[,!grepl(".y$",names(Rural))]

colnames(Rural) <- sub("\\.x", "", colnames(Rural))

###### Join Inactives

Rural <- Rural %>%
  merge(R_In, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Rural)

Rural = Rural[,!grepl(".y$",names(Rural))]

colnames(Rural) <- sub("\\.x", "", colnames(Rural))

###### Join Employed

Rural <- Rural %>%
  merge(R_Em, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Rural)

Rural = Rural[,!grepl(".y$",names(Rural))]

colnames(Rural) <- sub("\\.x", "", colnames(Rural))

###### Join Other Activities

Rural <- Rural %>%
  merge(R_OA, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Rural)

Rural = Rural[,!grepl(".y$",names(Rural))]

colnames(Rural) <- sub("\\.x", "", colnames(Rural))

###### Join Other Income

Rural <- Rural %>%
  merge(R_OI, 
        by = c("DIRECTORIO", "SECUENCIA_P", "ORDEN"),
        all.x = TRUE
  ) 

summary(Rural)

Rural = Rural[,!grepl(".y$",names(Rural))]

colnames(Rural) <- sub("\\.x", "", colnames(Rural))

###### Join House and Household

Rural <- Rural %>%
  merge(R_HH, 
        by = c("DIRECTORIO", "SECUENCIA_P"),
        all.x = TRUE
  ) 

summary(Rural)

Rural = Rural[,!grepl(".y$",names(Rural))]

colnames(Rural) <- sub("\\.x", "", colnames(Rural))

########## Woodwork Pre-append  #########

##### If needed, change the type of a column


##### Solve "CLASE" variable problem in incomplete datasets (March-July)

#Urban <- Urban %>%
 # mutate(CLASE = 1)

#Rural <- Rural %>%
 # mutate(CLASE = 2)

########## Append #########

### Final monthly base

#Rural$P6120 <- as.character(Rural$P6120) #Esto es solo para noviembre que tuvo problemas la base
#Rural$P6510S1 <- as.character(Rural$P6510S1)
#Rural$P6610S1 <- as.character(Rural$P6610S1)
#Rural$P6585S1A1 <- as.character(Rural$P6585S1A1)
#Rural$P6545S1 <- as.character(Rural$P6545S1)
#Rural$P6580S1 <- as.character(Rural$P6580S1)
#Rural$P7500S3A1 <- as.character(Rural$P7500S3A1)
#Rural$P750S1A1 <- as.character(Rural$P750S1A1)
#Rural$P5140 <- as.character(Rural$P5140)

GEIH <- bind_rows(Urban, Rural)

################################## Check test ##################################################################### 

### Check data with the DANE's PPTs

# National Data

GEIH %>%
  mutate(Pop = 1) %>%
  #group_by(CLASE) %>%
  summarise(Total.Pop = sum(Pop*FEX_C_2011, na.rm = TRUE)
  ) 


GEIH %>%
  summarise(Employed = sum(OCI*FEX_C_2011, na.rm = TRUE)
  ) 

GEIH %>%
  summarise(Unemployed = sum(DSI*FEX_C_2011, na.rm = TRUE)
  ) 

GEIH %>%
  summarise(Inactives = sum(INI*FEX_C_2011, na.rm = TRUE)
  ) 

# 13 Cities Data

Area %>%
  summarise(Employed = sum(OCI*FEX_C_2011, na.rm = TRUE)
  ) 

Area %>%
  summarise(Unemployed = sum(DSI*FEX_C_2011, na.rm = TRUE)
  ) 

Area %>%
  summarise(Inactives = sum(INI*FEX_C_2011, na.rm = TRUE)
  ) 

################################## Save the final base ###################################################################################

setwd("C:/Users/pjara/OneDrive/PNUD trabajo/Microsim/2020/ConsolidacionGEIH/Final")

write.csv2(GEIH, "GEIH Noviembre.csv", row.names = FALSE)

