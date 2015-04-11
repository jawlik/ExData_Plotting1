library(dplyr)

## Read in the entire data file and subset by specified date range
myFile <- file.choose()
data <- read.table(myFile, header = TRUE, sep = ";", dec = ".")
subData <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")

## Convert to numerica and create the histogram
subData$Global_active_power <- as.numeric(as.character(subData$Global_active_power))
hist(subData$Global_active_power, main = "Global Active Power", col = "red",
     xlab = "Global Active Power (kilowatts)")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()