
## data extraction
# WD MAC
setwd("/Users/fisoflo/Documents/coursera/stat/R_Hopkins/EDA/project1")
# WD PC
# setwd("C:/Users/ZBINDEF/Documents/RStudio/data/EDA")
sub_all <- NULL
data <- NULL
sub_data <- NULL
dates <- NULL
times <- NULL
string_date_time <- NULL
Date_Time_col <- NULL
t_start <- NULL
t_stop <- NULL


data <- read.table("household_power_consumption.txt", sep = ";", colClasses = "character", header = T, na.strings = c("?"))

dates <- data$Date #head(data$Date)
times <- data$Time #head(data$Time)
string_date_time <- paste(dates, times)
Date_Time_col <- strptime(string_date_time, "%d/%m/%Y %H:%M:%S")

sub_data <- cbind(Date_Time_col, data[, -(c(1,2))])

t_start <- as.POSIXct("2007/02/01 00:00:00", format="%Y/%m/%d %H:%M:%S" )
t_stop <- as.POSIXct("2007/02/03 00:00:00", format="%Y/%m/%d %H:%M:%S" )
sub_all <- NULL
sub_all <- na.omit(sub_data[(as.POSIXct(sub_data$Date_Time_col, format="%Y/%m/%d %H:%M:%S")) >= t_start & (as.POSIXct(sub_data$Date_Time_col, format="%Y/%m/%d %H:%M:%S")) < t_stop, ]
)

par(mfrow = c(2, 2))

plot(as.numeric(sub_all$Global_active_power)~ sub_all$Date_Time_col,
     xlab = "",
     ylab = "Global Active Power", 
     type = "l" )

plot(as.numeric(sub_all$Voltage)~ sub_all$Date_Time_col,
     xlab = "datetime",
     ylab = "Voltage", 
     type = "l" )

plot(as.numeric(sub_all$Sub_metering_1) ~ sub_all$Date_Time_col,
     xlab = "",
     ylab = "Energy sub metering", 
     type = "l",
     col = "black" )
points(as.numeric(sub_all$Sub_metering_2) ~ sub_all$Date_Time_col, type = "l", col = "red")
points(as.numeric(sub_all$Sub_metering_3) ~ sub_all$Date_Time_col, type = "l", col = "blue")
legend("topright", lty=1, col = c("black", "red", "blue" ), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.4, bty = "n")

plot(as.numeric(sub_all$Global_reactive_power)~ sub_all$Date_Time_col,
     xlab = "",
     ylab = "Global_reactive_power", 
     type = "l" )

dev.copy(png, file = "plot4.png")
dev.off()
