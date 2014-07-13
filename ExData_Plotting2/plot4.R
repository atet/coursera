## AK 20140713
## github: atet
## Ex_Data_Plotting2/plot4.R
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

# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
# Determine source classification codes (SCC) from data_classification_code that are coal combustion-related (not including Charcoal)
scc_coal                    <- data_classification_code[grep("Coal", data_classification_code$Short.Name), ]$SCC
# Convert factor to character
scc_coal                    <- as.character(scc_coal)
# Subset data_summary_pm25 to only include data using SCC from scc_coal
data_summary_pm25_coal      <- data_summary_pm25[data_summary_pm25$SCC %in% scc_coal,]
# Determine total emissions these coal sources for each year
total_emissions_coal        <- tapply(X = data_summary_pm25_coal$Emissions, INDEX = data_summary_pm25_coal$year, FUN = sum)
# Plot it (need to adjust margins for 480 x 480 pixel output)
par(
  mfrow=c(1,1),
  oma = c(0,0,0,0), 
  mar = c(3, 5, 4, 0), 
  mgp=c(1.5, 0.5, 0)
  )
# Plot coal source
plot <- barplot(
  height = total_emissions_coal,
  main = "Total PM2.5 Emissions\nFrom Coal Sources Per Year", 
  xlab = "Year",
  ylab = "Total PM2.5 Emissions\nFrom Coal Sources (tons)"
)
text(x = plot, y = 0, labels = round(total_emissions_coal), cex = 1, pos = 3)

# Save out plot
dev.print(
  png,
  file = "~/plot4.png",
  width = 480,
  height = 480
  )
dev.off()
# DONE!