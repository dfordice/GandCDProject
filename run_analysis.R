## Run Analysis on the UCI HAR Dataset
run_analysis <- function()

        ## Check to see if one of the files from the dataset is in the working directory
        if(!file.exists("./features.txt")) return("Data Set Does Not Exist")
## Create data.frames from activity labels and features files
features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")
## Convert activity_label into a factor variable
activity <- factor(activity_labels[[2]])
## Convert features into a vector of variable names for columns
varNames <- as.vector(features[[2]])
## Remove the parentheses and hyphens from the variable names
varNames <- gsub("[()]", "", varNames)
varNames <- gsub("-", ".", varNames)

## Read the test data sets
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

## Label the X_test columns with the features
colnames(X_test) <- varNames

## Add the subject and activity data
colnames(subject_test) <- "Subject"
colnames(y_test) <- "Activity"
HAR_test <- cbind(subject_test, y_test, X_test)

## Repeat for the train data sets
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

## Label the X_test columns with the features
colnames(X_train) <- varNames

## Add the subject and activity data
colnames(subject_train) <- "Subject"
colnames(y_train) <- "Activity"
HAR_train <- cbind(subject_train, y_train, X_train)

## combine the data sets
HAR_total <- rbind(HAR_test, HAR_train)

## create a column list to include Subject, Activity, Mean and Std
meancols <- grep("mean", features[[2]], value = FALSE)
stdcols <- grep("std", features[[2]], value = FALSE)
cols_to_use <- sort(c(1, 2, meancols+2, stdcols+2))

## Select only the columns we want for grouping and place them in a data frame
HAR_Selected <- HAR_total[, cols_to_use]

## Apply the Activity Levels for grouping
HAR_Selected$Activity <- factor(HAR_Selected$Activity, labels = activity)

## Create a summarized table using aggregate averaging the measurements by both Activity and Subject
HAR_Summarized <- aggregate(HAR_Selected[,3:81], list(HAR_Selected$Activity, HAR_Selected$Subject), FUN=mean)
names(HAR_Summarized)[1:2] <- c("Subject", "Activity")

## Writing to a text file.
write.table(HAR_Summarized, file = "./TidyTable.txt", row.names = FALSE)

## Return the name of the text file
return("The file is in the working directory with the name TidyTable.txt")