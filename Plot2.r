library(dplyr)

##Import full Source File
AllData <- read.csv(file = "household_power_consumption.txt", sep = ";")

##Convert to Date and Time
AllData$DateTime <- paste(AllData$Date, AllData$Time)
AllData$DateTime <- as.POSIXct(strptime(AllData$DateTime, format = '%d/%m/%Y %H:%M:%S'))

##Subset for the appropriate dates
epc <- filter(AllData, AllData$DateTime >= strptime("2007-02-01", format = "%Y-%m-%d"))
epc <- filter(epc, epc$DateTime < strptime("2007-02-03", format = "%Y-%m-%d"))

##Plot as line chart
plot(epc$DateTime, as.numeric(levels(epc$Global_active_power))[epc$Global_active_power], xlab = "", ylab = "Global Active Power (Kilowatts)", type = "o", pch = ".")

##Convert to png
dev.copy(png,"plot2.png", height = 480, width = 480)

##Close Device
dev.off()