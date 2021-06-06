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

time_to_number <- function(x) { as.numeric( as.POSIXct(strptime(x, "%Y-%m-%d %H:%M:%OS")) )  }
number_to_time <- function(x) { format(as.POSIXct(x, origin = "1970-01-01 09:00:00", tz="UTC"), "%Y-%m-%d %H:%M:%OS") }

#------------------------------------------data------------------------------------------#

key = "207940"
url = paste0("https://fchart.stock.naver.com/sise.nhn?symbol=", key, "&timeframe=day&count=1000&requestType=0")
data = GET(url) %>% read_html %>% html_nodes("item") %>% html_attr("data") %>% strsplit("\\|")%>%head(940)
#------------------------------------------data-preprocessing------------------------------------------#

df = data.table( ds = sapply(data, function(x) { x[1] } ), y = sapply(data, function(x) { x[4] } ) )
df$y = df$y %>% as.double()

df$ds = paste(paste0(substr(df$ds, 1, 4), "-", substr(df$ds, 5, 6), "-", substr(df$ds, 7, 8)), "00:00:00")
df$ds_value = time_to_number(df$ds)

df = data.table( df %>% filter(y != 0) %>% filter( ds >= "2018-01-01" ) ); nrow(df)
n_pred = 90
df = rbind(df, data.table( ds = number_to_time( (seq( time_to_number(tail(df, 1)$ds) + 60*60*24*1, time_to_number(tail(df, 1)$ds) + 60*60*24*(n_pred), by = 60*60*24)) ), y= NA, ds_value = NA ))
df$ds_value = time_to_number(df$ds)

#------------------------------------------modeling------------------------------------------#

m = prophet( na.omit(df) , yearly.seasonality=T, weekly.seasonality = TRUE, daily.seasonality = TRUE )
future = predict(m, df )
df$yhat = future$yhat


#------------------------------------------visualization------------------------------------------#

dev.new(width = 15, height = 7.5)
yprt = pretty(df$y); ylim = range(yprt)
xlim = range(df$ds_value)
colors = c("black")(ylim[2])
plot(df$ds_value, df$y, axe=F, xlim = xlim, ylim = ylim, xlab="", ylab="", col = colors[round(df$y)], type="o", pch=19)
axis(1, df$ds_value, df$ds, las=2, cex.axis=0.5); axis(2, yprt, yprt )
abline(h = yprt, col = adjustcolor("gray", 0.9), lty = 4)
rect(head(df %>% filter(is.na(y)), 1)$ds_value, ylim[1], tail(df %>% filter(is.na(y)), 1)$ds_value, ylim[2], col = adjustcolor("pink", 0.5), border=NA)
lines(df$ds_value, df$yhat, lty = 4, lwd = 1)
legend("topleft", c("예측 영역", "yhat"), pch = c(15, NA), lty = c(NA, 4), col = c("pink", "black"), bty="n" )

save(df, m, future, file = "stok_prophet.RData")

