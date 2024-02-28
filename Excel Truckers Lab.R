library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(stringr)


rm(list = ls())
## setting up working directory 
setwd('~/Downloads/Data 332- R /DATA-332/Data ')
## use view(df_truck) to see the spreadsheet in R 
## Using sheet 2 skipping the first 3 rows 
df_truck <- read_excel("NP_EX_1-2.xlsx", sheet = 2, skip = 3, .name_repair = "universal")

## Selecting first 4 columns to the 15th column 
df <- df_truck[, c(4:15)]
## deslecting columns 
df <- subset(df, select = -c(...10))
## getting difference of days within a column
date_min <- min(df$Date)
date_max <-max(df$Date)
number_of_days_on_the_road <- date_max - date_min
print (number_of_days_on_the_road)

## another way of getting difference of days 
days <- difftime(max(df$Date), min(df$Date))
print (days)
number_of_days_recodred<-nrow(df)
print(number_of_days_recodred)

## find hours of driving 
total_hours <- sum(df$Hours)
print (total_hours)

## get average of hours per day 
avg_hours_per_day_recorded <- round(total_hours / number_of_days_recodred, digits = 3)
print (avg_hours_per_day_recorded)

## adding a column for cost of fuel 
df$fuel_cost <- df$Gallons * df$Price.per.Gallon

## add tolls, misc, and fuel cost together to get total cost 
df$total_cost <- df$Tolls + df$Misc + df$fuel_cost

## Running analysis based on state or city, splitting data 
df[c('warehouse', 'starting_city_state')] <- str_split_fixed(df$Starting.Location, ",", 2)

## getting total gallons consumed 
total_gallons_consumed <- sum(df$Gallons)
print(total_gallons_consumed)

## total miles driven 
total_miles_driven_per_drive <- df$Odometer.Ending - df$Odometer.Beginning
total_miles_driven <- sum(total_miles_driven_per_drive)
print(total_miles_driven)

## miles per gallon 
miles_per_gal <- total_miles_driven/total_gallons_consumed
print(miles_per_gal)

## total cost per mile 
cost_of_gallons_per_state <- df$Gallons*df$Price.per.Gallon
total_cost_of_gallons <- sum(cost_of_gallons_per_state)
total_cost_of_gallons_and_more <- total_cost_of_gallons + df$total_cost
full_total <- sum(total_cost_of_gallons_and_more)
print (full_total)
cost_per_mile <- full_total / total_miles_driven 
print(cost_per_mile)

## cleaning the data, getting state by itself, String extract, g sub 
df$starting_city_state <- gsub(',', "", df$starting_city_state)

## make 2 columns, one for state and one for city 
df[c('warehouse', 'starting_city_state')] <- str_split_fixed(df$starting_city_state, "", 2)

df$starting_city_state <- gsub(",", "", df$starting_city_state)

df_starting_pivots <- df %>% ## %>% = pipe 
  group_by(starting_city_state) %>%
  summarize(count = n(), 
            mean_size_hours = mean(Hours, na.rm = TRUE), 
            sd_hours = sd(Hours, na.rm = TRUE), 
            total_hours = sum(Hours, na.rm = TRUE), 
            total_gallons = sum(Gallons, na.rm = TRUE)
            )

ggplot(df_starting_pivots, aes(x = starting_city_state, y = count )) + 
  geom_col()+
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
view(df_starting_pivots)



## delivering location pivot 
## df[c('store_name', 'city_state_of_store"')] <- str_split_fixed(df$Delivery.Location, ",", 2)

## df$delivery_store_and_location <- gsub(',', "", df$delivery_store_and_location)

df[c('delivery_warehouse', 'delivery_city_state')] <- str_split_fixed(df$Delivery.Location, ",", 2)

df$delivery_city_state <- gsub(",", "", df$delivery_city_state)

df_delivery_pivots <- df %>% ## %>% = pipe 
  group_by(delivery_city_state) %>%
  summarize(count = n(), 
            mean_size_hours = mean(Hours, na.rm = TRUE), 
            sd_hours = sd(Hours, na.rm = TRUE), 
            total_hours = sum(Hours, na.rm = TRUE), 
            total_gallons = sum(Gallons, na.rm = TRUE)
  )

ggplot(df_delivery_pivots, aes(x = delivery_city_state, y = count )) + 
  geom_col()+
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

  view(df_delivery_pivots)  

