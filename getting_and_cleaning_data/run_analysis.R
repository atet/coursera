## AK 20140519
## github: atet
## NOTE: I am submitting this early, but seeing how this is a public repos, anyone can see it right away.
## If you need help, you can use this as a guide to understanding the problem, but please do not just copy/paste this code.
## R has a steep learning curve, but you will get it with time and experience, I have faith in you.
#####################################################################################################

## Set default stringsAsFactors to FALSE
options(stringsAsFactors = FALSE)

## Set working directory to my local directory where the files are located
setwd("~/git_coursera/getting_and_cleaning_data")

## 1. Let's start loading data from files and putting them into a data frame
## NOTE: Remember, there are 33 variables (e.g. tBodyAcc-X, tBodyAcc-Y...) time 17 estimates (e.g. mean, standard deviation...) = 561 variables
measurement_names    <- read.table("./UCI HAR Dataset/features.txt", col.names = c("num","measurement_name"))

## 1A.Training data
train_measurements   <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = measurement_names$measurement_name, check.names = FALSE)
## Subset mean ("mean()") and standard deviation ("std()") for each of the 33 measurements, e.g. tBodyAcc-mean()-X, tBodyAcc-std()-X...
train_measurements   <- train_measurements[,grep(c("mean\\(\\)|std\\(\\)"), colnames(train_measurements))]
## Load subject labels for training measurements
train_subject_label  <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
## Load activity labels for training measurements
train_activity_label <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activity")
## Combine training subject labels, activity labels, and measurements
train_data           <- cbind(train_subject_label, train_activity_label, train_measurements)
## 1B. Testing data
test_measurements    <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = measurement_names$measurement_name, check.names = FALSE)
## Subset mean ("mean()") and standard deviation ("std()") for each of the 33 measurements, e.g. tBodyAcc-mean()-X, tBodyAcc-std()-X...
test_measurements    <- test_measurements[,grep(c("mean\\(\\)|std\\(\\)"), colnames(test_measurements))]
## Load subject labels for testing measurements
test_subject_label   <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
## Load activity labels for testing measurements
test_activity_label  <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activity")
## Combine testing subject labels, activity labels, and measurements
test_data            <- cbind(test_subject_label, test_activity_label, test_measurements)
## 1C. rbind together the training and test data into one data frame
full_data <- rbind(train_data, test_data)

## 2. Determine the average value of each of the 66 measurements for each subject's replicate activity data.
##    E.g. Subject 1 performed activity 5 27 times, get the average for each of the 66 measurements for all 27 replicates.
## 2A. Split the full_data data frame by subject and activity
split_by   <- list(full_data$subject, full_data$activity)
split_data <- split(full_data, split_by)

## 2B. Determine means of each measurement from split data
## Function that will take the incoming split as a data frame (i.e. measurements split by subject and activity) and determine the means for each column of measurements.
FUNCTION_COL_MEANS <- function(incoming_data_frame){
  column_means <- colMeans(incoming_data_frame) # The mean of the same subject number and activity number is the same number
  ## Coerce vector into a matrix.
  column_means <- as.matrix(column_means)
  ## Now that this is a matrix, we can transpose it.
  column_means <- t(column_means)
  ## Coerce the matrix into a data frame to be appended later.
  column_means <- as.data.frame(column_means, check.names = FALSE)
  ## Return this data as a horizontal row for use with rbind  
  return(column_means)
}
## Apply the above funtion for each split and return as a list of data frames
split_data <- lapply(X = split_data, FUN = FUNCTION_COL_MEANS)
## Row bind (rbind) together all the data frames in the list into a single data frame
tidy_data <- do.call(rbind, split_data)
## Eliminate the row names because they are uninformative
rownames(tidy_data) = NULL

## 3. Clean up column names/labels
## 3A.Get rid of "illegal" characters in column name such as parentheses and hyphens. Get rid of parentheses and turn hyphens into underscores.
colnames(tidy_data) <- gsub("\\(\\)", "", colnames(tidy_data))
colnames(tidy_data) <- gsub("-", "_", colnames(tidy_data))
## 3B. Renaming the column names to be consistent with the treatment applied, i.e. since the mean of all tBodyAcc_mean_X measurements have been calculated, change name to mean_of_tBodyAcc_mean_X
colnames(tidy_data)[3:68] <- paste("mean_of_", colnames(tidy_data)[3:68], sep = "")
## 3C. Use descriptive activity names instead of the numbers
activities_names <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activity","activity_name"))
tidy_data        <- merge(activities_names, tidy_data, by = "activity", all.x = TRUE)

## 4. Save out tidy data to *.txt file.
write.table(tidy_data, "./tidy_data.txt")

## 5. Reopen file for confirmation.
check <- read.table("./tidy_data.txt")








