## Loads data.table package
install.packages("data.table")
library(data.table)


# Reads specified lines from text file and merges the data into one data table.
col_names <- fread(file="household_power_consumption.txt", sep=";", nrows=0)
dt1 <- fread(cmd = paste("grep","^1/2/2007",
                      "household_power_consumption.txt"), sep = ";",
                      header = FALSE, na.strings = c("?", "NA"),
                      col.names=names(col_names))
dt2 <- fread(cmd = paste("grep","^2/2/2007",
                         "household_power_consumption.txt"), sep = ";",
             header = FALSE, na.strings = c("?", "NA"),
             col.names=names(col_names))
dt <- rbind(dt1, dt2)

## Changing date specs in the data table
dt$Date <- gsub("1/2/2007","01/02/2007", dt$Date)
dt$Date <- gsub("2/2/2007","02/02/2007", dt$Date)
dt$DateTime <- paste(dt$Date, dt$Time)
dt$DateTime <- as.POSIXct(strptime(dt$DateTime, format="%d/%m/%Y %H:%M:%S"))


## Plotting the graphs into PNG file.
png(file="plot4.png", width=480, height=480)

## Sets up partitions with mfcol
par(mfcol=c(2,2))

## Plots Plot 1
plot(dt$DateTime, dt$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power")

## Plots Plot 2
plot(dt$DateTime, dt$Sub_metering_1, type="l", col="black", xlab="", 
     ylab="Energy sub metering")
lines(dt$DateTime, dt$Sub_metering_2, col="red")
lines(dt$DateTime, dt$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", 
                            "Sub_metering_3"), col=c("black","red", "blue"),
       lty=1, bty="n")

## Plots Plot 3
plot(dt$DateTime, dt$Voltage, type="l", xlab="datetime", 
     ylab="Voltage")

## Plots Plot 4
plot(dt$DateTime, dt$Global_reactive_power, type="l", xlab="datetime", 
     ylab="Global_reactive_power")
dev.off()
