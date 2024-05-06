library(dplyr)
library(lubridate)
library(tidyr)
library(ggplot2)
library(shiny)



#setwd('~/Downloads/Data 332- R /DATA-332/Uber_Project')

## Improt Data 
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
## Remove october data  
uber_data <- uber_data %>%
  filter(!(format(Date, "%m") == "10"))

## CHART NUMBER 1: trips per hour by month 
## Make a pivot table to display trips by hour
trips_by_hour <- uber_data %>%
  group_by(Hour, Month) %>%
  summarise(trips_count = n())
## make chart displaying trips per hour per month 
ggplot(trips_by_hour, aes(x = Month, y = trips_count , fill = Hour)) + 
  geom_col()+
  labs(title = "Trips per month by hour", x = "Month", y = "Uber Trips", fill = 'Hour')+
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

## CHART NUMBER 2: trips per hour 
## Make a chart displaying trips per hour   
ggplot(trips_by_hour, aes(x = Hour, y = trips_count, fill = trips_count)) + 
  geom_col() +
  labs(title = "Trips per hour", x = "Hour", y = "Uber Trips", fill = "Trips") +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

## CHART NUMBER 3: plot everyday 
## make pivot for plot chart 
plot_days <- uber_data %>%
  group_by(Date) %>%
  summarise(trips_count = n())
## Make a plot chart displaying every day of the month 
ggplot(plot_days, aes(x = Date, y = trips_count)) +
  geom_line() + 
  labs(title = "Trips Taken During 2014", x = "Day of the Year", y = "Number of Trips")

# CHART NUMBER 4: every day of month 
# Make column for month
uber_data$Day_of_the_month <- day(uber_data$Date)
## Make a pivot table that displays trips per day of month
trips_by_day <- uber_data %>%
  group_by(Day_of_the_month, Month) %>%
  summarise(trips_count = n())
## Make a chart that displaying trips per day of month 
ggplot(trips_by_day, aes(x = Day_of_the_month, y = trips_count, fill = Month)) + 
  geom_col() +
  labs(title = "Trips by Day of the Month", x = "Day of the Month", y = "Uber Trips", fill = "Month") +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

## CHART NUMBER 5: X = Month Y = Day of Week 
## make pivot table for day of the week and month 
DOW_and_Month <- uber_data %>%
  group_by(Month, Day_of_Week) %>%
  summarise(trips_count = n())
## add levels to the day of the week 
DOW_and_Month$Day_of_Week <- factor(DOW_and_Month$Day_of_Week, levels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"))
## make chart showing DOW and Month 
ggplot(DOW_and_Month, aes(x = Month, y = trips_count, fill = Day_of_Week)) + 
  geom_col() +
  labs(title = "Trips per Day of Week and Month", x = "Month of the Year", y = "Uber Trips", fill = "Day of the Week") +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))


## CHART NUMBER 6: Trips by month 
## make a chart that display trips by month 
ggplot(trips_by_day, aes(x = Month, y = trips_count)) + 
  geom_col(fill = 'lightblue') +
  labs(title = "Trips by Month", x = "Month of the year", y = "Uber Trips") +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))


## CHART NUMBER 7: Bases and Month 
## Make a pivot table that displays base and month
trips_by_base <- uber_data %>%
  group_by(Base, Month) %>%
  summarise(trips_count = n())
## Make a chart that displaying trips per day of month 
ggplot(trips_by_base, aes(x = Base, y = trips_count, fill = Month)) + 
  geom_col() +
  labs(title = "Trips by Base and Month", x = "Base", y = "Uber Trips", fill = "Month of the Year") +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

## CHART 8: Heat map of hour and Day 
## pivot for hour and day 
trips_by_hour_day<- uber_data %>%
  group_by(Hour, Day_of_the_month) %>%
  summarise(trips_count = n())
## heat map by hour and day 
ggplot(trips_by_hour_day, aes(x = Day_of_the_month, y = Hour, fill = trips_count)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "red") + # Adjust color gradient as needed
  labs(title = "Heatmap of Hour and Day", x = "Day of the Month", y = "Hour", fill = "Uber Trips")

## CHART NUMBER 9: heat map of Month and Day 
## pivot table for heat map of month and Day of month
heat_day_month <- uber_data %>%
  group_by(Month, Day_of_the_month) %>%
  summarise(trips_count = n())
## make heat map for month and day of the month
ggplot(heat_day_month, aes(x = Month, y = Day_of_the_month, fill = trips_count)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "red") +
  labs(title = "Heatmap of Month and Day of the month", x = "Month of the Year", y = "Day of the Month", fill = " Uber Trips")

## CHART NUMBER 10: heat map of Month and Week 
## Pivot table for month and week 
heat_month_week <- uber_data %>% 
  group_by(Week, Month) %>% 
  summarise(trips_count = n())
## Make heat map for month and week 
ggplot(heat_month_week, aes(x = Week, y = Month, fill = trips_count)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "red") + # Adjust color gradient as needed
  labs(title = "Heatmap of Month and Week of the Year", x = "Week of the Year", y = "Month of the Year", fill = " Uber Trips")

## CHART 11: bases and day of the week 
## Pivot for base and day of week 
base_heat<- uber_data %>%
  group_by(Base, Day_of_Week) %>%
  summarise(trips_count = n())
