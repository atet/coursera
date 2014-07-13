## AK 20140713
## github: atet
## Ex_Data_Plotting2/plot5.R
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

# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# Determine source classification codes (SCC) from data_classification_code that are from motor vehicle
scc_vehicle                 <- data_classification_code[grep("Veh", data_classification_code$Short.Name), ]$SCC
# Convert factor to character
scc_vehicle                 <- as.character(scc_vehicle)
# Subset data_summary_pm25 to only include data using SCC from scc_vehicle
data_summary_pm25_vehicle   <- data_summary_pm25[data_summary_pm25$SCC %in% scc_vehicle,]
# Further subset to only sources from Baltimore City, MD (fips == "24510")
data_summary_pm25_vehicle   <- data_summary_pm25_vehicle[data_summary_pm25_vehicle$fips == "24510",]
# Determine total emissions these motor vehicle sources for each year
total_emissions_vehicle     <- tapply(X = data_summary_pm25_vehicle$Emissions, INDEX = data_summary_pm25_vehicle$year, FUN = sum)
# Plot it (need to adjust margins for 480 x 480 pixel output)
par(
  mfrow=c(1,1),
  oma = c(0,0,0,0),
  mar = c(3, 6, 5, 0),
  mgp=c(1.5, 0.5, 0)
  )
# Plot motor vehicle source
plot <- barplot(
  height = total_emissions_vehicle,
  main = "Total PM2.5 Emissions\nFrom Baltimore City, MD Motor\nVehicle Sources Per Year",
  xlab = "Year",
  ylab = "Total PM2.5 Emissions\nFrom Baltimore City, MD Motor\nVehicle Sources (tons)"
)
text(x = plot, y = 0, labels = round(total_emissions_vehicle), cex = 1, pos = 3)

# Save out plot
dev.print(
  png,
  file = "~/plot5.png",
  width = 480,
  height = 480
  )
dev.off()
# DONE!