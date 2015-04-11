library(dplyr)

## Read in the entire data file and subset by specified date range
myFile <- file.choose()
data <- read.table(myFile, header = TRUE, sep = ";", dec = ".")
subData <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

## Convert to numeric and date/time
subData$Global_active_power <- as.numeric(as.character(subData$Global_active_power))
subData$Sub_metering_1 <- as.numeric(as.character(subData$Sub_metering_1))
subData$Sub_metering_2 <- as.numeric(as.character(subData$Sub_metering_2))
subData$Sub_metering_3 <- as.numeric(as.character(subData$Sub_metering_3))
subData$newDate <- strptime(paste(subData$Date, subData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

## Create the plot
dev.copy(png, file="plot3.png", height=480, width=480)
plot(subData$newDate, subData$Sub_metering_1, ylab = "Energy sub metering", 
     xlab = "", type = "l")
lines(subData$newDate, subData$Sub_metering_2, col = "red")
lines(subData$newDate, subData$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd=1, cex = .75, col = c("blacK", "red", "blue"))
dev.off()