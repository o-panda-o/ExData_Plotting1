# Clean the environment
rm(list = ls())

# Load the data into the table
data<-read.table("./data/household_power_consumption.txt",sep=";",header=TRUE)


# Giving data their required format
library(lubridate)
data$Date<-dmy(data$Date)
data$Time<-format(parse_date_time(data$Time,"HMS"),format="%H:%M:%S")
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power<-as.numeric(as.character(data$Global_reactive_power))
data$Voltage<-as.numeric(as.character(data$Voltage))
data$Global_intensity<-as.numeric(as.character(data$Global_intensity))
data$Sub_metering_1<-as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2<-as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3<-as.numeric(as.character(data$Sub_metering_3))

# Filter the required data
library(dplyr)
data<-data[(data$Date=="2007-02-01"|data$Date=="2007-02-02"),]

#############################
##### CODE FOR THE PLOT #####
#############################

png(filename="plot1.png",width=480,height=480)
hist(data$Global_active_power,
     xlim=c(0,6),col="red",
     xlab = "Global Active Power (kilowatts)", main="Global Active Power",
     axes = FALSE)
axis(side=1, at=seq(0,6,2), labels=seq(0,6,2))
axis(2,at=seq(0,1200,1200/6),labels = seq(0,1200,1200/6))
dev.off()
