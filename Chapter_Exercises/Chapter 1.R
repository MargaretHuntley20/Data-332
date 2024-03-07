1+1

100:130

5-
1  

3%5

2*3
##6

4-1
##3

6/(4-1)
##2

##Exercise on page 6 
((8+2)*3)-6
##24
24/3

##Model Exercise page 7
10+12
##22 
22*3
##36
36-6
##30
30/3
##10

##begin making dice 
1:6

#objects 
a<-1 
a
##1
a+2
##3

##save the die numbers into an object 
die <- 1:6 

die
# 1 2 3 4 5 6 

##capitalization and objects 
Name <- 1 
name<- 0 

Name + 1
##2

##overriding 
my_number <- 1
my_number
##1

my_number<- 999
my_number 
## 999

ls()
#"a"         "df"        "die"       "my_number" "name"      "Name"  

##working with die 
die-1
## 0 1 2 3 4 5
die/2
## 0.5 1.0 1.5 2.0 2.5 3.0
die*die
## 1  4  9 16 25 36

##Vector recycling 
1:2
## 1 2

1:4
## 1 2 3 4 

die 
## 1 2 3 4 5 6

die + 1:2
## 2 4 4 6 6 8

die + 1:4
## 2 4 6 8 6 8
##Warning message:
##In die + 1:4 :
##  longer object length is not a multiple of shorter object length


## Inner and outer multiplication 
die %*% die
## 91 
## inner 

die %o% die 
##   [,1] [,2] [,3] [,4] [,5] [,6]
##[1,]    1    2    3    4    5    6
##[2,]    2    4    6    8   10   12
##[3,]    3    6    9   12   15   18
##[4,]    4    8   12   16   20   24
##[5,]    5   10   15   20   25   30
##[6,]    6   12   18   24   30   36
## outer 

## Functions 
round(3.1415)
## 3

factorial(3)
## 6 

mean(1:6)
## 3.5 

round(mean(die))
## 4 

## Roll the dice 
sample(x = 1:4, size = 2) 
## 4 3 

sample(x = die, size = 1)
## 3 
## 4 

##using or not naming arguments 
sample(die, size = 1)
## 3

round(3.1415, corners = 2)
##Error in round(3.1415, corners = 2) : unused argument (corners = 2)

## Looking up functions
args(round)
## function (x, digits = 0) 
## NULL

## overriding a 0 round 
round(3.1415, digits = 2)
## 3.14 

## The importance of writing out arguments 
sample(die, 1)
## 5 
sample(size = 1, x = die)
## 1 

## Sample With Replacement 
sample(die, size = 2) 
## 1 6 
## with out replacement the 2 numbers will never be the same 

sample(die, size = 2, replace = TRUE)
## 4 4 
# with replacement you can get doubles 

## Final step of making a die 
dice <- sample(die, size = 2, replace = TRUE)
dice 
## 5 4 

sum(dice)
## 9 

dice
## 5 4

dice
## 5 4 
## object has been saved to 5 and 4 meaning dice will not re roll 

## Writing your own functions 
die <- 1:6
dice <- sample(die, size = 2, replace = TRUE)
sum(dice)

#The function constructor 
my_function <- function() {}

roll <- function(){
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}
roll()
## 5 

roll()

## function(){
##die <- 1:6
##dice <- sample(die, size = 2, replace = TRUE)
##sum(dice)
##}

roll()
## 8 

## checking to make sure the final lien of code returns a value 
dice
1+1
sqrt(2)
## these return values 

dice <- sample(die, size = 2, replace = TRUE)
two <- 1+1
a <- sqrt(2)
#does not return a value, saves value as object 

## Arguments 
roll2 <- function () {
  dice <- sample (bones, size = 2, replace = TRUE)
  sum(dice)
}
roll2()
#Error in roll2() : object 'bones' not found

roll2 <- function (bones) {
  dice <- sample (bones, size = 2, replace = TRUE)
  sum(dice)
}
roll2(bones = 1:4)
## 6 

roll2(bones = 1:6)
## 5 

roll2(bones= 1:20)
## 25

roll2()
##Error in roll2() : argument "bones" is missing, with no default

#giving bones a default value 
roll2 <- function (bones = 1:6) {
  dice <- sample (bones, size = 2, replace = TRUE)
  sum(dice)
}

roll2()
## 8 

