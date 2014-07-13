## AK 20140712
## github: atet
## NOTE: I am submitting this early, but seeing how this is a public repos, anyone can see it right away.
## If you need help, you can use this as a guide to understanding the problem, but please do not just copy/paste this code.
## R has a steep learning curve, but you will get it with time and experience, I have faith in you.
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


#####################################################################################################
## AK 20140712
## github: atet
## file:   plot1.R
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
# plot1 code
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

# plot1 is a histogram of Global Active Power and save out as PNG named plot1.png
# Convert data$Global_active_power from character to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)
# Open PNG device with filename to save out to and set dimensions to 480 x 480 pixels
png(
  filename = "~/plot1.png",
  width = 480,
  height = 480
  )
# Some aesthetics include red bars, x axis label, and a main title
hist(
  x = data$Global_active_power,
  col = "red",
  xlab = "Global Active Power (kilowatts)",
  main = "Global Active Power"
  )
# Turn off PNG device to save to file
dev.off()

# DONE!







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






#####################################################################################################
## AK 20140712
## github: atet
## file:   plot3.R
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
# plot3 code
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
# For plot3, make a new column $Date_Time that is a Date object that also has the time of day considered
data$Date_Time       <- paste(as.character(data$Date), data$Time)
# Convert the $Date_Time column to POSIX date type
data$Date_Time       <- strptime(data$Date_Time, format = "%Y-%m-%d %H:%M:%S")

# plot3 is a plot of $Sub_metering1-3 as a function of $Date_Time and save out as PNG named plot3.png
# Coerce all Sub_metering_1-3 to numeric
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Open PNG device with filename to save out to and set dimensions to 480 x 480 pixels
png(
  filename = "~/plot3.png",
  width = 480,
  height = 480
)
# Make an empty plot first with no points using $Sub_metering_1 since it contains the max value to correctly scale the y axis
# Some aesthetics include lines only, y axis label, and no x axis label or main title
plot(  
  x = data$Date_Time,
  y = data$Sub_metering_1,
  type = "n",
  xlab = "",
  ylab = "Energy sub metering"
)
# Fill in with black lines instead of points for Sub_metering_1
lines(
  x = data$Date_Time,
  y = data$Sub_metering_1,
  col = "black"
)
# Fill in with red lines instead of points for Sub_metering_2
lines(
  x = data$Date_Time,
  y = data$Sub_metering_2,
  col = "red"
)
# Fill in with blue lines instead of points for Sub_metering_3
lines(
  x = data$Date_Time,
  y = data$Sub_metering_3,
  col = "blue"
)
# Add legend in top right position, legend labels, line symbols, and color of symbols
legend(
  x = "topright", 
  legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
  col = c("black","red","blue"),
  lty = c(1, 1, 1)
  )

# Turn off PNG device to save to file
dev.off()

# DONE!







#####################################################################################################
## AK 20140712
## github: atet
## file:   plot4.R
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
# plot4 code
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
# Make a new column $Date_Time that is a Date object that also has the time of day considered
data$Date_Time       <- paste(as.character(data$Date), data$Time)
# Convert the $Date_Time column to POSIX date type
data$Date_Time       <- strptime(data$Date_Time, format = "%Y-%m-%d %H:%M:%S")

# Coerce $Global_active_power, $Sub_metering_1-3, and $Global_reactive_power from character to numeric
data$Global_active_power   <- as.numeric(data$Global_active_power)
data$Sub_metering_1        <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2        <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3        <- as.numeric(data$Sub_metering_3)
data$Voltage               <- as.numeric(data$Voltage)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)

# Open PNG device with filename to save out to and set dimensions to 480 x 480 pixels
png(
  filename = "~/plot4.png",
  width = 480,
  height = 480
)
# plot4 combines the previous plot2, plot3 (with some aesthetic changes), and two new plots together in a single plot. Each plot will be made one at a time.
# Set up the "frame" for the multiple plots
par(mfcol=c(2,2))
# 1. Plot that will appear in the top left (plot2 but y axis label is different)
# Some aesthetics include lines only, y axis label, and no x axis label or main title
plot(  
  x = data$Date_Time,
  y = data$Global_active_power,
  type = "n",
  xlab = "",
  ylab = "Global Active Power"
)
lines(
  x = data$Date_Time,
  y = data$Global_active_power,
)
# 2. Plot that will appear in the bottom left (plot3 but the legend does not have a border)
# Make an empty plot first with no points using $Sub_metering_1 since it contains the max value to correctly scale the y axis
# Some aesthetics include lines only, y axis label, and no x axis label or main title
plot(  
  x = data$Date_Time,
  y = data$Sub_metering_1,
  type = "n",
  xlab = "",
  ylab = "Energy sub metering"
)
# Fill in with black lines instead of points for Sub_metering_1
lines(
  x = data$Date_Time,
  y = data$Sub_metering_1,
  col = "black"
)
# Fill in with red lines instead of points for Sub_metering_2
lines(
  x = data$Date_Time,
  y = data$Sub_metering_2,
  col = "red"
)
# Fill in with blue lines instead of points for Sub_metering_3
lines(
  x = data$Date_Time,
  y = data$Sub_metering_3,
  col = "blue"
)
# Add legend in top right position, legend labels, line symbols, color of symbols, no legend border
legend(
  x = "topright", 
  legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
  col = c("black","red","blue"),
  lty = c(1, 1, 1),
  bty = "n"
)
# 3. Plot that will appear in the top right, new plot that is $Voltage as a function of $Date_Time
# Some aesthetics include lines only, y and x axis label
plot(  
  x = data$Date_Time,
  y = data$Voltage,
  type = "n",
  xlab = "datetime",
  ylab = "Voltage"
)
lines(
  x = data$Date_Time,
  y = data$Voltage,
)

# 4. Plot that will appear in the bottom right, new plot that is $Global_reactive_power as a function of $Date_Time
plot(  
  x = data$Date_Time,
  y = data$Global_reactive_power,
  type = "n",
  xlab = "datetime",
  ylab = "Global_reactive_power"
)
lines(
  x = data$Date_Time,
  y = data$Global_reactive_power,
)

# Turn off PNG device to save to file
dev.off()

# DONE!





