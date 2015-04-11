library(dplyr)

## Read in the entire data file and subset by specified date range
myFile <- file.choose()
data <- read.table(myFile, header = TRUE, sep = ";", dec = ".")
subData <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

## Convert to numeric and date/time
subData$Global_active_power <- as.numeric(as.character(subData$Global_active_power))
subData$Global_reactive_power <- as.numeric(as.character(subData$Global_reactive_power))
subData$Voltage <- as.numeric(as.character(subData$Voltage))
subData$Sub_metering_1 <- as.numeric(as.character(subData$Sub_metering_1))
subData$Sub_metering_2 <- as.numeric(as.character(subData$Sub_metering_2))
subData$Sub_metering_3 <- as.numeric(as.character(subData$Sub_metering_3))
subData$newDate <- strptime(paste(subData$Date, subData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

## Create plot 4
dev.copy(png, file="plot4.png", height=480, width=480)
par(mfrow = c(2,2))

## Add top-left (plot 2)
plot(subData$newDate, subData$Global_active_power, ylab = "Global Active Power", 
     xlab = "", type = "l")

## Add top-right
plot(subData$newDate, subData$Voltage, ylab = "Voltage", 
     xlab = "datetime", type = "l")

## Add bottom-left (plot 3)
plot(subData$newDate, subData$Sub_metering_1, ylab = "Energy sub metering", 
     xlab = "", type = "l")
lines(subData$newDate, subData$Sub_metering_2, col = "red")
lines(subData$newDate, subData$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd=1, cex = .75, col = c("blacK", "red", "blue"))

## Add bottom-right
plot(subData$newDate, subData$Global_reactive_power, ylab = "Global_reactive_power", 
     xlab = "datetime", type = "l")

dev.off()