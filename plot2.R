plot2 <- function() {
    
    #Downloading the file
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    temp    <- tempfile()
    download.file(fileURL, temp)
    
    #unzip the file into a table
    data <- read.table(unzip(temp, "household_power_consumption.txt")
                       , header = TRUE, sep = ";", na.strings = "?")
    
    unlink(temp) # <-- Cuts the link to download
    
    sub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007", 
                  select=c(Date, Time, Global_active_power))
    rm(data)
    
    sub$Date <- as.Date(sub$Date, "%d/%m/%Y")
    sub$dateANDtime <- do.call(paste, c(sub[c("Date", "Time")], sep = " "))
    
    sub$dateANDtime <- as.POSIXct(sub$dateANDtime)
    
    plot(sub$dateANDtime, sub$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
    lines(sub$dateANDtime, sub$Global_active_power)
    
    dev.copy(png, "plot2.png")
    dev.off()
    
}