# Load required libraries
library(tidyverse)
library(tidytext)
library(readxl)

# Load the movie_review dataset
movie_review <- read_excel("C:/Users/hp/Desktop/work/movie_review.xlsx")

# Tokenize and unnest the review text
movie_review_tokens <- movie_review %>%
  unnest_tokens(word, text)

# Load the pre-trained Bing lexicon for sentiment analysis
bing_lexicon <- get_sentiments("bing")


# Perform sentiment analysis on the tokenized words
movie_review_sentiment <- movie_review_tokens %>%
  inner_join(bing_lexicon, by = "word", multiple = "all") %>%
  group_by(fold_id, cv_tag, html_id) %>%
  summarise(sentiment_score = sum(sentiment == "positive") - sum(sentiment == "negative"))

# View the results
head(movie_review_sentiment)

library(ggplot2)

ggplot(movie_review_sentiment, aes(x = sentiment_score)) +
  geom_histogram(binwidth = 1, fill = "lightblue", color = "black") +
  labs(title = "Sentiment Score Distribution",
       x = "Sentiment Score",
       y = "Frequency")







