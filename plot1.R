
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

# Plot 1
png(filename="plot1.png", width = 480, height = 480)
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
dev.off()