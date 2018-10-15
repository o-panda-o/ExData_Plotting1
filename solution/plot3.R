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

png(filename="plot3.png",width=480,height=480)
data<-data %>%
  mutate(DateTime=ymd_hms(paste(Date,Time))) %>% 
    select(DateTime,Sub_metering_1,Sub_metering_2,Sub_metering_3) %>%
      mutate(Energy_sub_metering=Sub_metering_1+Sub_metering_2+Sub_metering_3)

with(data,plot(DateTime,Sub_metering_1,type="n",xlab = "",ylab="Energy sub metering"))
with(data,lines(DateTime,Sub_metering_1))
with(data,lines(DateTime,Sub_metering_2,col="red"))
with(data,lines(DateTime,Sub_metering_3,col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=1)
dev.off()