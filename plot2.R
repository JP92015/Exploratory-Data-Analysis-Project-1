## load data into R
powercons <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.string = "?")

## subset out Dates of interest, between "2007-02-01" and "2007-02-02"
library(lubridate)
dts <- dmy_hms(paste(powercons$Date, powercons$Time))
pcons <- cbind(dts, powercons[3:length(powercons)])
##pcons <- mutate(powercons, Date = as.Date(powercons$Date, format = "%d/%m/%Y"))
fpcons <- filter(pcons, Date >= ymd_hms("2007-02-01 00:00:00"), Date <= ymd_hms("2007-02-02 23:59:59"))

## create plot2
with(fpcons, plot(Date, Global_active_power, type = "l",xlab = "", ylab = "Global Active Power (kilowatts)"))
 
 ## save to png file
dev.copy(png, file = "plot2.png")
dev.off()
