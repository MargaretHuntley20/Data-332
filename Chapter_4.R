## Chapter 4
## Selecting Values 
deck[,]


##Positive Integers 
head(deck)
## face   suit value
## 1  king spades    13
## 2 queen spades    12
## 3  jack spades    11
## 4   ten spades    10
## 5  nine spades     9
## 6 eight spades     8
deck[1,1]
## "king"
deck[1, c(1, 2, 3)]
##  face   suit value
## 1 king spades    13
deck[c(1,1), c(1, 2, 3)]
##     face   suit value
## 1   king spades    13
## 1.1 king spades    13
vec <- c(6, 1, 3, 6, 10, 5)
vec[1:3]
## 6 1 3 
deck [1:2, 1:2]
##   face   suit
##  king spades
##  queen spades
deck [1:2, 1]
## to select 1 column 
#3 "king"  "queen" 
deck [1:2, 1, drop = FALSE]
## do this to return a data frame 
## face 
## king 
## queen 


## Negative integers 
deck[-(2:52), 1:3]
## face suit value 
## 1 king spades 13 
deck[c(-1,1), 1]
## Error in xj[i] : only 0's may be mixed with negative subscripts


## Zero 
deck[0, 0]
## data frame with 0 columns and 0 rows


## Blank Spaces 
## great for extracting entire rows or columns form a data frame
deck[1, ]
##  face   suit value
##  1 king spades    13


## Logical values 
deck[1, c(TRUE, TRUE, FALSE)]
## face   suit 
## 1 king spades 
rows <- c(TRUE, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F)
deck[rows, ]
## face    suit  value 
## 1 king spades   13 


## Names 
deck[1, c('face', 'suit', 'value')]
##  face   suit value
## 1 king spades    13
deck[, 'value']
## [1] 13 12 11 10  9  8  7  6  5  4  3  2  1
## [14] 13 12 11 10  9  8  7  6  5  4  3  2  1
## [27] 13 12 11 10  9  8  7  6  5  4  3  2  1
## [40] 13 12 11 10  9  8  7  6  5  4  3  2  1


## Deal a Card 
deal <- function(cards){
  cards[1, ] 
}
deal(deck)
## face   suit  value 
## 1 king spades   13
deal(deck)
## face   suit  value 
## 1 king spades   13
deal(deck)
## face   suit  value 
## 1 king spades   13


## Shuffle the Deck 
deck2 <- deck [1:52, ]
head(deck2)
##   face   suit value
## 1  king spades    13
## 2 queen spades    12
## 3  jack spades    11
## 4   ten spades    10
## 5  nine spades     9
## 6 eight spades     8
deck3 <- deck[c(2, 1, 3:52), ]
head(deck3)
## face   suit value
## 2 queen spades    12
## 1  king spades    13
## 3  jack spades    11
## 4   ten spades    10
## 5  nine spades     9
## 6 eight spades     8
random <- sample(1:52, size = 52)
random
## [1]  9 42 17 51 31  4 26 33 32 16 39 36 28 11 18 25 14 12 23 27
## [21]  6 24 30 21 40 46 49 48 43  5 10 35 22 45 19 44  1 37 13 41
## [41] 50 20  7 15  3  2 47 34 52 29  8 38
deck4 <- deck[random, ]
head(deck4)
##    face     suit value
## 9  five   spades     5
## 42 jack   hearts    11
## 17  ten    clubs    10
## 51  two   hearts     2
## 31 nine diamonds     9
## 4   ten   spades    10
shuffle <- function(cards){
  random <- sample(1:52, size = 52)
  cards[random, ]
}
deal(deck)
##  face   suit value
## 1 king spades    13
deck2 <- shuffle(deck)
deal(deck2)
## face     suit value
## 38  two diamonds  2


## Dollar Signs and Double Brackets 
deck$value
## [1] 13 12 11 10  9  8  7  6  5  4  3  2  1 13 12 11 10  9  8  7
## [21]  6  5  4  3  2  1 13 12 11 10  9  8  7  6  5  4  3  2  1 13
## [41] 12 11 10  9  8  7  6  5  4  3  2  1
mean(deck$value)
## 7 
median(deck$value)
## 7 
lst <- list(numbers = c(1,2), logical = TRUE, strings = c("a", "b", "c"))
lst
## $numbers
## [1] 1 2
## 
## $logical
## [1] TRUE
## 
## $strings
## [1] "a" "b" "c"
lst[1]
## $numbers
## [1] 1 2
sum(lst[1])
##Error in sum(lst[1]) : invalid 'type' (list) of argument
lst$numbers
## 1 2 
sum(lst$numbers)
## 3 
lst[[1]]
## 1 2 
lst["numbers"]
## $numbers
## [1] 1 2
lst[["numbers"]]
## 1 2 



















