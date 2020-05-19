# Getting the data

consumption <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE)
consumption <- consumption[consumption$Date %in% c("1/2/2007","2/2/2007") ,]

# Transform to Datetime
consumption$DateTime <- strptime(paste(consumption$Date, consumption$Time), "%d/%m/%Y %H:%M:%S")
consumption$Global_active_power <- as.numeric(consumption$Global_active_power)
consumption$Voltage <- as.numeric(consumption$Voltage)
consumption$Sub_metering_1 <- as.numeric(consumption$Sub_metering_1)
consumption$Sub_metering_2 <- as.numeric(consumption$Sub_metering_2)
consumption$Sub_metering_3 <- as.numeric(consumption$Sub_metering_3)
consumption$Global_reactive_power <- as.numeric(consumption$Global_reactive_power)
rangesub <- c(consumption$Sub_metering_1,consumption$Sub_metering_2,consumption$Sub_metering_3)

# Plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(consumption$DateTime, consumption$Global_active_power, ylab = "Global Active Power", xlab = "", type = "l")

plot(consumption$DateTime, consumption$Voltage, ylab = "Voltage", xlab = "datetime", type = "l")

plot(consumption$DateTime, consumption$Sub_metering_1, type = "l", ylim = range(rangesub),ylab = "Energy sub metering", xlab ="")
lines(consumption$DateTime, consumption$Sub_metering_2, type = "l", col = "red", ylim = range(rangesub))
lines(consumption$DateTime, consumption$Sub_metering_3, type = "l", col = "blue", ylim = range(rangesub))
legend("topright", legen = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lty=, lwd=2.5,cex = 1)

plot(consumption$DateTime, consumption$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l")

dev.off()