#################################################################################################################
##################################### GEIH MONTHLY FINAL STAGE #####################################################
#################################################################################################################

##### Load the packages

Pkgs <- c("ggplot2", "tidyverse", "dplyr", "highcharter", "hrbrthemes", "ggrepel", 
          "stringr", "skimr", "stats", "viridis", "haven", "readxl", "skimr", 
          "stats", "RColorBrewer", "plotly", "kableExtra", "bbplot", "ggpubr",
          "knitr", "broom", "ggthemes", "zoo", "readxl", "lubridate", "highcharter",
          "ggalt", "htmltools", "gridExtra", "tsibble")



lapply(Pkgs, library, character.only = TRUE)

##### Set working directory

setwd("C:/Users/OneDrive/PNUD/Microsim/2020/ConsolidacionGEIH/Final")

##### Load the data bases

Enero <- read.csv("GEIH Enero.csv", 
                 sep = ";", 
                 dec = ",") 


Febrero <- read.csv("GEIH Febrero.csv", 
                  sep = ";", 
                  dec = ",") 


Marzo <- read.csv("GEIH Marzo.csv", 
                  sep = ";", 
                  dec = ",") 


Abril <- read.csv("GEIH Abril.csv", 
                  sep = ";", 
                  dec = ",") 


Mayo <- read.csv("GEIH Mayo.csv", 
                  sep = ";", 
                  dec = ",") 


Junio <- read.csv("GEIH Junio.csv", 
                  sep = ";", 
                  dec = ",") 

Julio <- read.csv("GEIH Julio.csv", 
                  sep = ";", 
                  dec = ",") 

Agosto <- read.csv("GEIH Agosto.csv", 
                  sep = ";", 
                  dec = ",") 

Septiembre <- read.csv("GEIH Septiembre.csv", 
                   sep = ";", 
                   dec = ",") 
 
Octubre <- read.csv("GEIH Octubre.csv", 
                   sep = ";", 
                   dec = ",") 
 
Noviembre <- read.csv("GEIH Noviembre.csv", 
                   sep = ";", 
                   dec = ",") 
 
# Diciembre <- read.csv("GEIH Diciembre.csv", 
#                       sep = ";", 
#                       dec = ",") 

##Variable types

type_enero <- data.frame(sapply(Enero, class))
colnames(type_enero) <- c("type_Enero")
type_enero <- filter(type_enero, type_Enero == "character")

type_enero <- data.frame(rownames(type_enero),type_enero)

write.csv(type_enero, "type_enero.csv")

type_febrero <- data.frame(sapply(Febrero, class))
colnames(type_febrero) <- c("type_Febrero")
type_febrero <- filter(type_febrero, type_Febrero == "character")

type_Septiembre <- data.frame(sapply(Septiembre, class))
colnames(type_Septiembre) <- c("type_Septiembre")
type_Septiembre <- filter(type_Septiembre, type_Septiembre == "character")

type_Octubre <- data.frame(sapply(Octubre, class))
colnames(type_Octubre) <- c("type_Octubre")
type_Octubre <- filter(type_Octubre, type_Octubre == "character")

type_Noviembre <- data.frame(sapply(Noviembre, class))
colnames(type_Noviembre) <- c("type_Noviembre")
type_Noviembre <- filter(type_Noviembre, type_Noviembre == "character")

##### Consolidate the annual database

Enero[1:369] <- sapply(Enero[1:369],as.numeric)

Febrero[1:369] <- sapply(Febrero[1:369],as.numeric)

Marzo[1:369] <- sapply(Marzo[1:369],as.numeric)

Abril[1:369] <- sapply(Abril[1:369],as.numeric)

Mayo[1:369] <- sapply(Mayo[1:369],as.numeric)

Junio[1:369] <- sapply(Junio[1:369],as.numeric)

Julio[1:369] <- sapply(Julio[1:369],as.numeric)

Agosto[1:369] <- sapply(Agosto[1:369],as.numeric)
 
Septiembre[1:369] <- sapply(Septiembre[1:369],as.numeric)
 
Octubre[1:369] <- sapply(Octubre[1:369],as.numeric)
 
Noviembre[1:369] <- sapply(Noviembre[1:369],as.numeric)
 
# Diciembre[1:369] <- sapply(Diciembre[1:369],as.numeric)

##### Annual Base

GEIH <- bind_rows(Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, 
                  Agosto, Septiembre, Octubre, Noviembre)

write.csv2(GEIH, "GEIH Anual Ene-Nov 2021.csv", row.names = FALSE)


