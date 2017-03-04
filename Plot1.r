library(dplyr)

##Import full Source File
AllData <- read.csv(file = "household_power_consumption.txt", sep = ";")

##Convert to Date and Time
AllData$DateTime <- paste(AllData$Date, AllData$Time)
AllData$DateTime <- as.POSIXct(strptime(AllData$DateTime, format = '%d/%m/%Y %H:%M:%S'))

##Subset for the appropriate dates
epc <- filter(AllData, AllData$DateTime >= strptime("2007-02-01", format = "%Y-%m-%d"))
epc <- filter(epc, epc$DateTime < strptime("2007-02-03", format = "%Y-%m-%d"))

##Convert Global Active Power to a Table
GAP <- table(round(as.numeric(levels(epc$Global_active_power))[epc$Global_active_power], digits = 0))

##Plot as bar chart
barplot(GAP, main = "Global Active Power", xlab = "Global Active Power (Kilowatts)", ylab = "Frequency", col = "red")

##Convert to png
dev.copy(png,"plot1.png", height = 480, width = 480)

##Close Device
dev.off()