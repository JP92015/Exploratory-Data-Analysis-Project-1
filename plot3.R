## load data into R
powercons <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.string = "?")

## subset out Dates of interest, between "2007-02-01" and "2007-02-02"
library(lubridate)
library(dplyr)
dts <- dmy_hms(paste(powercons$Date, powercons$Time))
pcons <- cbind("datetime" = dts, powercons[3:length(powercons)])
fpcons <- filter(pcons, datetime >= ymd_hms("2007-02-01 00:00:00"), datetime <= ymd_hms("2007-02-02 23:59:59"))

## create plot2
with(fpcons, plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", cex.lab = 0.75, cex.axis = 0.75))
lines(fpcons$datetime, fpcons$Sub_metering_1, col = "black")
lines(fpcons$datetime, fpcons$Sub_metering_2, col = "red")
lines(fpcons$datetime, fpcons$Sub_metering_3, col = "blue")
legend("topright", lty = c("solid","solid","solid"), col = c("black", "green", "blue"), 
 legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.60)

 ## save to png file
dev.copy(png, file = "plot3.png")
dev.off()
