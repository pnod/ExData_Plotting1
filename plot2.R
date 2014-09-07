# Read data into PowerConsump from the text file in the working directory
# The "skip" and "nrows" parameters are used to extract data for Feb 1 & 2 only
# The nested read.table function is used to extract the header row of variable names
PowerConsump <- read.table("household_power_consumption.txt", sep=";", skip=66637, nrows=2880,
                           col.names=colnames(read.table("household_power_consumption.txt",
                                                         sep=";", nrows=1, header=TRUE)))

## Convert date to "Date" class
PowerConsump$Date <- as.Date(PowerConsump$Date, format="%d/%m/%Y")

## Combine the Date and Time variables into a single variable called "DateTime", of a POSIX class
PowerConsump$DateTime <- strptime(paste(PowerConsump$Date, PowerConsump$Time), format="%Y-%m-%d %H:%M:%S")

## Open the PNG graphics device
png("plot2.png", width=480, height=480)

## Create plot 2
with(PowerConsump, plot(DateTime, Global_active_power, xlab="", 
                        ylab="Global Active Power (kilowatts)", type="l"))

## Close the PNG graphics device to save the plot to the PNG file
dev.off()