## add required library
library(lubridate)

# set working directory and download file
setwd("C:/Users/Lon/Documents/Coursera/Course 4/Week 1")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./wk1data.zip")
downloaddate <- Sys.time()

# extract downloaded file and load into environment
# note this file was inspected using a text editor and only FEb 1 2007 and Feb 2 2007 data is being extracted
unzip("./wk1data.zip")
plotdata <- read.table("./household_power_consumption.txt", header= FALSE, sep=";", skip= 66637, nrows= 2880, 
                       col.name= c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# format dates and time
plotdata$Date <- dmy(plotdata$Date)
plotdata$timestamp <- as.POSIXct(paste(plotdata$Date, plotdata$Time))

#initiate device and set plot margin so x label is not shown
png(file= "plot3.png")
par(mar= c(2,4,2,2))

#plot graph
plot(x= plotdata$timestamp, y= plotdata$Sub_metering_1, ylab= "Energy sub metering", type= "l")
    points(x= plotdata$timestamp, y= plotdata$Sub_metering_2, type= "l", col= "red")
    points(x= plotdata$timestamp, y= plotdata$Sub_metering_3, type= "l", col= "blue")
      legend("topright", col= c("black", "red", "blue"), lty= c(1, 1, 1), 
                      legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#close device
dev.off()