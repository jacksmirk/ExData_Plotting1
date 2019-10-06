# Download and unzip the data
link <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(link, "household_power_consumption.zip")
unzip("household_power_consumption.zip")

# Import only the data from 2007/02/01 and 2007/02/02
hpc <- read.table("household_power_consumption.txt", skip = 66637, nrows = 2880, col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"), sep = ';')

# Initialize device png 480x480
png("plot1.png", width = 480, height = 480)

# Plot the data
hist(hpc$Global_active_power, col = 'red', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')

# Close device
dev.off()