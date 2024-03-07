## Chapter 3 
## Atomic Vectors 
die <- c(1, 2, 3, 4, 5, 6)
die 
## 1 2 3 4 5 6 
is.vector(die) 
## TRUE
## returns true if object is an automatic vector 
five <- 5 
five
# 5 
is.vector(five)
## TRUE 
length(five)
## 1 
length(die)
## 6 
## creating an chracter vector 
int <- 1L 
text <- "ace" 
int <- c(1L, 5L)
text <- c("ace", "hearts")
sum(num)
## 6 
sum(text)
#Error in sum(text) : invalid 'type' (character) of argument


## Doubles 
die <- c(1, 2, 3, 4, 5, 6)
die 
## 1 2 3 4 5 6 
## typeof to figure out what kind of object you are working with 
typeof(die)
## "double" --> also known as "numerics" 
## Integers 
int <- c(-1L, 2L, 4L)
int
## -1 2 4 
typeof(int)
## "integer"
sqrt(2)^2 - 2
## 4.440892e-16 
## floating-point errors, avoid by avoiding decimals 


## Characters 
text <- c("Hello", "World")
text
## "Hello" "World" 
typeof(text)
## "character"
typeof("hello")
## "character"
## individual elements of a character is known as a string = ""


## Logicals 
3 > 4 
## FALSE 
logic <- c(TRUE, FALSE, TRUE)
logic
## TRUE FALSE  TRUE
typeof(logic)
## "logical" 
typeof(F)
## "logical" 


##Complex and Raw 
comp <- c(1 + 1i, 1 + 2i, 1 + 3i)
comp
## 1+1i 1+2i 1+3i
typeof(comp)
## "complex" 
raw(3)
## 00 00 00 
typeof(raw(3))
## "raw" 


## Exercise on pg 43 
hand <- c("ace", "king", "queen", "jack", "ten")
hand
## "ace"   "king"  "queen" "jack"  "ten" 
typeof(hand)
## "character"


## Attributes 
## will return null if an object has no attributes 
attributes(die)
## NULL


# Names 
## allows you to look up the value of the names attribute
names(die)
## NULL, meaning the die does not have a names attribute 
## adding a names attribute 
names(die) <- c("one", "two", "three", "four", "five", "six")
names(die)
## "one"   "two"   "three" "four"  "five"  "six"  
attributes(die)
## $names
## "one"   "two"   "three" "four"  "five"  "six"  
die 
## one   two three  four  five   six 
## 1     2     3     4     5     6 
names(die)<- c("uno", "dos", "tres", "quatro", "cinco", "seis")
die 
##  uno    dos   tres quatro  cinco   seis 
##   1      2      3      4      5      6 
## to remove attributes 
names(die) <- NULL 
die 
## 1 2 3 4 5 6


## Dim 
## (rows, columns, slices)
dim(die) <- c(2,3)
die
##       [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
dim(die) <- c(3,2)
die
##       [,1] [,2]
## [1,]    1    4
## [2,]    2    5
## [3,]    3    6
dim(die) <- c(1, 2, 3)
die
## , , 1
##
## [,1] [,2]
## [1,]    1    2
## 
## , , 2
## 
## [,1] [,2]
## [1,]    3    4
## 
## , , 3
## 
## [,1] [,2]
## [1,]    5    6


## Matrices 
#store values in 2D arrays 
m <- matrix(die, nrow = 2)
m
##       [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
m <- matrix(die, nrow = 2, byrow = TRUE)
m
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6


## Arrays 
ar <- array(c(11:14, 21:24, 31:34), dim = c(2,2,3))
ar
## , , 1
## 
## [,1] [,2]
## [1,]   11   13
## [2,]   12   14
## 
## , , 2
## 
## [,1] [,2]
## [1,]   21   23
## [2,]   22   24
## 
## , , 3
##
## [,1] [,2]
## [1,]   31   33
## [2,]   32   34


## Exercise pg 47 
hand1 <- c("ace", "king", "queen", "jack", "ten", "spades", "spades", "spades", "spades", "spades" )
matrix(hand1, nrow = 5)
matrix(hand1, ncol = 2)
dim(hand1) <- c(5,2)
##        [,1]    [,2]    
## [1,] "ace"   "spades"
## [2,] "king"  "spades"
## [3,] "queen" "spades"
## [4,] "jack"  "spades"
## [5,] "ten"   "spades"
hand2 <- c("ace", "spades", "king", "spades", "queen", "spades", "jack", "spades", "ten", "spades")
matrix(hand2, nrow = 5, byrow = TRUE)
matrix(hand2, ncol = 2, byrow = TRUE)
##       [,1]    [,2]    
## [1,] "ace"   "spades"
## [2,] "king"  "spades"
## [3,] "queen" "spades"
## [4,] "jack"  "spades"
## [5,] "ten"   "spades"


## Class 
dim(die) <- c(2,3)
typeof(die)
## "double" 
class(die)
## "matrix" 
attributes(die)
## $dim
## [1] 2 3
class("Hello")
## "character" 
class(5)
## "numeric" 


## Dates and Times 
now <- Sys.time()
now
## 2024-02-19 23:07:32 CST 
typeof(now)
## "double"
class(now)
## "POSIXct" "POSIXt" 
unclass(now)
## 1708405653
## removes the class 
mil <- 1000000
mil
## 1e+06
class(mil) <- c("POSIXct", "POSOXt")
mil
## "1970-01-12 07:46:40 CST"


