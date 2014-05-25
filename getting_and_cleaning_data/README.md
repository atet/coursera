#Getting and Cleaning Data Course Project
##README.md
---

- Purpose
	- Munge (i.e. to transform data from raw to "tidy") data from the Human Activity Recognition (HAR) Using Smartphones Dataset Version 1.0 (Reyes-Ortiz et al.).
- Files included in this repos
	- run_analysis.R - Script to munge raw HAR data.
	- README.md - Introductory information about repos and project.
	- CodeBook.md - Describes variables, the data, and any transformations run_analysis.R performs to clean up HAR data.
	- **NOTE: The HAR data set is not included in this repos**, but is located at: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
- High level goals of run_analysis.R
	1. Merge training and testing data.
	2. Extract only the mean and standard deviation values for each of the 33 measurements.
	3. For each subject's measurement of a particular activity, calculate the mean of those values, e.g. subject 1 performed activity 5 27 times, calculate the mean for each of the 66 measurements (mean and standard deviation) for all 27 replicates.
	4. Relabel measurements to reflect the treatment from step 3.
	5. Relabel activities from numbers to descriptive terms (e.g. from 1 to "WALKING").
- Data Description (adapted from Reyes-Ortiz et al.)
	- Thirty volunteers within an age bracket of 19-48 years.
	- Six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) tracked by smartphone (Samsung Galaxy S II).
	- Using smartphone's embedded accelerometer and gyroscope to capture 3-axial linear acceleration and 3-axial angular velocity at a constant 50Hz.
	- Experiments video-recorded to label the data manually.
	- Dataset has been randomly partitioned into two sets, where 70% training data and 30% the test data.
	- Signals pre-processed with noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window).
	- Acceleration signal (gravitational and body motion components), separated by Butterworth low-pass filter into body acceleration and gravity.
	- Gravitational force assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency used.
	- From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
	- **Further description of data and treatments described in CodeBook.md**
---
