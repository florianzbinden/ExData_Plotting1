
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

par(mfrow = c(1, 1))


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

hist(as.numeric(sub_all$Global_active_power), 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", 
     col = "red",
     ylim = c(0, 1200))

dev.copy(png, file = "plot1.png")
dev.off()

