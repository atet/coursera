#####################################################################################################
## AK 20140712
## github: atet
## file:   plot2.R
#####################################################################################################
# Goal: Make plots, examine how household energy usage varies over a 2-day period in February, 2007.
#   Your task is to reconstruct the following 4 plots below, all of which were constructed using
#   the base plotting system.
# Instuctions:
# 1. We will only be using data from the dates 2007-02-01 and 2007-02-02.
# 2. Construct the plot (using base) and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# 3. Name each of the plot files as plot1.png, plot2.png, etc.
# 4. Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot,
#      i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code
#      for reading the data so that the plot can be fully reproduced. You should also include
#      the code that creates the PNG file.
# 5. Add the PNG file and R code file to your git repository

##################
# plot2 code
##################

filepath_source      <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename             <- "household_power_consumption"
filepath_destination <- paste("~/", filename, sep = "") # Destination is home
# Download the data file from source to local home destination
download.file(url = filepath_source, destfile = paste(filepath_destination, ".zip", sep = ""), method = "curl")
# Uncompress zip file information
data                 <- unz(description = paste(filepath_destination, ".zip", sep = ""), filename = paste(filename, ".txt", sep = ""))
# Load file, there is a header and the delimiter is a semicolon
data                 <- read.table(data, header = TRUE, sep = ";", stringsAsFactors = FALSE)
# We only need data from dates 2007-02-01 and 2007-02-02
# Convert the $Date column to Date type
data$Date            <- as.Date(data$Date, format = "%d/%m/%Y")
# Get the needed dates
data                 <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]
# For plot2, make a new column $Date_Time that is a Date object that also has the time of day considered
data$Date_Time       <- paste(as.character(data$Date), data$Time)
# Convert the $Date_Time column to POSIX date type
data$Date_Time       <- strptime(data$Date_Time, format = "%Y-%m-%d %H:%M:%S")


# plot2 is a plot of Global Active Power as a function of $Time and $Date and save out as PNG named plot2.png
# Convert data$Global_active_power from character to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)
# Open PNG device with filename to save out to and set dimensions to 480 x 480 pixels
png(
  filename = "~/plot2.png",
  width = 480,
  height = 480
)
# Some aesthetics include lines only, y axis label, and no x axis label or main title
plot(  
  x = data$Date_Time,
  y = data$Global_active_power,
  type = "n",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)
lines(
  x = data$Date_Time,
  y = data$Global_active_power,
  xlab = "Global Active Power (kilowatts)"
)
# Turn off PNG device to save to file
dev.off()

# DONE!