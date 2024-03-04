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
hand(deck2)

























