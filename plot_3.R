# Getting the data

consumption <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE)
consumption <- consumption[consumption$Date %in% c("1/2/2007","2/2/2007") ,]

# Transform to Datetime
consumption$DateTime <- strptime(paste(consumption$Date, consumption$Time), "%d/%m/%Y %H:%M:%S")
consumption$Sub_metering_1 <- as.numeric(consumption$Sub_metering_1)
consumption$Sub_metering_2 <- as.numeric(consumption$Sub_metering_2)
consumption$Sub_metering_3 <- as.numeric(consumption$Sub_metering_3)
rangesub <- c(consumption$Sub_metering_1,consumption$Sub_metering_2,consumption$Sub_metering_3)

# Plot 3
png(filename = "plot3.png", width = 480, height = 480)
plot(consumption$DateTime, consumption$Sub_metering_1, type = "l", ylim = range(rangesub),ylab = "Energy sub metering", xlab ="")
par(new = TRUE)
lines(consumption$DateTime, consumption$Sub_metering_2, type = "l", col = "red", ylim = range(rangesub))
par(new = TRUE)
lines(consumption$DateTime, consumption$Sub_metering_3, type = "l", col = "blue", ylim = range(rangesub))
legend("topright", legen = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lty=1, lwd=2.5)
dev.off()