library(dplyr)
library(lubridate)
library(tidyr)
library(ggplot2)
library(shiny)



setwd('~/Downloads/Data 332- R /DATA-332/Uber_Project')

## Import Data 
uber1 <- read.csv('uber-raw-data-apr14.csv')
uber2 <- read.csv('uber-raw-data-aug14.csv')
uber3 <- read.csv('uber-raw-data-jul14.csv')
uber4 <- read.csv('uber-raw-data-jun14.csv')
uber5 <- read.csv('uber-raw-data-may14.csv')
uber6 <- read.csv('uber-raw-data-sep14.csv')



## Bind the data together 
uber_data <- bind_rows(uber1, uber2, uber3, uber4, uber5, uber6)



## Changing the date column to a data schema 
## Make it a POSIX format 
uber_data$Date.Time <- as.POSIXct(uber_data$Date.Time, format = "%m/%d/%Y %H:%M:%S")

## Make 2 columns for date and time 
uber_data$Date <- as.Date(uber_data$Date.Time)
uber_data$Time <- format(uber_data$Date.Time, "%H:%M:%S")

## Remove the original Date Column 
#uber_data$Date.Time <- NULL

## clean data, fix all time formats, and make columns needed 
# Get time in correct format 
uber_data$Time <- hms(uber_data$Time)
# Make column for time 
uber_data$Hour <- hour(uber_data$Time)
# get date in the correct fromat
uber_data$Date <- as.Date(uber_data$Date)
# Make column for month
uber_data$Month <- month(uber_data$Date)
# Make column for day of the week 
uber_data$Day_of_Week <- wday(uber_data$Date.Time, label = TRUE)
# get week of the year 
uber_data$Week <-  week(uber_data$Date)
## Remove October data  
uber_data <- uber_data %>%
  filter(!(format(Date, "%m") == "10"))


saveRDS(uber_data, "uber_data.rds")
