## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each 
##    measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each 
##    variable for each activity and each subject.

library(data.table)
library(dplyr)

# load features and activity label data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

# load test data
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(x_test) = features[,2]
names(subject_test) = "subject"
names(y_test) = "activity"

test_data <- cbind(subject_test, y_test, x_test)

# load train data
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(x_train) = features[,2]
names(subject_train) = "subject"
names(y_train) = "activity"

train_data <- cbind(subject_train,y_train, x_train)

## 1. Merge the train and test data sets to create one data set
merged_data <- rbind(train_data, test_data)

## 2. Extracts only the measurements on the mean and standard deviation for each 
## measurement.

# find mean and std columns by their names 
cols_of_interest <- grepl("mean|std", names(merged_data)) 

#preserve subjectID and activity columns
cols_of_interest[1:2] <- TRUE

# get only the necessary columns
merged_data <- merged_data[,cols_of_interest]

## 3: Uses descriptive activity names to name the activities in the data set.
merged_data$activity <- factor(merged_data$activity, labels = c("Walking",
        "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing",
        "Laying"))

## 4. Appropriately labels the data set with descriptive activity names.
names(merged_data) <- gsub("^t", "time", names(merged_data))
names(merged_data) <- gsub("Freq", "Frequency", names(merged_data))
names(merged_data) <- gsub("^f", "frequency", names(merged_data))
names(merged_data) <- gsub("std", "Standard", names(merged_data))
names(merged_data) <- gsub("mean", "Mean", names(merged_data))
names(merged_data) <- gsub("Acc", "Accelerometor", names(merged_data))
names(merged_data) <- gsub("Gyro", "GyroScope", names(merged_data))
names(merged_data) <- gsub("Mag", "Magnitude", names(merged_data))
names(merged_data) <- gsub("BodyBody", "Body", names(merged_data))

## 5. Creates a second, independent tidy data set with the average of each 
##    variable for each activity and each subject.
dt <- data.table (merged_data)
tidy_data <- dt[,lapply(.SD,mean),by="activity,subjectID"]
write.table(tidy_data,file="tidy_data.txt",row.names = FALSE)


## Produce Code Book
library(knitr)
knit2html("codebook.Rmd");
