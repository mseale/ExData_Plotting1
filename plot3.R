# Construct plot3
# mseale

library(data.table)
library(datasets)

# Read in data file (assumes file has been downloaded and unzipped,
# and that script resides in the same directory as the data file).
electdf <- fread("household_power_consumption.txt", na.strings = "?",
                 stringsAsFactors = FALSE)

# Convert dates to Date class
electdf$Date <- as.Date(electdf$Date, format="%d/%m/%Y")

# Subset the dataframe to only the specified dates
beginDate <- as.Date("2007-02-01")
endDate <- as.Date("2007-02-02")
electdf <- electdf[electdf$Date >= beginDate & electdf$Date <= endDate,]

# Convert character to numeric values (due to NA's in fread)
electdf$Global_active_power <- as.numeric(electdf$Global_active_power)
electdf$Global_reactive_power <- as.numeric(electdf$Global_reactive_power)
electdf$Voltage <- as.numeric(electdf$Voltage)
electdf$Global_intensity <- as.numeric(electdf$Global_intensity)
electdf$Sub_metering_1 <- as.numeric(electdf$Sub_metering_1)
electdf$Sub_metering_2 <- as.numeric(electdf$Sub_metering_2)
electdf$Sub_metering_3 <- as.numeric(electdf$Sub_metering_3)

# Create a Time object for plot labels
electdf$Date <- as.character(electdf$Date)
dateTime <- strptime(paste(electdf$Date,electdf$Time), 
                     format="%Y-%m-%d %H:%M:%S")
#---------------------------------------------------------
# READY TO BEGIN PLOTTING

png(filename = "plot3.png", width = 480, height = 480, bg = "transparent")
plot(dateTime, electdf$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
points(dateTime, electdf$Sub_metering_2, type = "l", col = "red")
points(dateTime, electdf$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black","red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       lty = 1)
dev.off()