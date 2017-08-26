
###LOAD DATA

library(tidyverse)
library(magrittr)
library(lattice)

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
png('plot4.png')
par(mfcol = c(2,2), cex = .5)

#plots device as a png file


with(data,{
  
#plot 1
plot(Clock, Global_active_power,type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = ""
)

#plot 2
plot(Clock, Sub_metering_1, type = "l",
     ylab = "Energy sub metering",
     xlab = ""
)


lines(Clock, Sub_metering_2, col = "red")
lines(Clock, Sub_metering_3, col = "blue")

legend("topright", 
       cex = .5,
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, 
       col = c("black", "red", "blue")
)

#plot 3
plot(Clock, Voltage, type = "l",
     ylab = "Voltage",
     xlab = "datetime"
)

#plot 4
plot(Clock, Global_reactive_power, type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime"
)
})

dev.off()
