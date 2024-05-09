# Uber Project 🚙
## Contributor
Maggie Huntley
## Introduction
This Analysis is looking over 6 Uber data sets from April  to September 2014. Through this analysis I will attempt to provide data trends by looking more deeply into variables such as Base, Date.Time, Date, Time, Hour, Month, Day of the Week, and the Week of the Year. 
## Problems that Occurred During Analysis 
I had one major problems occur during this Analysis 
1. I was not able to make a Geospatial Leaflet as every attempt made ended up freezing my R application and the only way to undo the freeze effect was to completely shut off my laptop. 
## Data Dictionary 📖
##### The columns I used in my analysis are as follows: 
1. Date.Time: The original column that holds the date and the time of the Uber trip. The format being Year-Month-Day Hour:Minute:Second 
2. Lat: The Latitude of the Uber trip 
3. Lon: The Longitude of the Uber trip
4. Base: A unique identifier of the Uber driver
###### The following columns are columns I created in order to aid in Analyzing the data. 
5. Date: A separate column for the Date of the Uber Trip that comes from the original Date.Time column. The date is in year-month-day format
6. Time: A separate column for the Time of the Uber Trip that occurred and comes from the original Date.Time column. The date is in hourH minuteM secondS format
7. Hour: A separate column for the Hour of the day of the Uber Trip that occurred and comes from the original Date.Time column. 
8. Month: A separate column for the Month the Uber Trip that occurred and comes from the original Date.Time column.
9. Day_of_Week: A separate column for the day of the Uber Trip that occurred and comes from the original Date.Time column. The format being “Mon”, “Tue”, “Wed”, “Thu”, “Fri”, “Sat”,  and  “Sun”
10. Week: A separate column for the week of the year  the Uber Trip that occurred and comes from the original Date.Time column. In number format, with the first week of the year being equivalent to 1 
## Data Cleaning 🧽
In order to clean the data and make it as usable as possible I did the following 3 manipulations: 
1. Binding the Data together: For this analysis I was provided with 6 CSV files that needed to be combined in order to complete the analysis. In order to accomplish this I imported all of the data and then I binded the data together using the following code: 
```
## Import Data 
uber1 <- read.csv('uber-raw-data-apr14.csv')
uber2 <- read.csv('uber-raw-data-aug14.csv')
uber3 <- read.csv('uber-raw-data-jul14.csv')
uber4 <- read.csv('uber-raw-data-jun14.csv')
uber5 <- read.csv('uber-raw-data-may14.csv')
uber6 <- read.csv('uber-raw-data-sep14.csv')

## Bind the data together 
uber_data <- bind_rows(uber1, uber2, uber3, uber4, uber5, uber6)
```

2. I changed the Date.time column to the POSIX format in order to get a date schema. 
```
uber_data$Date.Time <- as.POSIXct(uber_data$Date.Time, format = "%m/%d/%Y %H:%M:%S")

```
3. I made a necessary filter: I made a filter to remove any data that was from October as their was not enough data to accomplish an analysis on that month. 
```
uber_data <- uber_data %>%
  filter(!(format(Date, "%m") == "10"))

```
## Data Analysis 
My data analysis was completed in a Shiny App. 
All charts were made using the library ggplot2. 
The link to the shiny app is here: 
[Uber_Anlysis](https://huntleymargaret.shinyapps.io/Uber_Project/)
I was able to publish this Shiny App by turning all of my data cleaning and importing into a RDS and importing that into the file. 
## Conclusion 
In conclusion, Uber trips are higher overall in August compared to all other months. Uber trips are also higher during the week compared to weekdays. Uber trips are at a peak at 3-8pm. Uber trips should continue to increase in the coming months. Lastly Uber can use this analysis to help determine which areas they should increase research on and increase advertising for. 
