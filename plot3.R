## load data into R
powercons <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.string = "?")

## subset out Dates of interest, between "2007-02-01" and "2007-02-02"
library(lubridate)
dts <- dmy_hms(paste(powercons$Date, powercons$Time))
pcons <- cbind(dts, powercons[3:length(powercons)])
fpcons <- filter(pcons, Date >= ymd_hms("2007-02-01 00:00:00"), Date <= ymd_hms("2007-02-02 23:59:59"))

## create plot2
with(fpcons2, plot(Date, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
lines(fpcons2$Date, fpcons2$Sub_metering_1, col = "black")
lines(fpcons2$Date, fpcons2$Sub_metering_2, col = "red")
lines(fpcons2$Date, fpcons2$Sub_metering_3, col = "blue")
legend("topright", lty = c("solid","solid","solid"), col = c("black", "green", "blue"), 
 legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.50)

 ## save to png file
dev.copy(png, file = "plot2.png")
dev.off()
