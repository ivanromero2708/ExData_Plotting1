## Cleaning Environment
rm(list=ls())

## 1. Loading required packages
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
consumption_subset <- consumption %>% select(Date, Time, DateTime, Global_active_power) %>%
               filter("2007-02-01" <= Date & Date <= "2007-02-02")
consumption_subset$Global_active_power <- as.numeric(consumption_subset$Global_active_power)

# Plot 1
png(filename = "plot1.png", width = 480, height = 480)
hist(consumption_subset$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off()