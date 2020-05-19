# Getting the data

consumption <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE)
consumption <- consumption[consumption$Date %in% c("1/2/2007","2/2/2007") ,]

# Transform to Datetime
consumption$DateTime <- strptime(paste(consumption$Date, consumption$Time), "%d/%m/%Y %H:%M:%S")

# Plot 1
png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(consumption$Global_active_power), col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off()