## Cleaning Environment
rm(list=ls())

## Loading required packages
library(dplyr)

## Creating directory and downloads dataset
if(!file.exists("data")) {dir.create("data")}
fileloc <- "./data/electric_power_consumption.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, fileloc, method = "curl")

## Assigning all data frames

consumption <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

consumption$DateTime <- as.POSIXct(paste(consumption$Date, consumption$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
consumption$Date <- as.Date(consumption$Date, format = "%d/%m/%Y")
consumption_subset <- consumption %>% select(Date, Time, DateTime, Sub_metering_1, Sub_metering_2,Sub_metering_3) %>%
      filter("2007-02-01" <= Date & Date <= "2007-02-02")
consumption_subset[,4:6] <- sapply(consumption_subset[,4:6], as.numeric)
rangesub <- c(consumption_subset$Sub_metering_1,consumption_subset$Sub_metering_2,consumption_subset$Sub_metering_3)


consumption$Sub_metering_1 <- as.numeric(consumption$Sub_metering_1)
consumption$Sub_metering_2 <- as.numeric(consumption$Sub_metering_2)
consumption$Sub_metering_3 <- as.numeric(consumption$Sub_metering_3)


# Plot 3
png(filename = "plot3.png", width = 480, height = 480)
plot(consumption_subset$DateTime, consumption_subset$Sub_metering_1, type = "l", ylim = range(rangesub),ylab = "Energy sub metering", xlab ="")
par(new = TRUE)
lines(consumption_subset$DateTime, consumption_subset$Sub_metering_2, type = "l", col = "red", ylim = range(rangesub))
par(new = TRUE)
lines(consumption_subset$DateTime, consumption_subset$Sub_metering_3, type = "l", col = "blue", ylim = range(rangesub))
legend("topright", legen = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lty=1, lwd=2.5)
dev.off()