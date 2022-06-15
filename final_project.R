install.packages("ggplot2")
install.packages("dplyr")
install.packages("tidyverse")
install.packages("tidyr")
install.packages("lattice")
install.packages("gmodels")
install.packages("rcompanion")
install.packages("corrplot")
install.packages("PerformanceAnalytics")

library(ggplot2)
library(dplyr)
library(tidyverse)
library(tidyr)
library(lattice)
library(gmodels)
library(rcompanion)
library(corrplot)
library(PerformanceAnalytics)

rv<- c(5.7, 5.5, 5.4, 5.4, 5.6, 5.3, 5.2, 5.1, 5.0, 5.0, 5.1, 5.0)
mean(rv)

rv1 <- c(4.8, 4.9, 5.0, 5.1, 4.8,4.9, 4.8, 4.9, 5.0, 4.9, 4.7, 4.7)
mean(rv1)

rv2 <- c(4.7, 4.6, 4.4, 4.4, 4.4, 4.3, 4.3, 4.4, 4.3, 4.2, 4.2, 4.1)
mean(rv2)
##calculate average unemployment by year

df_unemployment = as.data.frame.matrix(unemployment)
##Turn unemployment data into data frame 

Avg <- c(5.275, 4.875, 4.358)
df_unemployment$Avg <- Avg
##Add unemployment average by year to dataframe 

str(df_unemployment)

df_combined = data.frame(df_unemployment$Year, df_unemployment$Avg)
##Dataframe for consolidated unemployment and recidivism data

df_recidivism = as.data.frame.matrix(recidisivm)
##Turn recidivism data into data frame

na.omit(df_recidivism)

df_recidivism1 <- rename(df_recidivism, c(year_admitted = Fiscal.Year.Admitted, conviction_classification = Convicting.Offense.Classification, conviction_type = Convicting.Offense.Type, conviction_subtype = Convicting.Offense.Subtype, race = Race...Ethnicity, supervision = Level.of.Supervision, prison_admission = Recidivism...Prison.Admission, recidivism_type = Recidivism.Type, days_to_recidivism = Days.to.Recidivism))
##Renaming columns

df_recidivism2 = data.frame(df_recidivism1$Recidivism_Year, df_recidivism1$conviction_subtype, df_recidivism1$race, df_recidivism1$prison_admission )
##Create new data frame for specific variables

df_recidivism3 <- rename(df_recidivism2, c(Year = df_recidivism1.Recidivism_Year, Conviction_Subtype = df_recidivism1.conviction_subtype, Race = df_recidivism1.race, Prison_Admission = df_recidivism1.prison_admission))
##Rename columns
df_combined1 <- rename(df_combined, c(Year = df_unemployment.Year, Average_Unemployment_Rate = df_unemployment.Avg))

df_recidivism3$Prison_Admission <- ifelse(df_recidivism3$Prison_Admission =="Yes", 1,0)
df_recidivism3
##Recoded data

df_recidivism4 <- df_recidivism3[df_recidivism3$Prison_Admission !=0,]

merge(df_combined1, df_recidivism4, by = "Year")

df_combined2 <- merge(df_combined1, df_recidivism4, by = "Year")

df_combined2 <- data.frame.as.csv