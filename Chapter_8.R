## Chapter 8 
play()
## "BB" "BB" "BB"
##  25
one_play <- play()
## "B" "B" "0"
one_play
## 0 

## The S3 System 
num <-1000000000
print(num)
## 1e+09
class(num) <- c("POSIXct", "POSIXt")
print(num)
## "2001-09-08 20:46:40 CDT"

## Attributes 
attributes(DECK)
# $names
# [1] "face"  "suit"  "value"
# 
# $class
# [1] "data.frame"
# 
# $row.names
# [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19
# [20] 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38
# [39] 39 40 41 42 43 44 45 46 47 48 49 50 51 52
row.names(DECK)
# [1] "1"  "2"  "3"  "4"  "5"  "6"  "7"  "8"  "9"  "10" "11"
# [12] "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22"
# [23] "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33"
# [34] "34" "35" "36" "37" "38" "39" "40" "41" "42" "43" "44"
# [45] "45" "46" "47" "48" "49" "50" "51" "52"
row.names(DECK) <- 101:152
levels(DECK) <- c("level 1", "level 2", "level 3")
attributes(DECK)
# $names
#  "face"  "suit"  "value"
# 
# $class
#  "data.frame"
# 
# $row.names
#  101 102 103 104 105 106 107 108 109 110 111 112 113 114
#  115 116 117 118 119 120 121 122 123 124 125 126 127 128
#  129 130 131 132 133 134 135 136 137 138 139 140 141 142
#  143 144 145 146 147 148 149 150 151 152
# 
# $levels
#  "level 1" "level 2" "level 3"
one_play <- play()
one_play 
## 0 
attributes(one_play)
## NULL 
attr(one_play, "symbols") <- c("B", "0", "B")
attributes(one_play)
## $symbols
## "B" "0" "B"
attr(one_play, "symbols")
## "B" "0" "B"
one_play
## [1] 0
## attr(,"symbols")
## [1] "B" "0" "B"
one_play + 1 
## 1
## attr(,"symbols")
## "B" "0" "B"
play <- function() {
  symbols <- get_symbols()
  prize <- score(symbols) 
  attr(prize, "symbols") <- symbols 
  prize
}
play() 
#  [1] 0
# attr(,"symbols")
# [1] "0" "B" "0"
two_play <- play()
two_play
# [1] 10
# attr(,"symbols")
# [1] "B" "B" "B"
play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols)
}
three_play <- play()
three_play
# [1] 0
# attr(,"symbols")
# [1] "BB" "0"  "B" 
slot_display <- function(prize){ 
  # extract symbols
  symbols <- attr(prize, "symbols")
 
   # collapse symbols into single string
  symbols <- paste(symbols, collapse = " ")
 
   # combine symbol with prize as a regular expression
  # \n is regular expression for new line (i.e. return or enter) 
  string <- paste(symbols, prize, sep = "\n$")
  # display regular expression in console without quotes
  cat(string)
}
slot_display(one_play)
# B 0 B
# $0
symbols <- attr(one_play, 'symbols')
symbols 
## "B" "0" "B"
symbols <- paste(symbols, collaspe = ' ')
symbols 
## "B  " "0  " "B  "
prize <- one_play 
string <- paste(symbols, prize, sep = '\n$')
string 
## [1] "B  \n$0" "0  \n$0" "B  \n$0"
cat(string)
# B  
# $0 0  
# $0 B  
# $0
slot_display(play())
## 0 0 0
## $0
slot_display(play())
##BBB B BB
## $5
slot_display(play())
# BBB 0 0
# $0


## Generic Functions 
print(pi)
# 3.141593
pi
# 3.141593

print(head(deck))
# face   suit value
# 1  king spades    13
# 2 queen spades    12
# 3  jack spades    11
# 4   ten spades    10
# 5  nine spades     9
# 6 eight spades     8

head(deck)
# face   suit value
# 1  king spades    13
# 2 queen spades    12
# 3  jack spades    11
# 4   ten spades    10
# 5  nine spades     9
# 6 eight spades     8

print(play())
# [1] 0
# attr(,"symbols")
# [1] "0" "B" "0"

play()
# attr(,"symbols")
# [1] "BBB" "0"   "B


## Methods 
print 
# function (x, ...) 
#   UseMethod("print")
# <bytecode: 0x12df0a968>
#   <environment: namespace:base>
print.POSIXct
# function (x, tz = "", usetz = TRUE, max = NULL, ...) 
# {
#   if (is.null(max)) 
#     max <- getOption("max.print", 9999L)
#   FORM <- if (missing(tz)) 
#     function(z) format(z, usetz = usetz)
#   else function(z) format(z, tz = tz, usetz = usetz)
#   if (max < length(x)) {
#     print(FORM(x[seq_len(max)]), max = max + 1, ...)
#     cat(" [ reached 'max' / getOption(\"max.print\") -- omitted", 
#         length(x) - max, "entries ]\n")
#   }
#   else if (length(x)) 
#     print(FORM(x), max = max, ...)
#   else cat(class(x)[1L], "of length 0\n")
#   invisible(x)
# }
# <bytecode: 0x12eea20f0>
methods(print)


## Method Dispatch 
class(one_play) <- "slots"
args(print)
# function (x, ...) 
#   NULL
print.slots <- function(x, ...){
  cat("I'm using the print.slots method")
}

print(one_play)
## I'm using the print.slots method
one_play
## I'm using the print.slots method
rm(print.slots)
now <- Sys.time()
attributes(now)
# $class
# [1] "POSIXct" "POSIXt"
print.slots <- function(x,...){
  slot_display(x)
}
one_play
## B 0 B
## $0
play <- function(){
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols, class = 'slots')
}
class(play())
## "slots"
play()
## 0 B 0
## $0
play()
# BB 0 0
# $0


## Classes 
methods(class = 'factor')
# [1] [             [[            [[<-          [<-           all.equal    
#                                                [6] as.character  as.data.frame as.Date       as.list       as.logical   
#                                                [11] as.POSIXlt    as.vector     c             coerce        droplevels   
#                                                [16] format        initialize    is.na<-       length<-      levels<-     
#                                                  [21] Math          Ops           plot          print         relevel      
#                                                [26] relist        rep           scale_type    show          slotsFromS3  
#                                                [31] summary       Summary       xtfrm        
#                                                see '?methods' for accessing help and source code
play1 <- play()                                               
play1                                               
## 0 0 0
## $0    
play2 <- play()
play2
# 0 0 0
# $0
c(play1, play2)
# [1] 0 0
play[1]
## 00 




















                                               