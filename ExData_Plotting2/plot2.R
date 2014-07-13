## AK 20140712
## github: atet
## Ex_Data_Plotting2/plot2.R
## NOTE: I am submitting this early, but seeing how this is a public repos, anyone can see it right away.
## If you need help, you can use this as a guide to understanding the problem, but please do not just copy/paste this code.
## R has a steep learning curve, but you will get it with time and experience, I have faith in you.
#####################################################################################################

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

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#    Use the base plotting system to make a plot answering this question.
# Subset out only Baltimore City, MD data.
data_summary_pm25_baltimore <- data_summary_pm25[data_summary_pm25$fips == "24510",]

# Determine total emissions from all sources for each year
total_emissions = tapply(X = data_summary_pm25_baltimore$Emissions, INDEX = data_summary_pm25_baltimore$year, FUN = sum)
# Plot it (need to adjust margins for 480 x 480 pixel output)
par(
  oma = c(0,0,0,0),
  mar = c(3, 6, 5, 0),
  mgp=c(1.5, 0.5, 0))
plot <- barplot(
  height = total_emissions,
  main = "Total PM2.5 Emissions\nFrom All Baltimore City, MD\nSources Per Year", 
  xlab = "Year",
  ylab = "Total PM2.5 Emissions\nFrom All Baltimore City, MD\nSources (tons)"
)
text(x = plot, y = 0, labels = round(total_emissions), cex = 1, pos = 3)
# Save out plot
dev.print(
  png,
  file = "~/plot2.png",
  width = 480,
  height = 480)
dev.off()
# DONE!