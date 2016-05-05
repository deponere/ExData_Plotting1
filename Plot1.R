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
# Graph 1

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

loadData()
#set the defined time frame
StartDate = as.Date("2007-02-01")
EndDate = as.Date(" 2007-02-02")
# read the .zip file
epc <- read.table(unz(DestinationFile,"household_power_consumption.txt"),sep=";",header=TRUE,
        stringsAsFactors=FALSE)
#colClasses = c("Date","Time","character","character","character","character","character","character","character"))
# adjust the date format
epc$Date <- as.Date( epc$Date, format = "%d/%m/%Y")
# shrink data.frame to the requested time slot
Data <- epc[epc$Date >= StartDate & epc$Date <= EndDate,]
# adjust the charcter columns to real numbers forat double
Data$Global_active_power <- as.double(Data$Global_active_power)
Data$Global_intensity <- as.double(Data$Global_intensity)
#name the right device
png(filename="plot1.png")
# plot the histogram
hist(Data$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
