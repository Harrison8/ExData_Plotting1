
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
png('plot3.png')

plot(data$Clock, data$Sub_metering_1, type = "l",
     ylab = "Energy sub metering",
     xlab = ""
)


lines(data$Clock, data$Sub_metering_2, col = "red")
lines(data$Clock, data$Sub_metering_3, col = "blue")

legend("topright", 
       pt.cex = 2,
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, 
       col = c("black", "red", "blue")
       )

dev.off()
