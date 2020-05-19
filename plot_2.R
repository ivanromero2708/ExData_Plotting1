# Getting the data

consumption <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE)
consumption <- consumption[consumption$Date %in% c("1/2/2007","2/2/2007") ,]

# Transform to Datetime
consumption$DateTime <- strptime(paste(consumption$Date, consumption$Time), "%d/%m/%Y %H:%M:%S")

# Plot 2
png(filename = "plot2.png", width = 480, height = 480)
plot(consumption$DateTime, as.numeric(consumption$Global_active_power), type = "l",xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()