## heat map by base and day of week  
ggplot(base_heat, aes(x = Base, y = Day_of_Week, fill = trips_count)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "red") + # Adjust color gradient as needed
  labs(title = "Heatmap of Base and Day of the Week", x = "Base", y = "Day of the Week", fill = " Uber Trips")

## CHART 12: Geo spacial 


## make a shiny app 
ui <- fluidPage(
  
  titlePanel("Uber Trips Analysis"),
  
  # sidebarLayout(
  #   sidebarPanel(
  #     # You can add inputs for user interaction here if needed
  #   ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Trips by Hour and Month",
               plotOutput("tripsbyhourandmonth")),
      tabPanel("Trips by Hour",
               plotOutput("hourPlot")),
      tabPanel("Plot of everyday of each month",
               plotOutput("everydaymonth")),
      tabPanel("Trips by Day of Month",
               plotOutput("DayOfMonthPlot")),
      tabPanel("Trips by Day of the Week and Month",
               plotOutput("Dayofweekandmonth")),
      tabPanel("Trips by Month",
               plotOutput("monthPlot")),
      tabPanel("Trips by Base",
               plotOutput("basePlot")),
      tabPanel("Heatmap of Hour and Day",
               plotOutput("hourDayHeatmap")),
      tabPanel("Heatmap of Month and Day",
               plotOutput("monthDayHeatmap")),
      tabPanel("Heatmap of Month and Week of the Year",
               plotOutput("heatdayofweek")),
      tabPanel("Heatmap of Bases and Day of the Week",
               plotOutput("heatbases"))
    )
  )
)
#)

server <- function(input, output) {
  
  # Load and preprocess the data
  # This part remains the same as your initial script
  
  # Rendering plots
  output$hourPlot <- renderPlot({
    ggplot(trips_by_hour, aes(x = Hour, y = trips_count, fill = trips_count)) + 
      geom_col() +
      labs(title = "Trips per hour", x = "Hour", y = "Uber Trips", fill = "Trips") +
      theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
  })
  
  output$dayOfMonthPlot <- renderPlot({
    ggplot(trips_by_day, aes(x = Day_of_the_month, y = trips_count, fill = Month)) + 
      geom_col() +
      labs(title = "Trips by Day of the Month", x = "Day of the Month", y = "Uber Trips", fill = "Month") +
      theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
  })
  
  output$monthPlot <- renderPlot({
    ggplot(trips_by_day, aes(x = Month, y = trips_count)) + 
      geom_col(fill = 'lightblue') +
      labs(title = "Trips by Month", x = "Month of the year", y = "Uber Trips") +
      theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
  })
  
  output$basePlot <- renderPlot({
    ggplot(trips_by_base, aes(x = Base, y = trips_count, fill = Month)) + 
      geom_col() +
      labs(title = "Trips by Base and Month", x = "Base", y = "Uber Trips", fill = "Month of the Year") +
      theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
  })
  
  output$hourDayHeatmap <- renderPlot({
    ggplot(trips_by_hour_day, aes(x = Day_of_the_month, y = Hour, fill = trips_count)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "red") + # Adjust color gradient as needed
      labs(title = "Heatmap of Hour and Day", x = "Day of the Month", y = "Hour", fill = "Uber Trips")
  })
  
  output$monthDayHeatmap <- renderPlot({
    ggplot(heat_day_month, aes(x = Month, y = Day_of_the_month, fill = trips_count)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "red") + # Adjust color gradient as needed
      labs(title = "Heatmap of Month and Day of the month", x = "Month of the Year", y = "Day of the Month", fill = " Uber Trips")
  })
  output$tripsbyhourandmonth <- renderPlot({
    ggplot(trips_by_hour, aes(x = Month, y = trips_count , fill = Hour)) + 
      geom_col()+
      labs(title = "Trips per month by hour", x = "Month", y = "Uber Trips", fill = 'Hour')+
      theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
  })
  output$DayOfMonthPlot <- renderPlot({
    ggplot(trips_by_day, aes(x = Day_of_the_month, y = trips_count, fill = Month)) + 
      geom_col() +
      labs(title = "Trips by Day of the Month", x = "Day of the Month", y = "Uber Trips", fill = "Month") +
      theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
  })
  output$heatbases <- renderPlot({
    ggplot(base_heat, aes(x = Base, y = Day_of_Week, fill = trips_count)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "red") + # Adjust color gradient as needed
      labs(title = "Heatmap of Base and Day of the Week", x = "Base", y = "Day of the Week", fill = " Uber Trips")
  })
  output$heatdayofweek <- renderPlot({
    ggplot(heat_month_week, aes(x = Week, y = Month, fill = trips_count)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "red") + # Adjust color gradient as needed
      labs(title = "Heatmap of Month and Week of the Year", x = "Week of the Year", y = "Month of the Year", fill = " Uber Trips")
  })
  output$everydaymonth <- renderPlot({
    ggplot(plot_days, aes(x = Date, y = trips_count)) +
      geom_line() + 
      labs(title = "Trips Taken During 2014", x = "Day of the Year", y = "Number of Trips")
  })
  output$Dayofweekandmonth <- renderPlot({
    ggplot(DOW_and_Month, aes(x = Month, y = trips_count, fill = Day_of_Week)) + 
      geom_col() +
      labs(title = "Trips per Day of Week and Month", x = "Month of the Year", y = "Uber Trips", fill = "Day of the Week") +
      theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
  })
  
  # You can add more renderPlot functions for additional visualizations here
}

shinyApp(ui, server)
