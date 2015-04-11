library(dplyr)

## Read in the entire data file and subset by specified date range
myFile <- file.choose()
data <- read.table(myFile, header = TRUE, sep = ";", dec = ".")
subData <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

## Convert to numeric and date/time
subData$Global_active_power <- as.numeric(as.character(subData$Global_active_power))
subData$newDate <- strptime(paste(subData$Date, subData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

## Create the plot
plot(subData$newDate, subData$Global_active_power, main = "Global Active Power",
     ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()