library(dplyr)
library(lubridate)
library(tidyr)
library(ggplot2)
library(shiny)

uber_data <- readRDS("uber_data.rds")


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
    labs(title = "Trips per Hour", x = "Hour", y = "Uber Trips", fill = "Trips") +
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

## CHART 12: Predictive Analysis 
predictive_pivot <- uber_data %>%
  group_by(Date.Time) %>%
  summarise(trips_count = n())

x <- predictive_pivot$Date.Time
y <- predictive_pivot$trips_count

# Fit a linear regression model
predict_model <- lm(y ~ x, data = predictive_pivot)

# Make predictions
uber_predictions <- predict(predict_model, newdata = predictive_pivot)


# Create a scatter plot with regression line
ggplot(predictive_pivot, aes(x = x, y = y)) +
  geom_point() +
  geom_line(aes(y = uber_predictions), color = "red") +
  labs(title = "Predictive Analysis with Linear Regression",
       x = "Date and Time of Uber",
       y = "The amount of Ubers")


## make a shiny app 
ui <- fluidPage(
  
  titlePanel("2014 Uber Trip Data Analysis "),
  
    mainPanel(
      tabsetPanel(
        tabPanel("Trips by Hour and Month",
                 plotOutput("tripsbyhourandmonth"),textOutput('des1')),
        tabPanel("Trips by Hour",
                 plotOutput("hourPlot"), textOutput('des2')),
        tabPanel("Plot of Everyday of Each Month",
                 plotOutput("everydaymonth"), textOutput("des3")),
        tabPanel("Trips by Day of Month",
                 plotOutput("DayOfMonthPlot"), textOutput('des4')),
        tabPanel("Trips by Day of the Week and Month",
                 plotOutput("Dayofweekandmonth"), textOutput('des5')),
        tabPanel("Trips by Month",
                 plotOutput("monthPlot"), textOutput("des6")),
        tabPanel("Trips by Base",
                 plotOutput("basePlot"), textOutput('des7')),
        tabPanel("Heatmap of Hour and Day",
                 plotOutput("hourDayHeatmap"), textOutput('des8')),
        tabPanel("Heatmap of Month and Day",
                 plotOutput("monthDayHeatmap"), textOutput('des9')),
        tabPanel("Heatmap of Month and Week of the Year",
                 plotOutput("heatdayofweek"), textOutput({'des10'})),
        tabPanel("Heatmap of Bases and Day of the Week",
                 plotOutput("heatbases"), textOutput({'des11'})),
        tabPanel("Predictive Analysis",
                 plotOutput('Predict'),textOutput({'des12'}))
      )
    )
  )