## Factors 
## a type of class 
gender <- factor(c("male", "female", "male"))
typeof(gender)
## integer 
attributes(gender)
##$levels
## "female" "male"  
## 
## $class
## "factor"
unclass(gender)
## 2 1 2
## attr(,"levels")
## "female" "male" 
gender
## [1] male   female male 
## Levels: female male
as.character(gender)
## "male"   "female" "male"  


## Exercise pg 51
## makning the ace of hearts have a value of 1 
card <- c("ace", "heaerts", 1)
card
## "ace"     "heaerts" "1" 

## Coercion 
sum(c(TRUE, TRUE, FALSE, FALSE))
sum(c(1, 1, 0, 0))
## 2 
as.character(1)
## "1"
as.logical(1)
## TRUE 
as.numeric(FALSE)
## 0 


## Lists 
list1 <- list(100:130, "R", list(TRUE, FALSE))
list1
## [[1]]
## [1] 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114
## [16] 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129
## [31] 130
##
## [[2]]
## [1] "R"
##
## [[3]]
## [[3]][[1]]
## [1] TRUE
## 
## [[3]][[2]]
## [1] FALSE


## Exercise on page 54 
## store a single playing card
card <- list("ace", "hearts", 1)
card
## [[1]]
## [1] "ace"
## 
## [[2]]
## [1] "hearts"
## 
## [[3]]
## [1] 1


## Data Frames 
df <- data.frame(face = c("ace", "two", "six"), 
                 suit = c("clubs", "clubs", "clubs"), value = c(1, 2, 3))
df
##   face  suit value
## 1  ace clubs     1
## 2  two clubs     2
## 3  six clubs     3
typeof(df)
## "list" 
class(df)
## "data.frame"
str(df)
## 'data.frame':	3 obs. of  3 variables:
##   $ face : chr  "ace" "two" "six"
## $ suit : chr  "clubs" "clubs" "clubs"
## $ value: num  1 2 3
## stringsAsFactors prevents character strings being saved as factors 
df <- data.frame(face = c("ace", "two", "six"), 
                 suit = c("clubs", "clubs", "clubs"), value = c(1, 2, 3),
                 stringsAsFactors = FALSE)
deck <- data.frame(
  face = c("king", "queen", "jack", "ten", "nine", "eight", "seven", "six",
           "five", "four", "three", "two", "ace", "king", "queen", "jack", "ten",
           "nine", "eight", "seven", "six", "five", "four", "three", "two", "ace",
           "king", "queen", "jack", "ten", "nine", "eight", "seven", "six", "five",
           "four", "three", "two", "ace", "king", "queen", "jack", "ten", "nine",
           "eight", "seven", "six", "five", "four", "three", "two", "ace"),
  suit = c("spades", "spades", "spades", "spades", "spades", "spades",
           "spades", "spades", "spades", "spades", "spades", "spades", "spades",
           "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs",
           "clubs", "clubs", "clubs", "clubs", "clubs", "diamonds", "diamonds",
           "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", "diamonds",
           "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", "hearts",
           "hearts", "hearts", "hearts", "hearts", "hearts", "hearts", "hearts",
           "hearts", "hearts", "hearts", "hearts", "hearts"),
  value=c(13,12,11,10,9,8,7,6,5,4,3,2,1,13,12,11,10,9,8, 7,6,5,4,3,2,1,13,12,11,10,9,8,7,6,5,4,3,2,1,13,12,11, 10,9,8,7,6,5,4,3,2,1)
)
deck
##     face     suit value
## 1   king   spades    13
## 2  queen   spades    12
## 3   jack   spades    11
## 4    ten   spades    10
## 5   nine   spades     9
## 6  eight   spades     8
## 7  seven   spades     7
## 8    six   spades     6
## 9   five   spades     5
## 10  four   spades     4
## 11 three   spades     3
## 12   two   spades     2
## 13   ace   spades     1
## 14  king    clubs    13
## 15 queen    clubs    12
## 16  jack    clubs    11
## 17   ten    clubs    10
## 18  nine    clubs     9
## 19 eight    clubs     8
## 20 seven    clubs     7
## 21   six    clubs     6
## 22  five    clubs     5
## 23  four    clubs     4
## 24 three    clubs     3
## 25   two    clubs     2
## 26   ace    clubs     1
## 27  king diamonds    13
## 28 queen diamonds    12
## 29  jack diamonds    11
## 30   ten diamonds    10
## 31  nine diamonds     9
## 32 eight diamonds     8
## 33 seven diamonds     7
## 34   six diamonds     6
## 35  five diamonds     5
## 36  four diamonds     4
## 37 three diamonds     3
## 38   two diamonds     2
## 39   ace diamonds     1
## 40  king   hearts    13
## 41 queen   hearts    12
## 42  jack   hearts    11
## 43   ten   hearts    10
## 44  nine   hearts     9
## 45 eight   hearts     8
## 46 seven   hearts     7
## 47   six   hearts     6
## 48  five   hearts     5
## 49  four   hearts     4
## 50 three   hearts     3
## 51   two   hearts     2
## 52   ace   hearts     1


## Loading Data 

write.csv(deck, file = 'cards.csv', row.names = FALSE)


















