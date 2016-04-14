## load data into R
powercons <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.string = "?")

## subset out Dates of interest, between "2007-02-01" and "2007-02-02"
library(lubridate)
library(dplyr)
dts <- dmy_hms(paste(powercons$Date, powercons$Time))
pcons <- cbind("datetime" = dts, powercons[3:length(powercons)])
fpcons <- filter(pcons, datetime >= ymd_hms("2007-02-01 00:00:00"), datetime <= ymd_hms("2007-02-02 23:59:59"))

## create plot1 (histogram)
hist(as.numeric(fpcons$Global_active_power), col = "red", main = "Global Active Power", ylim = range(0:1200),
 xlab = "Global Active Power (kilowatts)")
 
 ## save to png file
dev.copy(png, file = "plot1.png")
dev.off()
