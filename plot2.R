## Starting by reading a few lines just to get the column names 

name.col <- colnames(read.table("household_power_consumption.txt", sep=";",
                                header=T, colClasses=c("Date", "character", 
                                                       "numeric", "numeric",
                                                       "numeric", "numeric",
                                                       "numeric", "numeric",
                                                       "numeric"), na.string="?",
                                nrows=10))
## there is an observation for each minute in the data set. the observations start
## from 16/12/2006 17:24:00 but we need to start 2007-02-01 00:00:00

hr <- 24
min <- 60
days_jan <- 31
readtime <- 2 * hr * min

days_rem <- 16

## rewind to the begining of the month

adjust <- 17 * 60 + 24

skiptime <- days_rem * hr * min + days_jan * hr * min -adjust

##reading just the part we need

set <- read.table("household_power_consumption.txt", sep=";", header=T, 
                  colClasses=c("character", "character", "numeric",
                               "numeric", "numeric", "numeric", "numeric",
                               "numeric", "numeric"), na.string="?",
                  skip=skiptime, nrows=readtime, col.names= name.col)

## concatenating the date to the time so when converting it we have the time
## at the date
set$Time <- paste(set$Date, set$Time, sep=" ")

##converting to POSIX

set$Time <- strptime(set$Time, "%d/%m/%Y %H:%M:%S")

## not necessairy but still convert the date to Date class

set$Date <- as.Date(set$Date, "%d/%m/%Y")

## Note that the default is a 480x480 png so there is no need to add it as a param

png(file="plot2.png")

##plotting 

plot(set$Time,set$Global_active_power, type="l",
     ylab="Global Active Power (kilowatts)", xlab=" ")

##closing and generating the file

dev.off()
