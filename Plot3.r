library(dplyr)

##Import full Source File
AllData <- read.csv(file = "household_power_consumption.txt", sep = ";")

##Convert to Date and Time
AllData$DateTime <- paste(AllData$Date, AllData$Time)
AllData$DateTime <- as.POSIXct(strptime(AllData$DateTime, format = '%d/%m/%Y %H:%M:%S'))

##Subset for the appropriate dates
epc <- filter(AllData, AllData$DateTime >= strptime("2007-02-01", format = "%Y-%m-%d"))
epc <- filter(epc, epc$DateTime < strptime("2007-02-03", format = "%Y-%m-%d"))

##Plot Sub Metering 1 as line chart with black line
plot(epc$DateTime, as.numeric(levels(epc$Sub_metering_1))[epc$Sub_metering_1], xlab = "", ylab = "Energy sub metering", type = "o", pch = ".")

##Plot Sub Metering 2 as line chart with red line
lines(epc$DateTime, as.numeric(levels(epc$Sub_metering_2))[epc$Sub_metering_2], type = "o", pch = ".", col = "red")

##Plot Sub Metering 3 as line chart with blue line
lines(epc$DateTime, epc$Sub_metering_3, type = "o", pch = ".", col = "blue")

##Add Legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black","red","blue"))

##Convert to png
dev.copy(png,"plot3.png", height = 480, width = 480)

##Close Device
dev.off()