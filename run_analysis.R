# 1. Merges the training and the test sets to create one data set.
train_data <- cbind(read.table("./UCI HAR Dataset/train/subject_train.txt", col.names=c("subject")),
                    read.table("./UCI HAR Dataset/train/y_train.txt", col.names=c("activity")),
                    read.table("./UCI HAR Dataset/train/X_train.txt") )

test_data <- cbind(read.table("./UCI HAR Dataset/test/subject_test.txt", col.names=c("subject")),
                    read.table("./UCI HAR Dataset/test/y_test.txt", col.names=c("activity")),
                    read.table("./UCI HAR Dataset/test/X_test.txt") )

har_data <- rbind(train_data, test_data)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features = read.table("./UCI HAR Dataset/features.txt")

feature_mean_std <- c(features[grep("mean\\(\\)", features$V2), "V1"],
                          features[grep("std\\(\\)", features$V2), "V1"] )

har_mean_std_data <- har_data[, sort(c(c(1, 2), (feature_mean_std +2))) ]

# 3. Uses descriptive activity names to name the activities in the data set
activities = read.table("./UCI HAR Dataset/activity_labels.txt", 
                            col.names=c("activity", "activity_name"),) 

har_mean_std_data_names <- merge(activities, har_mean_std_data, by.x="activity", by.y="activity")

# 4. Appropriately labels the data set with descriptive variable names. 
selected_features <- features[sort(feature_mean_std),]

selected_features$V2 <- gsub("\\(\\)", "", selected_features$V2)

colnames(har_mean_std_data_names) <- c(c("activity", "activity_name", "subject"), selected_features$V2)

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
aggdata <-aggregate(har_mean_std_data_names[,!(names(har_mean_std_data_names) %in% c("activity", "activity_name", "subject"))], 
                    by=list(activity=har_mean_std_data_names$activity, 
                            activity_name=har_mean_std_data_names$activity_name, 
                            subject=har_mean_std_data_names$subject), 
                    FUN=mean, 
                    na.rm=TRUE)

write.table(aggdata, file="./tidy_project_data.txt", row.names=FALSE, sep = ",")
