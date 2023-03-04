#libraries 
library(rvest)
library(stringr)
library(tidyverse)
library(here)

url <-("https://nypost.com/tag/fake-news/")

nyp <- read_html(url)

#page section
nyp %>%
  html_nodes(".section-heading--underline") %>%
  html_text()


#article headline
nyp %>%
  html_nodes(".story__headline.headline.headline--archive") %>%
  html_text()

#article links
nyp %>%
  html_nodes(".layout__item a") %>%
  html_attr("href") %>%
  as.character()

#article 1 test
art1 <- read_html("https://nypost.com/2022/11/10/trump-says-hes-still-a-stable-genius-denies-midterm-anger/")

# article 1 date
art1 %>%
  html_node(xpath='//*[@id="main"]/article/div/div/div[1]/div/div[1]/header/div[3]/div[3]/span[1]') %>%
  html_text()

#article 1 text
art1 %>%
  html_node(xpath='//*[@id="main"]/article/div/div/div[1]/div/div[3]') %>%
  html_text()

#article 2 test
art2 <- read_html("https://nypost.com/2022/11/03/joe-rogan-finally-admits-that-school-furry-litter-box-hoax-was-a-lie/")

#article 2 text
art2 %>%
  html_node(xpath='//*[@id="main"]/article/div/div/div[1]/div/div[3]') %>%
  html_text()

# article 2 date
art2 %>%
  html_node(".date.meta.meta--byline") %>%
  html_text()
