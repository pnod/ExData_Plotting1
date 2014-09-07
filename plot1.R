# Read data into PowerConsump from the text file in the working directory
# The "skip" and "nrows" parameters are used to extract data for Feb 1 & 2 only
# The nested read.table function is used to extract the header row of variable names
PowerConsump <- read.table("household_power_consumption.txt", 
                           sep=";", skip=66637, nrows=2880,
                           col.names=colnames(read.table(
                                   "household_power_consumption.txt",
                                   sep=";", nrows=1, header=TRUE)))

## Open the PNG graphics device
png("plot1.png", width=480, height=480)

## Create plot 1
hist(PowerConsump$Global_active_power, main="Global Active Power", col="red", 
     xlab="Global Active Power (kilowatts)")

## Close the PNG graphics device to save the plot to the PNG file
dev.off()