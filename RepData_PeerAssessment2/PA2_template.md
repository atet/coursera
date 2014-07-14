---
title: "Reproducible Research: Peer Assessment 2"
author: "GitHub: atet"
date: "July 14, 2014"
output: html_document
---

---

# TITLE HERE

---

## 1. Synopsis

"Storms and other severe weather events can cause both public health and economic problems for communities and municipalities. Many severe events can result in fatalities, injuries, and property damage, and preventing such outcomes to the extent possible is a key concern."

Here, using the dataset from the U.S. National Oceanic and Atmospheric Administration's (NOAA) storm database (which tracks characteristics of major storms and weather events in the United States, including dates, locations, and estimates of any fatalities, injuries, and property damage), it has been determined that1.) which type(s) of weather events is most harmful with respect to U.S. population health and 2.) which have the greatest economic consequence.

---

## 2. Data Processing
A GitHub repository was created for this document at: https://github.com/atet/coursera/tree/master/RepData_PeerAssessment2

### 2.A Loading Data
  * The original required data file archive `repdata-data-StormData.csv.bz2` and the prepared compressed `repdata-data-StormData.rds` is included in the repository
  * The following code is to convert the original `repdata-data-StormData.csv.bz2` to a compressed R object `repdata-data-StormData.rds`. Since the archive uncompressed is > 100 MB, the following code will download the archive from online, uncompress it locally to home (`~/`), load the local `repdata-data-StormData.csv` file into an R object, and then save it out as `repdata-data-StormData.rds` (which is below the GitHub 100 MB limit):

```r
setwd("~/")
filepath_source      <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
filename             <- "repdata-data-StormData"
filepath_destination <- paste("~/", filename, sep = "")
download.file(url = filepath_source, destfile = paste(filepath_destination, ".csv.bz2", sep = ""), method = "curl")
data                 <- bzfile(description = paste(filepath_destination, ".csv.bz2", sep = ""))
data                 <- read.csv(data, stringsAsFactors = FALSE) # Remember to set stringsAsFactors = FALSE
saveRDS(data, "~/repdata-data-StormData.rds")
# NOTE: repdata-data-StormData.rds is then uploaded to my GitHub repository
# We will use this for the remained of the analysis
```
  * This following code will now load the compressed `repdata-data-StormData.rds` from GitHub into R.

```r
setwd("~/")
filepath_source      <- "https://raw.github.com/atet/coursera/blob/master/RepData_PeerAssessment2/repdata-data-StormData.rds"
filename             <- "repdata-data-StormData"
filepath_destination <- paste("~/", filename, sep = "")
download.file(url = filepath_source, destfile = paste(filepath_destination, ".rds", sep = ""), method = "curl")
data                 <- readRDS(paste(filepath_destination, ".rds", sep = ""))
```
 * This large dataset initially contains 902,297 observations with 37 variables each as seen below:

```r
str(data)
```

```
## 'data.frame':	902297 obs. of  37 variables:
##  $ STATE__   : num  1 1 1 1 1 1 1 1 1 1 ...
##  $ BGN_DATE  : chr  "4/18/1950 0:00:00" "4/18/1950 0:00:00" "2/20/1951 0:00:00" "6/8/1951 0:00:00" ...
##  $ BGN_TIME  : chr  "0130" "0145" "1600" "0900" ...
##  $ TIME_ZONE : chr  "CST" "CST" "CST" "CST" ...
##  $ COUNTY    : num  97 3 57 89 43 77 9 123 125 57 ...
##  $ COUNTYNAME: chr  "MOBILE" "BALDWIN" "FAYETTE" "MADISON" ...
##  $ STATE     : chr  "AL" "AL" "AL" "AL" ...
##  $ EVTYPE    : chr  "TORNADO" "TORNADO" "TORNADO" "TORNADO" ...
##  $ BGN_RANGE : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ BGN_AZI   : chr  "" "" "" "" ...
##  $ BGN_LOCATI: chr  "" "" "" "" ...
##  $ END_DATE  : chr  "" "" "" "" ...
##  $ END_TIME  : chr  "" "" "" "" ...
##  $ COUNTY_END: num  0 0 0 0 0 0 0 0 0 0 ...
##  $ COUNTYENDN: logi  NA NA NA NA NA NA ...
##  $ END_RANGE : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ END_AZI   : chr  "" "" "" "" ...
##  $ END_LOCATI: chr  "" "" "" "" ...
##  $ LENGTH    : num  14 2 0.1 0 0 1.5 1.5 0 3.3 2.3 ...
##  $ WIDTH     : num  100 150 123 100 150 177 33 33 100 100 ...
##  $ F         : int  3 2 2 2 2 2 2 1 3 3 ...
##  $ MAG       : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ FATALITIES: num  0 0 0 0 0 0 0 0 1 0 ...
##  $ INJURIES  : num  15 0 2 2 2 6 1 0 14 0 ...
##  $ PROPDMG   : num  25 2.5 25 2.5 2.5 2.5 2.5 2.5 25 25 ...
##  $ PROPDMGEXP: chr  "K" "K" "K" "K" ...
##  $ CROPDMG   : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ CROPDMGEXP: chr  "" "" "" "" ...
##  $ WFO       : chr  "" "" "" "" ...
##  $ STATEOFFIC: chr  "" "" "" "" ...
##  $ ZONENAMES : chr  "" "" "" "" ...
##  $ LATITUDE  : num  3040 3042 3340 3458 3412 ...
##  $ LONGITUDE : num  8812 8755 8742 8626 8642 ...
##  $ LATITUDE_E: num  3051 0 0 0 0 ...
##  $ LONGITUDE_: num  8806 0 0 0 0 ...
##  $ REMARKS   : chr  "" "" "" "" ...
##  $ REFNUM    : num  1 2 3 4 5 6 7 8 9 10 ...
```

