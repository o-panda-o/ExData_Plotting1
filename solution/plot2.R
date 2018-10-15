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

png(filename="plot2.png",width=480,height=480)
library(dplyr)
library(lubridate)
data<-data %>%
            mutate(DateTime=ymd_hms(paste(Date,Time)))
with(data,plot(DateTime,Global_active_power,type="l"))
dev.off()