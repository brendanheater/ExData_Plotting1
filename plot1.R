plot1 <- function() {
    
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
                  select=c(Date, Global_active_power))
    rm(data)
    
    ##simple histogram call, assiging title and label for X axis
    hist(sub$Global_active_power, col="red", 
         xlab = "Global Active Power (kilowatts)",
         main = "Global Active Power")
        
}