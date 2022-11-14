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


## Plotting the graph into PNG file.
png(file="plot2.png", width=480, height=480)
plot(dt$DateTime, dt$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()
