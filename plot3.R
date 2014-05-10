
data <- read.table("household_power_consumption.txt",
                   colClasses = c("character", "character", rep("numeric",7)),
                   na.strings=c("?"),
                   sep=";",
                   header=TRUE)

# Combine the Date and time fields to make it easier to reformant the times
data$DateTime <- with(data, paste(Date, Time, sep=" "))

data$Date = NULL
data$Time = NULL

# Convert DateTime String to a DateTime object
data$DateTime = as.POSIXct(strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S"))

# Subset the data to the desired date/time range
data = subset(data, DateTime >= as.POSIXct("2007-02-01") & DateTime < as.POSIXct("2007-02-03"))

# Plot 3
png(filename="plot3.png", width = 480, height = 480)
plot(data$DateTime, data$Sub_metering_1, type ="l",  ylab="Energy sub metering", xlab = "")
lines(data$DateTime, data$Sub_metering_2, type ="l",  col="red")
lines(data$DateTime, data$Sub_metering_3, type ="l",  col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1,  col=c("black","red","blue"))
dev.off()