### 2.B Cleaning Data
**2.B.i Date and time**
  * Entries are from 16 different time zones:

```r
time_zones <- data.frame(
  "Abbreviation" = c(
    "SCT","GST","UTC","AST","ADT","EST","EDT",
    "CST","CDT","MST","MDT","PST","PDT","HST","SST"),
  "Description" = c(
    "Seychelles Time","Gulf Standard Time","Universal Time Coordinated",
    "Altantic Standard Time","Altantic Daylight Time","Eastern Standard Time",
    "Eastern Daylight Time","Central Standard Time","Central Daylight Time",
    "Mountain Standard Time","Mountain Daylight Time","Pacific Standard Time",
    "Pacific Daylight Time","Hawaii-Aleutian Standard Time","Samoa Standard Time"),
  "UTC Offset" = c(
    "0400","0400","0000","-0400","-0300","-0500","-0400",
    "-0600","-0500","-0700","-0600","-0800","-0700","-1000",
    "-1100")
  )
knitr::kable(time_zones)
```



|Abbreviation |Description                   |UTC.Offset |
|:------------|:-----------------------------|:----------|
|SCT          |Seychelles Time               |0400       |
|GST          |Gulf Standard Time            |0400       |
|UTC          |Universal Time Coordinated    |0000       |
|AST          |Altantic Standard Time        |-0400      |
|ADT          |Altantic Daylight Time        |-0300      |
|EST          |Eastern Standard Time         |-0500      |
|EDT          |Eastern Daylight Time         |-0400      |
|CST          |Central Standard Time         |-0600      |
|CDT          |Central Daylight Time         |-0500      |
|MST          |Mountain Standard Time        |-0700      |
|MDT          |Mountain Daylight Time        |-0600      |
|PST          |Pacific Standard Time         |-0800      |
|PDT          |Pacific Daylight Time         |-0700      |
|HST          |Hawaii-Aleutian Standard Time |-1000      |
|SST          |Samoa Standard Time           |-1100      |
  * Create a uniform date/time value in UTC (Universal Time, Coordinated) of `POSIX` type using the `$BGN_DATE` and `$BGN_TIME`:

```r
# Trim $BGN_DATE since the date is correct, but the trailing time are all irrelevant 0:00:00
data$date <- gsub(" 0:00:00", "", data$BGN_DATE)
# Clean up timezone $TIME_ZONE, some values need to be changed for consistency
data$TIME_ZONE[data$TIME_ZONE == "CSt"] = "CST" # Typo
data$TIME_ZONE[data$TIME_ZONE == "CSC"] = "CST" # Typo
data$TIME_ZONE[data$TIME_ZONE == "ESt"] = "EST" # Typo
data$TIME_ZONE[data$TIME_ZONE == "ESY"] = "EST" # Typo
data$TIME_ZONE[data$TIME_ZONE == "GMT"] = "UTC" # Change GMT to UTC
data$TIME_ZONE[data$TIME_ZONE == "AKS"] = "HST" # Change AKS to HST
# Nine entries have unknown "UNK" timezones, The appropriate timezone was determined based on their $COUNTYNAME and $STATE
data[data$TIME_ZONE == "UNK", c("date", "COUNTYNAME", "STATE", "TIME_ZONE")]
```

