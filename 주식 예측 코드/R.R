rm(list=ls())

#------------------------------------------library------------------------------------------#

library(lubridate)
library(httr)
library(rvest)
library(xts)
library(data.table)
library(dplyr)
library(prophet)

#------------------------------------------function------------------------------------------#

t2n <- function(x) { as.numeric( as.POSIXct(strptime(x, "%Y-%m-%d %H:%M:%OS")) )  }
n2t <- function(x) { format(as.POSIXct(x, origin = "1970-01-01 09:00:00", tz="UTC"), "%Y-%m-%d %H:%M:%OS") }

#------------------------------------------data------------------------------------------#

key = "005930"
url = paste0("https://fchart.stock.naver.com/sise.nhn?symbol=", key, "&timeframe=day&count=1000&requestType=0")
data = GET(url) %>% read_html %>% html_nodes("item") %>% html_attr("data") %>% strsplit("\\|")%>%head(970)

#------------------------------------------data-preprocessing------------------------------------------#

df = data.table( ds = sapply(data, function(x) { x[1] } ), y = sapply(data, function(x) { x[4] } ) )
df$y = df$y %>% as.double()

df$ds = paste(paste0(substr(df$ds, 1, 4), "-", substr(df$ds, 5, 6), "-", substr(df$ds, 7, 8)), "00:00:00")
df$ds_value = t2n(df$ds)

df = data.table( df %>% filter(y != 0) %>% filter( ds >= "2019-05-27" ) ); nrow(df)
n_pred = 90
df = rbind(df, data.table( ds = n2t( (seq( t2n(tail(df, 1)$ds) + 60*60*24*1, t2n(tail(df, 1)$ds) + 60*60*24*(n_pred), by = 60*60*24)) ), y= NA, ds_value = NA ))
df$ds_value = t2n(df$ds)

#------------------------------------------modeling------------------------------------------#

m = prophet( na.omit(df) , yearly.seasonality=T, weekly.seasonality = TRUE, daily.seasonality = TRUE )
m_pred = predict(m, df )
df$yhat = m_pred$yhat
data12 <- df[483:572]


