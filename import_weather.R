rm(list=ls())

library(rvest)
library(tidyverse)

### 2021 ###
url21<-"http://nw3weather.co.uk/wxdataday.php?vartype=tmean&year=2021"

w21<-read_html(url21)

w21 <- w21 %>% html_nodes("table")
w21 <- w21[[3]]%>% html_table

colnames(w21)<-w21[1,]
w21<-w21[2:32,]

full21<-w21%>%
  gather(key=month, value=temp, -Day)%>%
  mutate(date=paste(Day,month,"2021", sep="-"))%>%
  mutate(date=as.Date(date, format="%d-%b-%Y"))%>%
  select(-Day, -month)

### 2020 ###
url20<-"http://nw3weather.co.uk/wxdataday.php?vartype=tmean&year=2020"

w20<-read_html(url20)

w20 <- w20 %>% html_nodes("table")
w20 <- w20[[3]]%>% html_table

colnames(w20)<-w20[1,]
w20<-w20[2:32,]

full20<-w20%>%
  gather(key=month, value=temp, -Day)%>%
  mutate(date=paste(Day,month,"2020", sep="-"))%>%
  mutate(date=as.Date(date, format="%d-%b-%Y"))%>%
  select(-Day, -month)

### 2019 ###
url19<-"http://nw3weather.co.uk/wxdataday.php?vartype=tmean&year=2019"
w19<-read_html(url19)
w19 <- w19 %>% html_nodes("table")
w19 <- w19[[3]]%>% html_table
colnames(w19)<-w19[1,]
w19<-w19[2:32,]

full19<-w19%>%
  gather(key=month, value=temp, -Day)%>%
  mutate(date=paste(Day,month,"2019", sep="-"))%>%
  mutate(date=as.Date(date, format="%d-%b-%Y"))%>%
  select(-Day, -month)

### 2018 ###
url18<-"http://nw3weather.co.uk/wxdataday.php?vartype=tmean&year=2018"
w18<-read_html(url18)
w18 <- w18 %>% html_nodes("table")
w18 <- w18[[3]]%>% html_table
colnames(w18)<-w18[1,]
w18<-w18[2:32,]

full18<-w18%>%
  gather(key=month, value=temp, -Day)%>%
  mutate(date=paste(Day,month,"2018", sep="-"))%>%
  mutate(date=as.Date(date, format="%d-%b-%Y"))%>%
  select(-Day, -month)



##### Merge all datasets ########
full<-bind_rows(full18, full19, full20, full21)%>%
  mutate(temp=as.numeric(temp))%>%
  filter(!is.na(temp))

##### Graph data ########
full%>%
  ggplot(aes(date, temp))+
  geom_line()+
  theme_bw()+
  labs(x="",y="", title="Average daily temperature, London")
