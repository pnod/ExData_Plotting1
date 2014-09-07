# Read data into PowerConsump from the text file in the working directory
# The "skip" and "nrows" parameters are used to extract data for Feb 1 & 2 only
# The nested read.table function is used to extract the header row of variable names
PowerConsump <- read.table("household_power_consumption.txt", sep=";", skip=66637, nrows=2880,
                           col.names=colnames(read.table("household_power_consumption.txt",
                                                         sep=";", nrow=1, header=TRUE)))

## Convert date to "Date" class
PowerConsump$Date <- as.Date(PowerConsump$Date, format="%d/%m/%Y")

## Combine the Date and Time variables into a single variable called "DateTime", of a POSIX class
DateTime <- strptime(paste(PowerConsump$Date, PowerConsump$Time), format="%Y-%m-%d %H:%M:%S")

## Column-bind the DateTime variable to the main dataset so the plot can be generated
PowerConsump <- cbind(PowerConsump, DateTime)

## Open the PNG graphics device
png("plot4.png", width=480, height=480)

## Set up display to display four plots in a 2x2 grid
par(mfrow=c(2,2))

## Generate plot 1 (top-left corner)
with(PowerConsump, plot(DateTime, Global_active_power, xlab="", ylab="Global Active Power", type="l"))

## Generate plot 2 (top-right corner)
with(PowerConsump, plot(DateTime, Voltage, xlab="datetime", type="l"))

## Generate plot 3 (bottom-left corner)
with(PowerConsump, plot(DateTime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", col="black"))
with(PowerConsump, lines(DateTime, Sub_metering_2, col="red"))
with(PowerConsump, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

## Generate plot 4 (bottom-right corner)
with(PowerConsump, plot(DateTime, Global_reactive_power, xlab="datetime", type="l"))

## Close the PNG graphics device to save the plot to the PNG file
dev.off()