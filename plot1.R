## load data into R
powercons <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.string = "?")

## subset out Dates of interest, between "2007-02-01" and "2007-02-02"
pcons <- mutate(powercons, Date = as.Date(powercons$Date, format = "%d/%m/%Y"))
fpcons <- filter(pcons, Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02"))

## create plot1 (histogram)
hist(as.numeric(fpcons$Global_active_power), col = "red", main = "Global Active Power", ylim = range(0:1200),
 xlab = "Global Active Power (kilowatts)")
 
 ## save to png file
dev.copy(png, file = "plot1.png")
dev.off()
