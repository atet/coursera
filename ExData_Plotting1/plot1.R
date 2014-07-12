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

# Load data
data_path <- "~/Documents/Dropbox/Coursera/Exploratory_Data_Analysis_20140707/CP1/household_power_consumption.txt"
# There is a header and the delimiter is a semicolon
data      <- read.table(data_path, header = TRUE, sep = ";", stringsAsFactors = FALSE)
# We only need data from dates 2007-02-01 and 2007-02-02
# First convert the $Date column to Date type
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
# Get the needed dates
data      <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

# plot1 is a histogram of Global Active Power and save out as PNG named plot1.png
# Convert data$Global_active_power from character to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)
# Open PNG device with filename to save out to and set dimensions to 480 x 480 pixels
png(
  filename = "~/Documents/Dropbox/Coursera/Exploratory_Data_Analysis_20140707/CP1/plot1.png",
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