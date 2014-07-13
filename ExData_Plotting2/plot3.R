## AK 20140712
## github: atet
## Ex_Data_Plotting2/plot3.R
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

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these 
#    four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions 
#    from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
# Subset out each source type.
data_summary_pm25_point    <- data_summary_pm25[data_summary_pm25$type == "POINT",]
data_summary_pm25_nonpoint <- data_summary_pm25[data_summary_pm25$type == "NONPOINT",]
data_summary_pm25_onroad   <- data_summary_pm25[data_summary_pm25$type == "ON-ROAD",]
data_summary_pm25_nonroad  <- data_summary_pm25[data_summary_pm25$type == "NON-ROAD",]

# Determine total emissions from all sources for each year
total_emissions_point      <- tapply(X = data_summary_pm25_point$Emissions, INDEX = data_summary_pm25_point$year, FUN = sum)
total_emissions_nonpoint   <- tapply(X = data_summary_pm25_nonpoint$Emissions, INDEX = data_summary_pm25_nonpoint$year, FUN = sum)
total_emissions_onroad     <- tapply(X = data_summary_pm25_onroad$Emissions, INDEX = data_summary_pm25_onroad$year, FUN = sum)
total_emissions_nonroad    <- tapply(X = data_summary_pm25_nonroad$Emissions, INDEX = data_summary_pm25_nonroad$year, FUN = sum)
# Plot it (need to adjust margins for 960 x 960 pixel output)
par(
  mfrow=c(2,2),
  oma = c(0,0,0,0),
  mar = c(3, 6, 5, 0),
  mgp=c(1.5, 0.5, 0)
  )
# Plot point source
plot <- barplot(
  height = total_emissions_point,
  main = "Total PM2.5 Emissions\nFrom Point Sources Per Year", 
  xlab = "Year",
  ylab = "Total PM2.5 Emissions\nFrom Point Sources (tons)"
)
text(x = plot, y = 0, labels = round(total_emissions_point), cex = 1, pos = 3)
# Plot non-point source
plot <- barplot(
  height = total_emissions_nonpoint,
  main = "Total PM2.5 Emissions\nFrom Non-Point Sources Per Year", 
  xlab = "Year",
  ylab = "Total PM2.5 Emissions\nFrom Non-Point Sources (tons)"
)
text(x = plot, y = 0, labels = round(total_emissions_nonpoint), cex = 1, pos = 3)
# Plot on-road source
plot <- barplot(
  height = total_emissions_onroad,
  main = "Total PM2.5 Emissions\nFrom On-Road Sources Per Year", 
  xlab = "Year",
  ylab = "Total PM2.5 Emissions\nFrom On-Road Sources (tons)"
)
text(x = plot, y = 0, labels = round(total_emissions_onroad), cex = 1, pos = 3)
# Plot non-road source
plot <- barplot(
  height = total_emissions_nonroad,
  main = "Total PM2.5 Emissions\nFrom Non-Road Sources Per Year", 
  xlab = "Year",
  ylab = "Total PM2.5 Emissions\nFrom Non-Road Sources (tons)"
)
text(x = plot, y = 0, labels = round(total_emissions_nonroad), cex = 1, pos = 3)

# Save out plot
dev.print(
  png,
  file = "~/plot3.png",
  width = 960,
  height = 960
  )
dev.off()
# DONE!