```
##             date COUNTYNAME STATE TIME_ZONE
## 23087  3/31/1973     OCONEE    GA       UNK
## 27702  3/20/1980     HAWAII    HI       UNK
## 30669  8/13/1974      COLES    IL       UNK
## 35244  4/21/1967       RUSH    IN       UNK
## 67899   6/1/1956    HAMPDEN    MA       UNK
## 120704  4/2/1957       LOVE    OK       UNK
## 143198  6/4/1980    PERKINS    SD       UNK
## 154637 5/13/1972   MCLENNAN    TX       UNK
## 160236 5/11/1982  ARMSTRONG    TX       UNK
```

```r
# Detrmined the correct time zones and manually added
data[data$TIME_ZONE == "UNK" & data$COUNTYNAME == "OCONEE",]$TIME_ZONE = "EDT"
data[data$TIME_ZONE == "UNK" & data$COUNTYNAME == "HAWAII",]$TIME_ZONE = "HST"
data[data$TIME_ZONE == "UNK" & data$COUNTYNAME == "COLES",]$TIME_ZONE = "CDT"
data[data$TIME_ZONE == "UNK" & data$COUNTYNAME == "RUSH",]$TIME_ZONE = "EDT"
data[data$TIME_ZONE == "UNK" & data$COUNTYNAME == "HAMPDEN",]$TIME_ZONE = "EDT"
data[data$TIME_ZONE == "UNK" & data$COUNTYNAME == "LOVE",]$TIME_ZONE = "CDT"
data[data$TIME_ZONE == "UNK" & data$COUNTYNAME == "PERKINS",]$TIME_ZONE = "MDT"
data[data$TIME_ZONE == "UNK" & data$COUNTYNAME == "MCLENNAN",]$TIME_ZONE = "CDT"
data[data$TIME_ZONE == "UNK" & data$COUNTYNAME == "ARMSTRONG",]$TIME_ZONE = "CDT"
# Merge data with UTC signed offset time from data frame time_zones
data <- merge(
  x = data, y = time_zones[,c(1,3)],
  by.x = "TIME_ZONE", by.y = "Abbreviation")
# Combine date, time, and UTC offset into a charater vector
data$datetime <- paste(data$date, data$BGN_TIME, data$UTC.Offset, sep = " ")
# Since $BGN_TIME is given in 12-hour and 24-hour format, convert everything to 24-hour format in new column $time_24
time_24h                  <- strptime(data$datetime, format="%m/%d/%Y %H%M %z")     # E.g. "8/18/1994 2322 -0300"
time_12h                  <- strptime(data$datetime, format="%m/%d/%Y %H:%M:%S %p %z") # E.g. "8/28/2001 12:00:00 PM -1100"
time_24h[is.na(time_24h)] <- time_12h[!is.na(time_12h)] # Will produce warning, can ignore
# Make new column time_utc
data$time_utc             <- time_24h
# NOTE: Though there are various additional issues with date and time, there will be no more subsequent cleaning here.
```
**2.B.ii Necessary variables**
  * Subset the source data into only columns that relate to weather event, injury/loss-of-life, and economic impact.
  * Including the date of the event cleaned up previously as `$time_utc`, using the documentation provided by the National Weather Service ([https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf](https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf)), the following variables relate to weather event, injury/loss-of-life, or economic impact.

```r
variables <- data.frame(
  "Variable" = c(
    "time_utc", "EVTYPE","INJURIES","FATALITIES","PROPDMG",
    "PROPDMGEXP","CROPDMG","CROPDMGEXP"),
  "Description" = c(
    "Beginning date and time of event (UTC).", "Type of event.", "Reported injuries from event", 
    "Reported deaths from event.", "Damage to property", "Property damage exponent.", 
    "Damage to agricultural crops.", "Crop damage exponent.")
  )
knitr::kable(time_zones)
```



