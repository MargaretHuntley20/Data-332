## Chapter 2 
## download Packages 
install.packages("ggplot2")

## Library 
qplot
## Error: object 'qplot' not found

library("ggplot2")
## no news is the goal 

qplot
## a lot of code 
## qplot makes "quick plots" 

## Make a scatterplot 
x <- c(-1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1)
x
## -1.0 -0.8 -0.6 -0.4 -0.2  0.0  0.2  0.4  0.6  0.8  1.0

y <- x^3 
y
## -1.000 -0.512 -0.216 -0.064 -0.008  0.000  0.008  0.064  0.216  0.512  1.000

qplot(x,y)

## Make a Histogram 
x <- c(1, 2, 2, 2, 3, 3)
qplot(x, binwidth = 1)

x2 <- c(1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 4)
qplot(x2, binwidth = 1)

## Exercise pg 27 
x3 <- c(0, 1, 1, 2, 2, 2, 3, 3, 4)
qplot(x3, binwidth = 1)

# Replicate 
replicate (3, 1+1)
## 2 2 2 

replicate (10, roll())
## 8 5 5 9 7 5 5 8 4 5

## plotting 10,000 rolls 
rolls <- replicate (10000, roll())
qplot(rolls, binwidth = 1)

## Getting help with Help pages 
?sqrt
?log10
?sample

## Parts of a help page 
??log
## use 2 ?s when you have forgotten the name of the function 

## Looking through Sample help page 
?sample

## Exercise on pg 32
roll <- function(){
  die <- 1:6 
  dice <- sample (die, size = 2, replace = TRUE)
  sum(dice)
}

## Weighting the dice 
roll <- function(){
  die <- 1:6 
  dice <- sample (die, size = 2, replace = TRUE,
                  prob = c(1/8, 1/8, 1/8, 1/8, 1/8, 3/8))
  sum(dice)
}

## Visualizing weighted dice 
rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)
