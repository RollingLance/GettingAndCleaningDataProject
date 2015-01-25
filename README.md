# GettingAndCleaningDataProject

Input Data:
* UCI HAR Dataset
* Not all files in this dataset are used in this project. We used the following ones:
	./UCI HAR Dataset/train/subject_train.txt
	./UCI HAR Dataset/train/y_train.txt
	./UCI HAR Dataset/train/X_train.txt
	./UCI HAR Dataset/test/subject_test.txt
	./UCI HAR Dataset/test/y_test.txt
	./UCI HAR Dataset/test/X_test.txt
	./UCI HAR Dataset/features.txt
	./UCI HAR Dataset/activity_labels.txt

Output Data:
*./tidy_project_data.txt

Methodology:
* Training and Test data are combined together by row binding. Also each row we add subject ID and activity ID corresponding to those features.
* Then we extract only the features(columns) which measures mean and standard deviation for each measurement. 
* A new column activity_name is then added.
* Those feature columns are given appropriate names.
* Feature columns are grouped by activity and subject; and averages of feature columns are calculated for each activity and subject group.
	
