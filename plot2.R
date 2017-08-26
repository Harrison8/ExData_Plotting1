
###LOAD DATA

library(tidyverse)
library(magrittr)

data <- read_csv2("household_power_consumption.txt", na = c("?", "NA"), skip = 0, n_max = 100000)

#PROCESS DATA

#create new Date object
data$Clock <- paste(data$Date, data$Time, sep = " ")
data$Clock <- strptime(data$Clock, "%d/%m/%Y %H:%M:%S")

#subset data, removing Date, Time, and unnecessary rows
data <- data[,3:10]
data <- data[data$Clock >= "2007-02-01" & data$Clock < "2007-02-03",]

#changes data to numeric
data %<>% mutate_if(is.character, as.double)

#PLOT DATA

#plots device as a png file
png('plot2.png')

plot(data$Clock, data$Global_active_power,type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = ""
)

dev.off()
