plot4 <- function() {
    
    #Downloading the file
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    temp    <- tempfile()
    download.file(fileURL, temp)
    
    #unzip the file into a table
    data <- read.table(unzip(temp, "household_power_consumption.txt")
                       , header = TRUE, sep = ";", na.strings = "?")
    
    unlink(temp) # <-- Cuts the link to download
    
    sub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007") 
    
    rm(data)
    
    sub$Date <- as.Date(sub$Date, "%d/%m/%Y")
    sub$dateANDtime <- do.call(paste, c(sub[c("Date", "Time")], sep = " "))
    
    sub$dateANDtime <- as.POSIXct(sub$dateANDtime)
   
    png("plot4.png", width = 480, height = 480)
    
    par(mfrow = c(2,2))
    with(sub, {
        #top left plot
        plot(dateANDtime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power")
        lines(dateANDtime, Global_active_power)
        
        #top right plot
        plot(dateANDtime, Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
        lines(dateANDtime, Voltage)
        
        #bottom left plot
        plot(dateANDtime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", lty = c(1,1,1), col = c("black", "red", "blue"))
        lines(dateANDtime, Sub_metering_1)
        lines(dateANDtime, Sub_metering_2, col = "red")
        lines(dateANDtime, Sub_metering_3, col = "blue")
        
        #bottom right plot
        plot(dateANDtime, Global_reactive_power, type = "n", xlab = "datetime")
        lines(dateANDtime, Global_reactive_power)
        })
    
    dev.off()
}