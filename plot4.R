##load data
powercons <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.string = "?")

## subset out Dates of interest, between "2007-02-01" and "2007-02-02"
library(lubridate)
library(dplyr)
dts <- dmy_hms(paste(powercons$Date, powercons$Time))
pcons <- cbind("datetime" = dts, powercons[3:length(powercons)])
fpcons <- filter(pcons, datetime >= ymd_hms("2007-02-01 00:00:00"), datetime <= ymd_hms("2007-02-02 23:59:59"))

## create plot
plot4 <- function(){
par(mfcol = c(2,2), mar = c(4,4,2,2), oma = c(2,2,1,1))

##[1,1]
with(fpcons, plot(datetime, Global_active_power, type = "l",xlab = "", ylab = "Global Active Power", cex.lab = 0.75, cex.axis = 0.75))
title(outer = FALSE)

##[2,1]
plot_this <- function(){
  with(fpcons, plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", cex.lab = 0.75, cex.axis = 0.75))
  lines(fpcons$datetime, fpcons$Sub_metering_1, col = "black")
  lines(fpcons$datetime, fpcons$Sub_metering_2, col = "red")
  lines(fpcons$datetime, fpcons$Sub_metering_3, col = "blue")
  legend("topright", lty = c("solid","solid","solid"), col = c("black", "green", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 0.55)
}
plot_this()

##[1,2]
with(fpcons, plot(datetime, Voltage, type = "l", cex.lab = 0.75, cex.axis = 0.75))

##[2,2]
with(fpcons, plot(datetime, Global_reactive_power, type = "l", cex.lab = 0.75, cex.axis = 0.75))

## save plots to png file
dev.copy(png, file = "plot4.png")
dev.off()
}
