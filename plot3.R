if ('dplyr' %in% rownames(installed.packages()) == FALSE) {
  install.packages('dplyr')
}
library(dplyr)

# Download and unzip the data
link <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(link, "household_power_consumption.zip")
unzip("household_power_consumption.zip")

# Import only the data from 2007/02/01 and 2007/02/02
hpc_raw <- read.table("household_power_consumption.txt", skip = 66637, nrows = 2880, col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"), sep = ';')
hpc_date <- hpc_raw %>% mutate(FullDate = as.POSIXct(paste(hpc_raw$Date, hpc_raw$Time), format = "%d/%m/%Y %H:%M:%S")) %>% select(c('FullDate',"Sub_metering_1","Sub_metering_2","Sub_metering_3"))
## I had to do this to show the labels in English
Sys.setlocale(category = "LC_ALL", locale = "english")

# Initialize device png 480x480
png("plot3.png", width = 480, height = 480)

# Plot the data
plot(hpc_date$FullDate, hpc_date$Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy sub metering')
lines(hpc_date$FullDate, hpc_date$Sub_metering_2, type = 'l', col = 'red')
lines(hpc_date$FullDate, hpc_date$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c('black', 'red', 'blue'), lwd = 1)

# Close the device
dev.off()