################################################################################
#
#      Coursera 'Exploratory Data Analysis' Class Project 1 - Plot 1
#
# Author: Chip Boling
#   Date: Jan 6, 2015
#
# This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository
# for machine learning datasets. In particular, we will be using the “Individual household
# electric power consumption Data Set” which I have made available on the course web site:
#
#     Dataset: Electric power consumption [20Mb]  -> https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# Description: Measurements of electric power consumption in one household with a one-minute
#              sampling rate over a period of almost 4 years. Different electrical quantities
#              and some sub-metering values are available.
#
#  The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#
# 1.Date:                 Date in format dd/mm/yyyy
# 2.Time:                 time in format hh:mm:ss
# 3.Global_active_power:  household global minute-averaged active power (in kilowatt)
# 4.Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# 5.Voltage:              minute-averaged voltage (in volt)
# 6.Global_intensity:     household global minute-averaged current intensity (in ampere)
# 7.Sub_metering_1:       energy sub-metering No. 1 (in watt-hour of active energy). It
#                         corresponds to the kitchen, containing mainly a dishwasher, an oven and
#                         a microwave (hot plates are not electric but gas powered).
# 8.Sub_metering_2:       energy sub-metering No. 2 (in watt-hour of active energy). It
#                         corresponds to the laundry room, containing a washing-machine, a
#                         tumble-drier, a refrigerator and a light.
# 9.Sub_metering_3:       energy sub-metering No. 3 (in watt-hour of active energy). It
#                         corresponds to an electric water-heater and an air-conditioner.
#
#################################################################################
#
# Task: Construct the plot and save it to a PNG file with a width of 480 pixels and a height
#       of 480 pixels.
#
#       Name each of the plot files as plot1.png, plot2.png, etc.
#
#################################################################################
library(data.table)
#library(stringr)
#library(plyr)
#
# Load the data, use read.table since fread has some issues with '?' as NA but the
# workaround below is still orders of magnitude faster that read.table
#
dataFile <- './data/household_power_consumption.txt'
#setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
#setAs("character","myTime", function(from) strptime(from, format="%H:%M:%S"))
# Read all as character and force to appropreate later.  fread has issues with '?'
columns = c(
    "Date"                  ="character",
    "Time"                  ="character",
    "Global_active_power"   ="character",     # "double",
    "Global_reactive_power" ="character",     # "double",
    "Voltage"               ="character",     # "double",
    "Global_intensity"      ="character",     # "double",
    "Sub_metering_1"        ="character",     # "double",
    "Sub_metering_2"        ="character",     # "double",
    "Sub_metering_3"        ="character")     # "double")

table <- fread(dataFile, header=TRUE, na.strings=c("?", "", " "),colClasses=columns)
table <- transform(table,
                    Date_and_Time         = strptime(paste(Date, Time),format="%d/%m/%Y %H:%M:%S"),
                    Global_active_power   = as.double(Global_active_power),
                    Global_reactive_power = as.double(Global_reactive_power),
                    Voltage               = as.double(Voltage),
                    Global_intensity      = as.double(Global_intensity),
                    Sub_metering_1        = as.double(Sub_metering_1),
                    Sub_metering_2        = as.double(Sub_metering_2),
                    Sub_metering_3        = as.double(Sub_metering_3))
