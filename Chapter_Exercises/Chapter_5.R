## Chapter 5 
## Changing Values in Place 
vec <- c(0, 0, 0, 0, 0, 0)
vec
## 0 0 0 0 0 0
vec[1]
## 0 
vec[1] <- 1000
vec
## 1000    0    0    0    0    0
vec[c(1, 3, 5)] <- c(1, 1, 1)
vec
## 1 0 1 0 1 0
vec[7] <- 0
vec
## 1 0 1 0 1 0 0
deck2$new <- 1:52 
head(deck2)
##  face     suit value new
## 3   jack   spades    11   1
## 29  jack diamonds    11   2
## 37 three diamonds     3   3
## 25   two    clubs     2   4
## 40  king   hearts    13   5
## 12   two   spades     2   6
deck2$new <- NULL 
head(deck2)
##   face     suit value
## 3   jack   spades    11
## 29  jack diamonds    11
## 37 three diamonds     3
## 25   two    clubs     2
## 40  king   hearts    13
## 12   two   spades     2
deck[c(13, 26, 39, 52),]
##  face     suit value
## 13  ace   spades     1
## 26  ace    clubs     1
## 39  ace diamonds     1
## 52  ace   hearts     1
deck2[c(13, 26, 39, 52), 3]
deck2$value[c(13,26, 39, 52)]
