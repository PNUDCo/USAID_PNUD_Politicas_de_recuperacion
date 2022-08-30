#################################################################################################################
##################################### GEIH MONTHLY STANDARIZATION #####################################################
#################################################################################################################

##### Load the packages

rm(list=ls())

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

setwd("C:/Users/OneDrive/PNUD/Microsim/2020/ConsolidacionGEIH/Final")

GEIH2021 <- read.csv("GEIH Anual Ene-Nov 2021.csv", 
                     sep = ";", 
                     dec = ",") 

## Bogota population

GEIH2021 %>%
  filter(AREA == 11) %>%
  filter(MES == 9) %>%
  summarise(Pop = sum(FEX_C_2011, na.rm = TRUE))

GEIH2021 %>%
  filter(AREA == 11) %>%
  filter(MES == 10) %>%
  summarise(Pop = sum(FEX_C_2011, na.rm = TRUE))

GEIH2021 %>%
  filter(AREA == 11) %>%
  filter(MES == 11) %>%
  summarise(Pop = sum(FEX_C_2011, na.rm = TRUE))

GEIH2021_Sept <- GEIH2021 %>%
  filter(AREA == 11) %>%
  filter(MES == 9)

table(GEIH2021$MES)

### Check data with the DANE's PPTs

# National Data

GEIH2021 %>%
  filter(MES == 11) %>%
  summarise(Employed = sum(OCI*FEX_C_2011, na.rm = TRUE)
  ) 

GEIH2021 %>%
  filter(MES == 11) %>%
  summarise(Unemployed = sum(DSI*FEX_C_2011, na.rm = TRUE)
  ) 

GEIH2021 %>%
  filter(MES == 11) %>%
  summarise(Inactives = sum(INI*FEX_C_2011, na.rm = TRUE)
  ) 

GEIH2021 %>%
  filter(AREA == 11) %>%
  filter(MES == 11) %>%
  summarise(Pop = sum(FEX_C_2011, na.rm = TRUE))