server <- function(input, output) {
  
  # Load and preprocess the data
  # This part remains the same as your initial script
  
  # Rendering plots
  output$hourPlot <- renderPlot({
    ggplot(trips_by_hour, aes(x = Hour, y = trips_count, fill = trips_count)) + 
      geom_col() +
      labs(title = "Trips per Hour", x = "Hour", y = "Uber Trips", fill = "Trips") +
      theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
  })
  output$des1 <- renderText({
    "This bar chart depicts Uber trips taken each month from April to September split by hour of the day. 
    Through this chart we can see that as time goes on Uber trips rise. 
    One reason this could be is that as the temperture begins to cool people are less likely to walk to their destination making an Uber trip more desireable. 
    This graph also shows that more Ubers are taken later into the day rather than in the morning."
  })
  
  output$dayOfMonthPlot <- renderPlot({
    ggplot(trips_by_day, aes(x = Day_of_the_month, y = trips_count, fill = Month)) + 
      geom_col() +
      labs(title = "Trips by Day of the Month", x = "Day of the Month", y = "Uber Trips", fill = "Month") +
      theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
  })
  output$des2 <- renderText({
    "This bar chart depicts Uber trips taken at each hour of the day. Uber trips begin to increase more significantly at around 1pm with the peak of Uber trips being at 5pm. 
    This peak makes sense as it is the time that the average American is getting off of work. 
    This chart also helps to support the Trips by Hour and Month chart as it shows that more Ubers are taken later in the day.
    Another smaller peak is from 7am to 8am, which is another time of day the average American is commuting to work."
  })
  
  output$monthPlot <- renderPlot({
    ggplot(trips_by_day, aes(x = Month, y = trips_count)) + 
      geom_col(fill = 'lightblue') +
      labs(title = "Trips by Month", x = "Month of the year", y = "Uber Trips") +
      theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
  })
  output$des6 <- renderText({
    "This bar chart shows Uber trips by month. 
    The most amount of Uber trips for this section of time was in October, 
    where as the least amount of trips taken for this section of time was in April. 
    This graph also shows that from April to September Uber trips are increasing. 
    This provides information on what month Uber should look more into and 
    what month they should try to increase trips."
  })
  
  output$basePlot <- renderPlot({
    ggplot(trips_by_base, aes(x = Base, y = trips_count, fill = Month)) + 
      geom_col() +
      labs(title = "Trips by Base and Month", x = "Base", y = "Uber Trips", fill = "Month of the Year") +
      theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
  })
  output$des7 <- renderText({
    "This bar chart shows Uber trips based on Base and split by month. 
    The graph provides us with infromation such as bases B02598, B02617, and B0682 more popular than bases BO2512 and BO2764. 
    We can also use this graph to show that bases B02617 and B02764 increase in Uber trips further in the year whereas Bases B02512, B02598, and B0682 stayed consistent through out each month."
  })
 
  
  output$hourDayHeatmap <- renderPlot({
    ggplot(trips_by_hour_day, aes(x = Day_of_the_month, y = Hour, fill = trips_count)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "red") + # Adjust color gradient as needed
      labs(title = "Heatmap of Hour and Day", x = "Day of the Month", y = "Hour", fill = "Uber Trips")
  })
  output$des8 <- renderText({
    "This heat map shows Uber trips spread out across hour of the day and day of the month. 
    What we can gather from this graph is that Uber trips are taken during the same time of the day no matter the day of the month. 
    This can be said as the color is the same for each hour of the day when reading it horizontally. 
    This heat map also shows that people take the most Ubers between 3pm and 8pm and the least Ubers from 12am to 5am, 
    which makes sense as people are commuting to work and participating in after work activities during the time of 3-8pm, 
    where as most people are sleeping from 12-5am."
  })
  
  output$monthDayHeatmap <- renderPlot({
    ggplot(heat_day_month, aes(x = Month, y = Day_of_the_month, fill = trips_count)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "red") + # Adjust color gradient as needed
      labs(title = "Heatmap of Month and Day of the month", x = "Month of the Year", y = "Day of the Month", fill = " Uber Trips")
  })
  output$des9 <- renderText({
    "This heat map provides infromation on Uber trips compared to day of the month and month of the year. 
    This graph helps us to determine weak spots in Uber trips. 
    It clearly lays out white sections, which are sections where trips are less often than other times. 
    It also helps to determine when there are more Uber trips due to the dark red sections on the map. 
    This heat map also helps show that trips are incresing over the months as the chart gets darker as you read it from left to right."
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
  output$des4 <- renderText({
    "This bar chart shows Uber trips and each day of the month split by month. 
    This graph adds more evidence to October having more Uber trips compared to all other months. 
    This chart shows that the day of the month has little to no impact on Uber trips taken as all days are almost equal in Uber trips."
  })
  output$heatbases <- renderPlot({
    ggplot(base_heat, aes(x = Base, y = Day_of_Week, fill = trips_count)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "red") + # Adjust color gradient as needed
      labs(title = "Heatmap of Base and Day of the Week", x = "Base", y = "Day of the Week", fill = " Uber Trips")
  })
  output$des11 <- renderText({
    "This heatmap privides infomation on Uber trip bases compared to the day of the week. 
    This graph provides infomation such as the middle 3 bases provided more Uber trips than the outer 2 bases. 
    Through this heatmap we can see that base B02764 has more trips Thursday, Friday, and Saturday, compared to the rest of the week. 
    We can also learn that Base B02598 has the most trips on Thursday and Friday as well. 
    Overall we can gather that there are more Uber trips happening Tuesday through Friday compared to the rest of the week, 
    this might be becasue the Average American commutes to work monday-friday."
  })
  output$heatdayofweek <- renderPlot({
    ggplot(heat_month_week, aes(x = Week, y = Month, fill = trips_count)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "red") + # Adjust color gradient as needed
      labs(title = "Heatmap of Month and Week of the Year", x = "Week of the Year", y = "Month of the Year", fill = " Uber Trips")
  })
  output$des10 <- renderText({
    "This heatmap shows Uber Trips over week of the year compared to month of the year. 
    This shape is produced as the week of the year and month of the year are segmented measurements. 
    It shows us that Uber trips increased over the months of the year as you go from top to bottom the red gets darker meaning more trips. 
    It also shows what weeks and months that have the least amount of Uber trips. 
    Through this chart we can determine the frist week or two in April did not have many trips along with the first week or two in June as well."
  })
  output$everydaymonth <- renderPlot({
    ggplot(plot_days, aes(x = Date, y = trips_count)) +
      geom_line() + 
      labs(title = "Trips Taken During 2014", x = "Day of the Year", y = "Number of Trips")
  })
  output$des3 <- renderText({
    "This Line Plot Chart shows trips taken everyday between April and Septermber. 
    Overall Uber trips increase from April to the end of September. 
    This graph privides more information about the increase in Uber trips over time. 
    It shows not only the days that Uber trips are peaking each month, 
    but also which days of the month have major decreases as well. 
    One major decrease is at the begining of July. 
    I think this could be due to Forth of July, many people travel during the forth of July. 
    July 4th was on a Friday in 2014 meaning that people got the day off from work, which also means Ubers were not needed for commuting. 
    Having a graph that shows not only the peaks, but also the lows can help Uber investigate those days to figure out why that is occuring 
    and further more it helps them come up with a plan to increase trips on those days and months the following year."
  })
  output$Dayofweekandmonth <- renderPlot({
    ggplot(DOW_and_Month, aes(x = Month, y = trips_count, fill = Day_of_Week)) + 
      geom_col() +
      labs(title = "Trips per Day of Week and Month", x = "Month of the Year", y = "Uber Trips", fill = "Day of the Week") +
      theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
  })
  output$des5 <- renderText({
    "This bar chart depicts Uber trips taken each month split by day of the week.
    Through this graph we are able to learn that Ubers are taken more ofen during the week rather than the weekend, with the most popular days of the week being Wednesday through Thursday.
    This is important to know because Uber can now investigate why less Ubers are taken on Saturday-Tuesday and can research ways to promote and increase trips on those days of the week."
  })
  output$Predict <- renderPlot({
    ggplot(predictive_pivot, aes(x = x, y = y)) +
      geom_point() +
      geom_line(aes(y = uber_predictions), color = "red") +
      labs(title = "Predictive Analysis with Linear Regression",
           x = "Date and Time of Uber",
           y = "The amount of Ubers")
  })
  output$des12 <- renderText({
    "This graph shows the linear regression through all of the Uber trips taken between April 2014 - May 2014. 
    Through this graph it shows the amount of Uber trips taken each date and time of the time period. 
    The red line shows that Uber trips have been increasing over time and should continue to do so in October."
  })
}

shinyApp(ui, server)

