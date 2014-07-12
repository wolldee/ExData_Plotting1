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

set$Date <- as.Date(set$Date, "%d/%m/%Y")

##ploting 
## the default value for the width and heigth in the png function is 480

png(file="plot1.png")

hist(set$Global_active_power, col="red", xlab="Global Active Power (Kilowatts)", main="Global Activite Power")
##closing the device and creating the file
dev.off()
