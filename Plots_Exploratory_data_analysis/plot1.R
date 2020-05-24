# Coursera - Course 4 - Week 1:
    # Assignment test
    # Plot 1

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


# Plot 1: ====

png(filename = "plot1.png",
    width = 480, height = 480, units = "px")

hist(tab$Global_active_power, col = "red",
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()

