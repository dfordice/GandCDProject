# GandCDProject
## Getting and Cleaning Data - Coursera Project
There is a script called run_analysis.R that performs the following:
* Tests for the existence of at least one of the necessary data files in the working directory beforer proceeding
* Merges the training and the test sets to create one data set (HAR_Total).
* Extracts only the measurements on the mean and standard deviation for each measurement (HAR_Selected). 
* Uses descriptive activity names to name the activities in the data set (activity_labels)
* Appropriately labels the data set with descriptive variable names (see CodeBook.MD). 
* From the data set in step 4 (HAR_Selected), creates a second, independent tidy data set with the average of each variable for each activity and each subject
* The tidy data set (HAR_Summarized) is then written to a text file named "TidyTable.txt" in the working directory.