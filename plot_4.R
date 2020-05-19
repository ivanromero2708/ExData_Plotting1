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
consumption_subset <- consumption %>% 
                      select(Date, Time, DateTime, Global_active_power, 
                             Global_reactive_power, Voltage,
                             Sub_metering_1, Sub_metering_2,Sub_metering_3) %>%
                      filter("2007-02-01" <= Date & Date <= "2007-02-02")
consumption_subset[,4:9] <- sapply(consumption_subset[,4:9], as.numeric)
rangesub <- c(consumption_subset$Sub_metering_1,consumption_subset$Sub_metering_2,consumption_subset$Sub_metering_3)

# Plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(consumption_subset$DateTime, consumption_subset$Global_active_power, ylab = "Global Active Power", xlab = "", type = "l")

plot(consumption_subset$DateTime, consumption_subset$Voltage, ylab = "Voltage", xlab = "datetime", type = "l")

plot(consumption_subset$DateTime, consumption_subset$Sub_metering_1, type = "l", ylim = range(rangesub),ylab = "Energy sub metering", xlab ="")
lines(consumption_subset$DateTime, consumption_subset$Sub_metering_2, type = "l", col = "red", ylim = range(rangesub))
lines(consumption_subset$DateTime, consumption_subset$Sub_metering_3, type = "l", col = "blue", ylim = range(rangesub))
legend("topright", legen = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lty=, lwd=2.5,cex = 0.75)

plot(consumption_subset$DateTime, consumption_subset$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l")

dev.off()