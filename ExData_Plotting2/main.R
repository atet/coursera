## AK 20140712
## github: atet
## NOTE: I am submitting this early, but seeing how this is a public repos, anyone can see it right away.
## If you need help, you can use this as a guide to understanding the problem, but please do not just copy/paste this code.
## R has a steep learning curve, but you will get it with time and experience, I have faith in you.
#####################################################################################################

#    The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about 
# fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you 
# want to support your analysis.

#    You must address the following questions and tasks in your exploratory analysis. For each question/task you will need 
# to make a single plot. Unless specified, you can use any plotting system in R to make your plot.
# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
#    make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#    Use the base plotting system to make a plot answering this question.
# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these 
#    four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions 
#    from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles 
#    County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

# Load the neccessary data
# Source filepath from course page
filepath_source             <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
# Destination filepath
filepath_destination        <- "~/FNEI_data.zip"
# Download file
download.file(url = filepath_source, destfile = filepath_destination, method = "curl")
# Unzip file
unzip(filepath_destination)
# Load the two R objects
data_classification_code    <- readRDS("~/Source_Classification_Code.rds")
data_summary_pm25           <- readRDS("~/summarySCC_PM25.rds")

# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
#    make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
# Determine total emissions from all sources for each year
total_emissions = tapply(X = data_summary_pm25$Emissions, INDEX = data_summary_pm25$year, FUN = sum)
# Plot it
par(oma = c(0,0,0,0), mar = c(3, 5, 4, 0), mgp=c(1.5, 0.5, 0))
plot <- barplot(
  height = total_emissions,
  main = "Total PM2.5 Emissions\nFrom All Sources Per Year", 
  xlab = "Year",
  ylab = "Total PM2.5 Emissions\nFrom All Sources (tons)"
)
text(x = plot, y = 0, labels = round(total_emissions), cex = 1, pos = 3)
# Save out plot
dev.print(png, file = "~/plot1.png", width = 480, height = 480)
dev.off()

# Has the average changed??? No.
# "outline = FALSE" parameter removes outliers (e.g. The high outlier in 2002)
boxplot(
  Emissions ~ year, 
  data = data_summary_pm25, 
  main = "PM2.5 Emissions From All Sources Per Year", 
  xlab = "Year", ylab = "PM2.5 Emissions From All Sources (tons)",
  outline = FALSE
  )


# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#    Use the base plotting system to make a plot answering this question.


