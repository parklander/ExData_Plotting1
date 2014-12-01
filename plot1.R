#plot1.R generates the first plot of the assignment.

#install required packages and load libraries
require("sqldf") # used to extract rows with the correct dates

#get data
url = "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
zfn = "PUMS_2010_2012.zip" # name of zip file
fn = "household_power_consumption.txt" # file name

#check to see if household_power_consumption.txt exists, if not extract it
if(!file.exists(fn)) {
    print("not found")
    #check for the zip file, if it doesn't exist in the working directory download it
    if(!file.exists(zfn)) download.file(url, zfn)
    unzip(zfn, fn)
}

#load data from file into dataframe df, only lines with dates 2007-02-01 and 2007-02-02
df <- read.csv.sql(fn, sep = ";", sql = 'select * from file where (Date == "1/2/2007" OR Date == "2/2/2007")')

#convert Date and Time fields to datetime POSIXlt field.
df$datetime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S", tz="UTC")

##Plot 1
png("plot1.png", width=480, height=480)
hist(df$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main="Global Active Power")
dev.off()