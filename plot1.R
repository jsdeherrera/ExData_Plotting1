## Retrieve full dataset from directory "data"
data_full <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

## Convert date into date format
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subset the data for the two relevant days
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Remove the full data set to conserve resources
rm(data_full)

## Convert date into date format
datetime <- paste(as.Date(data$Date), data$Time)

## Use base function "as.POSIXct" to convert into calendar time class
data$Datetime <- as.POSIXct(datetime)

## Create Plot 1 histogram using subset data
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Save to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
