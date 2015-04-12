plot3 <- function() {
    
    #Downloading the file
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    temp    <- tempfile()
    download.file(fileURL, temp)
    
    #unzip the file into a table
    data <- read.table(unzip(temp, "household_power_consumption.txt")
                       , header = TRUE, sep = ";", na.strings = "?")
    
    unlink(temp) # <-- Cuts the link to download
 
    sub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007", 
           select=c(Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3))
    
    rm(data)
    
    sub$Date <- as.Date(sub$Date, "%d/%m/%Y")
    sub$dateANDtime <- do.call(paste, c(sub[c("Date", "Time")], sep = " "))
    
    sub$dateANDtime <- as.POSIXct(sub$dateANDtime)
  
    png("plot3.png", width = 480, height = 480)
    
    plot(sub$dateANDtime, sub$Sub_metering_1, 
         type = "n", xlab = "", ylab = "Energy Sub Metering")
    lines(sub$dateANDtime, sub$Sub_metering_1)
    lines(sub$dateANDtime, sub$Sub_metering_2, col = "red")
    lines(sub$dateANDtime, sub$Sub_metering_3, col = "blue")
    
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.75, lty = c(1,1,1), col = c("black", "red", "blue"))
  
    dev.off()
}