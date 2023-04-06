#libraries 
library(rvest)
library(stringr)
library(tidyverse)
library(here)

url <-("https://nypost.com/tag/fake-news/")
page2 <- ("https://nypost.com/tag/fake-news/page/2/")

nyp <- read_html(url)
nyp2 <- read_html(page2)

#page section
nyp %>%
  html_nodes(".section-heading--underline") %>%
  html_text()

#page section
nyp2 %>%
  html_nodes(".section-heading--underline") %>%
  html_text()


#article headline - remove \t from each line
nyp %>%
  html_nodes(".story__headline.headline.headline--archive") %>%
  html_text()

nyp2 %>%
  html_nodes(".story__headline.headline.headline--archive") %>%
  html_text()

#article links
links <- nyp %>%
  #html_nodes(".layout__item a") %>%
  html_nodes(".headline--archive a") %>%
  html_attr("href") %>%
  as.character()


#article dates
nyp %>%
  #html_nodes(".layout__item a") %>%
  html_nodes("span.meta.meta--byline") %>%
  html_text()

#article 1 test
art1 <- read_html("https://nypost.com/2022/11/10/trump-says-hes-still-a-stable-genius-denies-midterm-anger/")

# article 1 date
art1 %>%
  html_node("div.date.meta.meta--byline") %>%
  html_text(trim = TRUE)

#article 1 text
art1 %>%
  #html_node(xpath='//*[@id="main"]/article/div/div/div[1]/div/div[3]') %>%
  html_node("div.single__content.entry-content.m-bottom") %>%
  html_text(trim = TRUE)

#article 1 tag list
art1 %>%
  html_nodes("li.tag-list__tag") %>%
  html_text(trim = TRUE)

#article 2 test
art2 <- read_html("https://nypost.com/2021/12/14/hypocrisy-of-media-censors-claim-to-be-against-misinformation/")

#article 2 text
art2 %>%
  html_node("div.single__content.entry-content.m-bottom") %>%
  html_text()

#article 2 tag list
art2 %>%
  html_nodes("li.tag-list__tag") %>%
  html_text()

-----------------------------------------------------------------------------------------------------------------

#get all article titles
title <- nyp %>%
  html_nodes(".story__headline.headline.headline--archive") %>%
  html_text(trim = TRUE)

#get article dates
date <- nyp %>%
  #html_nodes(".layout__item a") %>%
  html_nodes("span.meta.meta--byline") %>%
  html_text(trim = TRUE)

#get article URLs
link <- nyp %>%
  #html_nodes(".layout__item a") %>%
  html_nodes(".headline--archive a") %>%
  html_attr("href") %>%
  as.character()

length(link)

nyp_vector <- data.frame(title, date, link)

article_list <- data.frame(matrix(ncol = 3, nrow = 0))
colnames(article_list) <- c('title', 'date', 'link')
article_list <- rbind(article_list, nyp_vector)
head(article_list)



-----------------------------------------------------------------------------------------------------------------
  
# function to collect articles
  
# empty dataframe with column names
article_list <- data.frame(matrix(ncol = 3, nrow = 0))
colnames(article_list) <- c('title', 'date', 'link' )


articles <- function() {
  #get url
  url <-("https://nypost.com/tag/fake-news/page/1")
  nyp <- read_html(url)
  
  #get all article titles
  a <- nyp %>%
    html_nodes(".story__headline.headline.headline--archive") %>%
    html_text(trim = TRUE)
  
  #get article dates
  b <- nyp %>%
    html_nodes("span.meta.meta--byline") %>%
    html_text(trim = TRUE)
  
  #get article URLs
  c <- nyp %>%
    html_nodes(".headline--archive a") %>%
    html_attr("href") %>%
    as.character()
  
  article <- read_html(c)
  
  for(i in 1:length(article)){
    
  } 
  
  d <- article %>%
    html_node("div.single__content.entry-content.m-bottom") %>%
    html_text()
  
  e <- article %>%
    html_nodes("li.tag-list__tag") %>%
    html_text()
  
  temp_df <- data.frame(a, b, c, d, e)
  article_list <- rbind(article_list, temp_df)
  
  return(article_list)
}

articles_return <- articles()

head(articles_return)
 