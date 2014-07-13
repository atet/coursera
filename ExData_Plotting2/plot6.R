## AK 20140713
## github: atet
## Ex_Data_Plotting2/plot6.R
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

# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles 
#    County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
# Determine source classification codes (SCC) from data_classification_code that are from motor vehicle
scc_vehicle                 <- data_classification_code[grep("Veh", data_classification_code$Short.Name), ]$SCC
# Convert factor to character
scc_vehicle                 <- as.character(scc_vehicle)
# Subset data_summary_pm25 to only include data using SCC from scc_vehicle
data_summary_pm25_vehicle   <- data_summary_pm25[data_summary_pm25$SCC %in% scc_vehicle,]
# Further subset to only sources from Baltimore City, MD (fips == "24510") and Los Angeles County, CA (fips == "06037")
data_summary_pm25_vehicle_1 <- data_summary_pm25_vehicle[data_summary_pm25_vehicle$fips == "24510",]
data_summary_pm25_vehicle_2 <- data_summary_pm25_vehicle[data_summary_pm25_vehicle$fips == "06037",]
# Determine total emissions these motor vehicle sources for each year
total_emissions_vehicle_1   <- tapply(X = data_summary_pm25_vehicle_1$Emissions, INDEX = data_summary_pm25_vehicle_1$year, FUN = sum)
total_emissions_vehicle_2   <- tapply(X = data_summary_pm25_vehicle_2$Emissions, INDEX = data_summary_pm25_vehicle_2$year, FUN = sum)
# Plot it (need to adjust margins for 960 x 480 pixel output)
par(
  mfrow=c(2,1),
  oma = c(0,0,0,0),
  mar = c(3, 6, 5, 0),
  mgp=c(1.5, 0.5, 0)
  )
# Plot motor vehicle source from Baltimore City, MD
plot <- barplot(
  height = total_emissions_vehicle_1,
  main = "Total PM2.5 Emissions\nFrom Baltimore City, MD Motor\nVehicle Sources Per Year",
  xlab = "Year",
  ylab = "Total PM2.5 Emissions\nFrom Baltimore City, MD Motor\nVehicle Sources (tons)"
)
text(x = plot, y = 0, labels = round(total_emissions_vehicle_1), cex = 1, pos = 3)
# Plot motor vehicle source from Los Angeles County, CA
plot <- barplot(
  height = total_emissions_vehicle_2,
  main = "Total PM2.5 Emissions\nFrom Los Angeles County, CA Motor\nVehicle Sources Per Year",
  xlab = "Year",
  ylab = "Total PM2.5 Emissions\nFrom Los Angeles County, CA Motor\nVehicle Sources (tons)"
)
text(x = plot, y = 0, labels = round(total_emissions_vehicle_2), cex = 1, pos = 3)
# Save out plot
dev.print(
  png,
  file = "~/plot6.png",
  width = 480,
  height = 960
  )
dev.off()
# DONE!