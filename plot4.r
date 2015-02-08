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

## Create Plot 4 from subset data
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
    plot(Global_active_power~Datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~Datetime, type="l", 
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~Datetime, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Datetime, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="")
})

## Save to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
