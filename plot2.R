plot2 <- function() {
    
    ##Downloading the file
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    temp    <- tempfile()
    download.file(fileURL, temp)
    
    ##unzip the file into a table
    data <- read.table(unzip(temp, "household_power_consumption.txt")
                       , header = TRUE, sep = ";", na.strings = "?")
    
    unlink(temp) ## <-- Cuts the link to download
    
    ##create a subset of the data over two days, selected columns
    sub <- subset(data, Date == "1/2/2007" | Date == "2/2/2007", 
                  select=c(Date, Time, Global_active_power))
    rm(data)
    
    ##saves the date as a date, identifying day/month/year convention
    ##creates new column combining date and time
    ##identifies that this is the Date/Time convention the computer uses
    sub$Date <- as.Date(sub$Date, "%d/%m/%Y")
    sub$dateANDtime <- do.call(paste, c(sub[c("Date", "Time")], sep = " "))
    sub$dateANDtime <- as.POSIXct(sub$dateANDtime)
    
    ##creates a plot without points (type n)
    ##adds lines to the non-existant points
    plot(sub$dateANDtime, sub$Global_active_power, 
         type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
    lines(sub$dateANDtime, sub$Global_active_power)
    
    ##copies the created plot to a png file
    dev.copy(png, "plot2.png")
    dev.off()
    
}