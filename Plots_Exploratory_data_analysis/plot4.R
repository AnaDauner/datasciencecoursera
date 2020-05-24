# Coursera - Course 4 - Week 1:
    # Assignment test
    # Plot 4

# Beginning: ====

    # Specify the location of the "household_power_consumption.txt" file:
setwd("C:/Users/.../Desktop/Coursera_R_foundations/Programming_assignments/Data")

# Reading and tidying the data: ====

tab_titles <- read.table("household_power_consumption.txt", nrows = 1, sep = ";",
                         stringsAsFactors=FALSE)

tab_values <- read.table("household_power_consumption.txt", header = FALSE, 
                         skip = 66637, nrows = 2880, sep = ";", na.strings = "?")


Date_Time <- paste(tab_values[ ,1], tab_values[ ,2], sep=" ")
Date_Time <- strptime(x = Date_Time, format = "%d/%m/%Y %H:%M:%S")
class(Date_Time)

tab <- data.frame(Date_Time, tab_values[3:9])

tab_titles <- as.character(tab_titles[1, 3:9])
names(tab) <- c("Date_Time", tab_titles)


# Plot 4: ====

png(filename = "plot4.png",
    width = 480, height = 480, units = "px")

    # Obs: "LC_COLLATE = Portuguese_Brazil"
    # Thus, the default language used in the plots is the brazilian Portuguese.

par(mfrow = c(2,2))

# plot 4.1:
plot(tab$Date_Time, tab$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = " ")

# plot 4.2:
plot(tab$Date_Time, tab$Voltage, type = "l",
     ylab = "Voltage",
     xlab = "datetime")

# plot 4.3:
plot(tab$Date_Time, tab$Sub_metering_1, type = "l",
     ylab = "Energy sub meeting",
     xlab = " ")
lines(tab$Date_Time, tab$Sub_metering_2, type = "l", col = "red")
lines(tab$Date_Time, tab$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

# plot 4.4:
plot(tab$Date_Time, tab$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime")


dev.off()

