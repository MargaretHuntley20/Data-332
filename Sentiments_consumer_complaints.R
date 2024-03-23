#Import all necessary libraries 
library(tidytext)
library(here)
library(textdata)
library(reshape2)
library(dplyr)
library(RColorBrewer)
library(stringr)
library(tidyr)
library(wordcloud)
library(ggplot2)

#removes any objects from workplace 
rm(list=ls())

## import sentiments 
get_sentiments("bing")
get_sentiments("nrc")

## import text data 
setwd('~/Downloads/Data 332- R /DATA-332')
df_complaints<-read.csv('/Users/maggiehuntley/Downloads/Consumer_Complaints.csv')

# make the imported text data usable 
usable_complaints <- df_complaints %>%
  group_by(Company)%>%
  mutate(lineNumber=row_number()) %>%
  ungroup()%>%
  unnest_tokens(word, Issue)

# gather all joy sentiments 
nrc_joy <- get_sentiments("nrc") %>%
  filter(sentiment=="joy")

#count number of joy sentiments in the column that holds the complaint 
usable_complaints%>%
  filter(Company == "Ocwen") %>%
  inner_join(nrc_joy)%>%
  count(word, sort=TRUE)

#Only keep the complaints from the Ocwen Bank 
ocwen <- usable_complaints %>%
  filter(Company == "Ocwen")

#Joining the sentiments together in order to make a graph 
bing_and_nrc <- bind_rows(
  ocwen %>%
    inner_join(get_sentiments("bing"))%>%
    mutate(method ="Bing et al."), 
  ocwen %>%
    inner_join(get_sentiments("nrc") %>%
                 filter(sentiment %in% c("positive", 
                                         "negative"))
               
    ) %>%
    mutate(method = "NRC")) %>% 
  count(method, index = lineNumber %/% 80, sentiment) %>%
  pivot_wider(names_from = sentiment, 
              values_from = n, 
              values_fill = 0) %>%
  mutate(sentiment = positive-negative)

#Creating the first chart of sentiment analysis 
bind_rows(bing_and_nrc) %>%
  ggplot(aes(index, sentiment, fill = method)) +
  geom_col(show.legned = FALSE) +
  facet_wrap(~method, ncol = 1, scales = "free_y")

# Save the image to hard drive 
ggsave(here("bing_nrc_sentiment.png"))

#gather all sentiments 
get_sentiments("nrc") %>%
  filter(sentiment %in% c("positive", "negative")) %>%
  count(sentiment)

get_sentiments("bing") %>%
  count(sentiment)

#count each sentiment 
bing_word_counts <- usable_complaints %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()

#Graph Bing Sentiment 
bing_word_counts %>%
  group_by(sentiment) %>%
  slice_max(n, n = 10) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y")+
  labs(x = "Contribution to Sentiment", 
       y = NULL)

#save image to hard drive 
ggsave(here("positive_negative_bing_sentiment.png"))

# Make a word cloud 
usable_complaints %>%
  anti_join(stop_words) %>%
  count(word) %>%
  with(wordcloud(word, n, max.words= 50))

#save image
ggsave(here("Complaints_Word_Cloud.png"))









