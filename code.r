setwd("C:/Users/Haonan/Desktop/Case Western Reserve/Semester3/Sourcing/Group Project")
library(quantmod)
library(forecast)

#Daily
raw <- read.csv("cleaned data.csv", header = T)
use <- raw[7568:dim(raw)[1],]
use$Date <- as.Date(use[,1], format = "%m/%d/%Y")
use$USD <- as.character(use$USD)
use$USD <- gsub(",","", use$USD)
use$USD <- as.numeric(use$USD)
ts1 <- ts(use$USD, frequency = 30)
ts1train <- window(ts1, start = 1, end = 60)
ts1test <- window(ts1, start = 60)
ets1 <- ets(ts1train, model = "MMM")
fcast <- forecast(ets1)
plot(fcast); lines(ts1test,col = 2)
accuracy(fcast, ts1test)
yuce <- forecast(ts1)

#Monthly
use <- read.csv("month.csv", header = T)
use$Date <- as.Date(use[,1], format = "%m/%d/%Y")
use$USD <- as.character(use$USD)
use$USD <- gsub(",","", use$USD)
use$USD <- as.numeric(use$USD)
ts1 <- ts(use$USD, frequency = 12)
plot(decompose(ts1))
ts1train <- window(ts1, start = 1, end = 7)
ts1test <- window(ts1, start = 7)
ets1 <- ets(ts1train, model = "MMM")
fcast <- forecast(ets1)
plot(fcast); lines(ts1test,col = 2)
accuracy(fcast, ts1test)
