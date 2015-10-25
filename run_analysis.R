# Load libraries
library(dplyr)
library(data.table)

humanActivity <- data.table()

# Read features and activities
features <- data.table(read.table("features.txt"))
setnames(features, c("V1", "V2"), c("id", "label"))
activities <- data.table(read.table("activity_labels.txt"))
setnames(activities, c("V1", "V2"), c("activity", "activity.label"))

# Read test subject
subjectTest <- data.table(read.table("./test/subject_test.txt"))

# Read test labels
yTest <- data.table(read.table("./test/y_test.txt"))

# Read test set
xTest <- data.table(read.table("./test/X_test.txt"))

# 4. Appropriately labels the data set with descriptive variable names. 
setnames(subjectTest, c("V1"), c("subject"))
setnames(yTest, c("V1"), c("activity"))
setnames(xTest, paste("V",c(1:561), sep = ""), as.character(features$label))

testData <- data.table(subjectTest, yTest, xTest)

# Read subject
subjectTrain <- data.table(read.table("./train/subject_train.txt"))

# Read train labels
yTrain <- data.table(read.table("./train/y_train.txt"))

# Read train set
xTrain <- data.table(read.table("./train/X_train.txt"))

# 4. Appropriately labels the data set with descriptive variable names. 
setnames(subjectTrain, c("V1"), c("subject"))
setnames(yTrain, c("V1"), c("activity"))
setnames(xTrain, paste("V",c(1:561), sep = ""), as.character(features$label))

trainData <- data.table(subjectTrain, yTrain, xTrain)

# 1. Merges the training and the test sets to create one data set.
humanActivity <- rbind(testData, trainData)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
humanActivity <- select(humanActivity, matches("subject|activity|mean|std"))

# 3. Uses descriptive activity names to name the activities in the data set
humanActivity <- humanActivity %>%
    left_join(activities) %>%
    mutate(activity = activity.label) %>%
    select(-activity.label)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidyData <- humanActivity[, lapply(.SD,mean), by=c("activity", "subject")]
write.table(tidyData, file = "tidy_data.txt", row.names = FALSE)
