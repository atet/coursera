#Getting and Cleaning Data Course Project
##CodeBook.md
---

- Data Description (adapted from Reyes-Ortiz et al.)
	- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
	- Triaxial Angular velocity from the gyroscope. 
	- A 561-feature vector with time and frequency domain variables.
	- **NOTE: Inertial values were not used in this project, only the derived and manually labeled values were.**
- Variables (adapted from Reyes-Ortiz et al.)
	- Features selected come from accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
	- Time domain signals (prefix 't' to denote time) captured at a constant 50 Hz.
	- Filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.
	- Acceleration signal separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.
	- Body linear acceleration and angular velocity derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ).
	- Magnitude of three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).
	- Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
	- The 561 features consists of 33 measurements with 17 estimations described in the HAR dataset. **Only the mean and standard deviation estimations was used in this project**.
		- Thirty-three measurements considered, **all 33 have been deemed to be useful in subsequent analyses**:
			- tBodyAcc-X
			- tBodyAcc-Y
			- tBodyAcc-Z
			- tGravityAcc-X
			- tGravityAcc-Y
			- tGravityAcc-Z
			- tBodyAccJerk-X
			- tBodyAccJerk-Y
			- tBodyAccJerk-Z
			- tBodyGyro-X
			- tBodyGyro-Y
			- tBodyGyro-Z
			- tBodyGyroJerk-X
			- tBodyGyroJerk-Y
			- tBodyGyroJerk-Z
			- tBodyAccMag
			- tGravityAccMag
			- tBodyAccJerkMag
			- tBodyGyroMag
			- tBodyGyroJerkMag
			- fBodyAcc-X
			- fBodyAcc-Y
			- fBodyAcc-Z
			- fBodyAccJerk-X
			- fBodyAccJerk-Y
			- fBodyAccJerk-Z
			- fBodyGyro-X
			- fBodyGyro-Y
			- fBodyGyro-Z
			- fBodyAccMag
			- fBodyAccJerkMag
			- fBodyGyroMag
			- fBodyGyroJerkMag
	- Activity label.
		- 1 WALKING
		- 2 WALKING_UPSTAIRS
		- 3 WALKING_DOWNSTAIRS
		- 4 SITTING
		- 5 STANDING	
		- 6 LAYING
	- Identifier of the subject who carried out the experiment.
- Transformations performed by run_analysis.R
	1. Subset mean ("mean()") and standard deviation ("std()") for each of the 33 measurements, e.g. tBodyAcc-mean()-X, tBodyAcc-std()-X...
	2. Combine training subject labels, activity labels, and measurements
	3. Subset mean ("mean()") and standard deviation ("std()") for each of the 33 measurements, e.g. tBodyAcc-mean()-X, tBodyAcc-std()-X...
	4. Combine testing subject labels, activity labels, and measurements
	5. rbind together the training and test data into one data frame
	6. Determine the average value of each of the 66 measurements for each subject's replicate activity data. E.g. Subject 1 performed activity 5 27 times, get the average for each of the 66 measurements for all 27 replicates.
		1. Split the full_data data frame by subject and activity
		2. Determine means of each measurement from split data by function that will take the incoming split as a data frame (i.e. measurements split by subject and activity) and determine the means for each column of measurements.
		3. Get means of each replicate of subject's activity
  		4. Coerce mean result vector into a matrix in order to transpose it.
		5. Coerce the matrix into a data frame to be appended later.
		6. Return this data as a horizontal row for use with rbind  
	7. Apply the above funtion for each split and return as a list of data frames
	8. Row bind (rbind) together all the data frames in the list into a single data frame
	9. Eliminate the row names because they are uninformative
	10. Get rid of "illegal" characters in column name such as parentheses and hyphens. Get rid of parentheses and turn hyphens into underscores.
	11. Renaming the column names to be consistent with the treatment applied, i.e. since the mean of all tBodyAcc_mean_X measurements have been calculated, change name to mean_of_tBodyAcc_mean_X
	12. Use descriptive activity names instead of the numbers

---
