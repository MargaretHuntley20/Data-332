library(dplyr)
library(ggplot2)
library(readxl)

rm(list = ls())
## Set working Directory 
setwd('~/Downloads/Data 332- R /DATA-332/Patient_biling_data_project /Patient_Billing_Data')

## read excel sheets 
df_billing <- read_excel("Billing.xlsx")
df_patient <- read_excel("Patient.xlsx")
df_visit <- read_excel("Visit.xlsx")

## read text 
df_visit_text<- readLines("visit.txt")


## Left joining visit into patient and left joining billing into patient 
df <- left_join(df_visit, df_patient, by = c('PatientID'))%>%
  left_join(df_billing, df, by= c('VisitID'))


##reason for visit segmented (stacked bar chart) by month of the year. 
#df$Visit.Month <- gsub('2020-', " ", df$VisitDate) 
#view(df)

#reason for visit by month of year
## get month by itself 
df$Visit.Month <- gsub('^\\d{4}-(\\d{2})-\\d{2}', '\\1', as.character(df$VisitDate))
view(df)

## get visits grouped together by similarities 


## make visit by month pivot table 
df_Visit_Month<- df%>%
  select(VisitDate, Reason, Visit.Month)
## make visit by month chart 
ggplot(df_Visit_Month, aes(x = Reason, y = VisitDate , fill = Visit.Month)) + 
  geom_col()+
  labs(title = "Reason for Visit by Month", x = "Reason", y = "Count")+
  theme(axis.text = element_text(angle = 90, vjust = .5, hjust = 1))


## Reason for visit based on walk in or not. 

## Reason for visit based on City/State or zip code

## Total invoice amount based on reason for visit. Segmented (stacked bar chart) with it was paid. 

## And student is to find one insight into the data that they find interesting. In a chart. 
