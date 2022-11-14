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


## Plotting into PNG file.
png(file="plot1.png",
    width=480, height=480)
hist(dt$Global_active_power, col="red", main="Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()