|Abbreviation |Description                   |UTC.Offset |
|:------------|:-----------------------------|:----------|
|SCT          |Seychelles Time               |0400       |
|GST          |Gulf Standard Time            |0400       |
|UTC          |Universal Time Coordinated    |0000       |
|AST          |Altantic Standard Time        |-0400      |
|ADT          |Altantic Daylight Time        |-0300      |
|EST          |Eastern Standard Time         |-0500      |
|EDT          |Eastern Daylight Time         |-0400      |
|CST          |Central Standard Time         |-0600      |
|CDT          |Central Daylight Time         |-0500      |
|MST          |Mountain Standard Time        |-0700      |
|MDT          |Mountain Daylight Time        |-0600      |
|PST          |Pacific Standard Time         |-0800      |
|PDT          |Pacific Daylight Time         |-0700      |
|HST          |Hawaii-Aleutian Standard Time |-1000      |
|SST          |Samoa Standard Time           |-1100      |
  * Subset the main data into the eight variables appropriate for this analysis.

```r
data <- data[, colnames(data) %in% variables$Variable] 
```
**2.B.iii Monetary values**
  * To determine a single monetary value for property and crop damage, `$PROPDMG`, `$PROPDMGEXP`, `$CROPDMG`, and `$CROPDMGEXP` must be deciphered and combined.
  * The `$PROPDMG` and `$CROPDMG` values are all numerical, I will assume that the corresponding `EXP` columns are 10^exponent multipliers for these values and the value is in U.S dollars.
  * Together, `$PROPDMGEXP` and `$CROPDMGEX` have 20 unique symbols as multipliers:

```
##  [1] ""  "K" "M" "B" "+" "0" "m" "5" "6" "?" "1" "3" "4" "2" "7" "H" "8"
## [18] "h" "-" "k"
```
  * I will assume the following about the different exponent symbols:

```r
# Symbols that are missing (NA), blank (""), "+", "-", or "?" will be replaced with a zero (10^0 = 1)
data$PROPDMGEXP[is.na(data$PROPDMGEXP) | data$PROPDMGEXP == "" |
  data$PROPDMGEXP == "?" | data$PROPDMGEXP == "+" | data$PROPDMGEXP == "-"] <- 0
data$CROPDMGEXP[is.na(data$CROPDMGEXP) | data$CROPDMGEXP == "" |
  data$CROPDMGEXP == "?" | data$CROPDMGEXP == "+" | data$CROPDMGEXP == "-"] <- 0
# Symbols "h" or "H" will be replaced with 2 (H = hundred = 10^2 = 100)
data$PROPDMGEXP[data$PROPDMGEXP == "h" | data$PROPDMGEXP == "H"] <- 2
data$CROPDMGEXP[data$CROPDMGEXP == "h" | data$CROPDMGEXP == "H"] <- 2
# Symbols "k" or "K" will be replaced with 3 (K = kilo = thousand = 10^3 = 1000)
data$PROPDMGEXP[data$PROPDMGEXP == "k" | data$PROPDMGEXP == "K"] <- 3
data$CROPDMGEXP[data$CROPDMGEXP == "k" | data$CROPDMGEXP == "K"] <- 3
# Symbols "m" or "M" will be replaced with 6 (M = mega = million = 10^6 = 1000000)
data$PROPDMGEXP[data$PROPDMGEXP == "m" | data$PROPDMGEXP == "M"] <- 6
data$CROPDMGEXP[data$CROPDMGEXP == "m" | data$CROPDMGEXP == "M"] <- 6
# Symbols "m" or "M" will be replaced with 9 (B = billion = 10^9 = 1000000000)
data$PROPDMGEXP[data$PROPDMGEXP == "b" | data$PROPDMGEXP == "B"] <- 9
data$CROPDMGEXP[data$CROPDMGEXP == "b" | data$CROPDMGEXP == "B"] <- 9
# The remaining symbols are already numberic and assumed correct exponents
# Make column $total_damage that combines the total property and crop damage
data$total_damage <- (data$PROPDMG * (10 ^ as.numeric(data$PROPDMGEXP))) + (data$CROPDMG * (10 ^ as.numeric(data$CROPDMGEXP)))
```
**2.B.iv Event type**
  * Initially, there are 985 different unique `$EVTYPE` which describe the weather event. 

---

## 3. Results

NULL

---

## 4. Discussion

**1. Across the United States, which types of events (as indicated in the EVTYPE variable) are most harmful with respect to population health?**

**2. Across the United States, which types of events have the greatest economic consequences?**

---
---
