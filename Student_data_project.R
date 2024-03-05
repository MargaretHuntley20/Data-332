library(dplyr)
library(ggplot2)
library(readxl)

rm(list = ls())
## Set working directory 
setwd('~/Downloads/Data 332- R /DATA-332/Student_data_project /Student_data ')

## read excel sheets 
df_course <- read_excel("Course.xlsx", .name_repair = "universal")
df_registration <- read_excel("Registration.xlsx", .name_repair = "universal")
df_student <- read_excel("Student.xlsx", .name_repair = "universal")

view(df_course)
view(df_registration)
view(df_student)




## Left joining registration into students and then left join course into students 
df <- left_join(df_registration, df_student, by = c('Student.ID'))%>%
  left_join(df_course, by = c('Instance.ID'))
view (df)



## make a graph of majors 
## make a pivot table of number of majors 
df_major_pivots <- df %>%  
  group_by(Title) %>%
  summarize(count = n()) 
view(df_major_pivots)
## make a graph 
ggplot(df_major_pivots, aes(x = Title, y = count , fill = Title)) + 
  geom_col()+
  labs(title = "Amount of Students in Each Major", x = "Major", y = "Amount of Students")+
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))



## make a chart on birth years and students 
## get birth year by itself 
df$Birth.Year <- gsub('-.*', " ", df$Birth.Date)
view(df)
## make a pivot table of number of majors 
df_birth_year_students_pivots <- df %>%  
  group_by(Birth.Year) %>%
  summarize(count = n()) 
view(df_birth_year_students_pivots)
## make a graph 
ggplot(df_birth_year_students_pivots, aes(x = Birth.Year, y = count , fill = Birth.Year)) + 
  geom_col()+
  labs(title = "Birth Years of Students", x = "Birth Year", y = "Amount of Students")+
  theme(axis.text = element_text(angle = 90, vjust = .5, hjust = 1))



## make a chart on total cost per major, segment by payment plant
##amount_using_payment_plan <- sum(df$Payment.Plan == TRUE, na.rm = TRUE)

## Make pivot table fir cost per major segmented by payement plan
df_cost_per_major_pivots <- df %>%  
  select(Title, Total.Cost, Payment.Plan)

View(df_cost_per_major_pivots)

## make graph for cost per major segemented by payment plan 
ggplot(df_cost_per_major_pivots, aes(x = Title, y = Total.Cost , fill = Payment.Plan)) + 
  geom_col()+
  labs(title = "Cost per Major", x = "Major", y = "Cost")+
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))



##Total balance due by major, segment by payment plan 
## make pivot table of major, balance, and payment plan 
df_balance_due_per_major_pivots <- df %>%  
  select(Title, Balance.Due, Payment.Plan)

View(df_balance_due_per_major_pivots)

## make segmented chart of major balance, and payment plan 
ggplot(df_balance_due_per_major_pivots, aes(x = Title, y = Balance.Due , fill = Payment.Plan)) + 
  geom_col()+
  labs(title = "Balance due per Major", x = "Major", y = "Balance Due")+
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))











