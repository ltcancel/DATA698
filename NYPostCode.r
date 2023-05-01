#libraries 
library(rvest)
library(stringr)
library(tidyverse)
library(here)

url <-("https://nypost.com/tag/fake-news/page/")
page2 <- ("https://nypost.com/tag/fake-news/page/2/")

nyp <- read_html(url)
nyp2 <- read_html(page2)

# test pasting a new link
temp <- paste(url,as.character(2), sep = "")
url <- read_html(temp)
url

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

head(nyp_vector)


-----------------------------------------------------------------------------------------------------------------
# WORKS!!!!!!!!
  
article_list <- data.frame()
temp_list <- data.frame()
max <- 10
base <- "https://nypost.com/tag/fake-news/page/"

for(i in 1:max){
    temp <- paste(base, as.character(i), sep = "")
    url <- read_html(temp)
    
    #get all article titles
    a <- url %>%
      html_nodes(".story__headline.headline.headline--archive") %>%
      html_text(trim = TRUE)
    
    #get article dates
    b <- url %>%
      html_nodes("span.meta.meta--byline") %>%
      html_text(trim = TRUE)
    
    #get article URLs
    c <- url %>%
      html_nodes(".headline--archive a") %>%
      html_attr("href") %>%
      as.character()
    
    #dataframe of scraped articles
    temp_list <- cbind(a,b,c)
    article_list <- rbind(article_list,temp_list)
    
}


#################################################################################################################
# get article text for each row

all_text <- data.frame(matrix(ncol = 1,nrow = 0))
colnames(all_text) <- c('text')
#temp_list <- data.frame()

for(i in 1:nrow(article_list)){
  temp <- read_html(article_list[i,3])
  
  #get text
  a <- temp %>%
    html_node("div.single__content.entry-content.m-bottom") %>%
    html_text(trim = TRUE)
  
  #get tag list
  #article 1 tag list
  #b <- temp %>%
   # html_nodes("li.tag-list__tag") %>%
    #html_text(trim = TRUE)
  
 # temp_list <- cbind(temp_list,a,b)
  all_text <- rbind(all_text,a)
}

article_list[2,3]

#################################################################################################################
#final dataframe

master_list <- cbind(article_list, all_text)
colnames(master_list) <- c('title', 'date','url','text')
head(master_list)
