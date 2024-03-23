# Consumer Complaint Sentiment Analysis 
## Contributer
### Maggie Huntley 
## Introduction 
### we will use sentiment (BING and NRC) analysis to analyze complaints about banks to see weehter the complaints are positve or negative. 
## Dictionary 
### Date.Recieved: The date the complaint was recieved. 
### Prodcut: The product the complaint was made about. 
### Sub.product: More details about the prodcut the complaint was made about. 
### Issue: the issue the complaint was adressing 
### Sub.issue: More details about the issue made. 
### Consumer.complaint.narrative: the entire complaint that was made 
### Company.public.response: how the company chose to respond to the complaint. 
### Company: The company the complaint was made to. 
### State: The state the complaint was made in / the location of the location of the bank that the complaint was made about. 
### ZIP.code: The zip code the complaint was made in / the zip code 
### Tags: Inforamtion about the person who handeled the complaint 
### Consumer.consent.provided: wether or not consent was provided 
### Submitted.via: how the complaint was submitted 
### Date.sent.to.company: The day the company recieved teh compalint 
### Company.response.to.consumer: how the company responsed to the consumer's complaint.
### Timely.response.: wether or not it was a timly response to the complaint. 
### Consumer.disrupted: wether or not the consumer was disputed. 
### Complaint.ID: The ID that is attatched to the compalint. 
## Data Cleaning 
### Code used to clean the data: 
#### usable_complaints <- df_complaints %>%
####  group_by(Company)%>%
####  mutate(lineNumber=row_number()) %>%
####  ungroup()%>%
####  unnest_tokens(word, Issue)
### this code cleaned the data by taking each word of consumer.complaint.narrative into it's own row 
#### ocwen <- usable_complaints %>%
####  filter(Company == "Ocwen")
### this code was used to focus the sentiment analysis on Ocwen Bank 
## Data Analysis 
### BING and NRC Sentiment Analysis Graph 
![bing_nrc_sentiment](https://github.com/MargaretHuntley20/Data-332/assets/159860804/1f3594e2-a073-43f7-805e-fd2ecda84fb5)
#### This graph depicts how negative or positve the complaints on Ocwen Bank are 
#### If we use BING sentiment to analyze the complaints are results seems to be nothing but negative 
#### If we use NRC sentiment to analyze the complaints are results seems to be more positve than negative 
#### this graph shows us why it is important to use mulitple differnt sentiments to analyze the text 
### Postive and Negative BING Sentiment Analysis 
![positive_negative_bing_sentiment](https://github.com/MargaretHuntley20/Data-332/assets/159860804/47868a16-bf61-4d77-bae8-e678dc2d657c)
#### This grpah depicts which words are coming up most often on both the positve and negative side of BING sentiment 
#### This graph tells us that 'incorrect' comes up 75,000 + times and is the most often negative comment for Ocwen Banks 
#### This graphs tells us that 'protection' comes up less than 25,000 times, but is the postive word that comes up the most 
### Consumer Complaints Word Cloud 
<img width="488" alt="Screen Shot 2024-03-22 at 8 19 27 PM" src="https://github.com/MargaretHuntley20/Data-332/assets/159860804/b11200dd-d12d-4aac-ac07-cec7ad66d8d5">
#### This shows us some of the words that are used in the complaints that Ocwen Bank recieved 
## Conclusion 
### In conclusion text sentiments shows us what complaints occur most often which can lead banks and other companies to making the necessary improvements 
