# exploratory data analysis
# Assignment: Course Project 1
# Markus Pleier, Germany
#
# 5 May 2016
#
#This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. In particular, we will be using the “Individual household electric power consumption Data Set” which I have made available on the course web site:
#
#Dataset: Electric power consumption [20Mb]
#Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
#The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#
#Date: Date in format dd/mm/yyyy
#Time: time in format hh:mm:ss
#Global_active_power: household global minute-averaged active power (in kilowatt)
#Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#Voltage: minute-averaged voltage (in volt)
#Global_intensity: household global minute-averaged current intensity (in ampere)
#Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
#
# Graph 4

# function loadData:
# Load the data from the URL and saves the Zip file locally that it can be read faster
# Returns a timestamp if re-read or a notice that the local file is used
# To initiate the re-read delete the local file

DestinationFile = "./data/EPC.zip"

loadData <- function (){
        setwd("~/CloudStation/Data Scientist/Exploratory Data analysis/Assignment/")
        url <-  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"       
        if(!file.exists("./data")) {
                dir.create("./data")
        }
        if (file.exists(DestinationFile)) return("File not downloaded again")
        download.file(url,destfile=DestinationFile)
        return(timestamp())
        
}
# define the Graphs for the 4 quadrants
Graph1 <- function(){
        plot(Data$TimeDate,Data$Global_active_power,type="l",xlab="",
                ylab="Global Active Power (kilowatts)")
}

Graph2 <- function() {
        plot(Data$TimeDate,Data$Sub_metering_1,type="l",xlab="",
                ylab="Energy sub metering",col="black")
        lines(Data$TimeDate,Data$Sub_metering_2,type="l",xlab="",col="red")
        lines(Data$TimeDate,Data$Sub_metering_3,type="l",xlab="",col="blue")
        legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                lwd=c(2.5,2.5),col=c("black","red","blue",cex=1.0))
}

Graph3 <- function() {
         plot(Data$TimeDate,Data$Voltage,type="l",xlab="datetime",
                ylab="Voltage",col="black")
}

Graph4 <- function() {
        plot(Data$TimeDate,Data$Global_reactive_power,type="l",xlab="datetime",
                ylab="Global_reactive_power",col="black")
}

loadData()
StartDate = as.Date("2007-02-01")
EndDate = as.Date(" 2007-02-02")
# read data from .zip file
epc <- read.table(unz(DestinationFile,"household_power_consumption.txt"),sep=";",header=TRUE,
        stringsAsFactors=FALSE)
# take subset of data
epc$Date <- as.Date( epc$Date, format = "%d/%m/%Y")
Data <- epc[epc$Date >= StartDate & epc$Date <= EndDate,]
# change class of column
Data$Global_active_power <- as.double(Data$Global_active_power)
Data$Sub_metering_1 <- as.double(Data$Sub_metering_1)
Data$Sub_metering_2 <- as.double(Data$Sub_metering_2)
Data$Sub_metering_3 <- as.double(Data$Sub_metering_3)
Data$Voltage <- as.double(Data$Voltage)
Data$Global_reactive_power <- as.double(Data$Global_reactive_power)
# combine Date and Time for plotting
Data$TimeDate <- strptime(paste(Data$Date, Data$Time),"%Y-%m-%d %H:%M:%S")
png(filename="plot4.png")
# set the canvas
par(mfrow=c(2,2))
#put graphs in
Graph1()
Graph2()
Graph3()
Graph4()
dev.off()


