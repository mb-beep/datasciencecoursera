# "Getting and Cleaning Data" project repo

This readme file contains information on how to use the following repo.

## Intro
This repo basically consists of the data used, and the _run_analysis.R_ script for combining, cleaning and writing the data into a tidy data set _tidy_UCI_HAR_data.txt_. Further, the _CodeBook.md_ file explains which steps were taken to get to the final tidy data set _tidy_UCI_HAR_data.txt_.

## Credits
All the data found in either the .zip file (_prj.zip_) or the _UCI_HAR_Dataset_ folder has been collected by _Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio_ and _Luca Oneto_ at the _Smartlab - Non Linear Complex Systems Laboratory_ in Genoa, Italy, and is not for commercial use.

## Information on the data and script
The data comes from experiments that have been carried out with a group of 30 volunteers within an age bracket of 19 - 48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, _Jorge L. Reyes-Ortiz et al._ captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50 Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The _run_analysis.R_ script uses basically the data from the _UCI_HAR_Dataset_ folder and merges the training data (70%) and test data (30%) (found in _UCI_HAR_Dataset/train/X_train.txt_ and _UCI_HAR_Dataset/test/X_test.txt_, respectively) as well as the subjects (found in _UCI_HAR_Dataset/train/subject_train.txt_ and _UCI_HAR_Dataset/test/subject_test.txt_) of the different sets and the activities (found in _UCI_HAR_Dataset/train/y_train.txt_ and _UCI_HAR_Dataset/test/y_test.txt_), which were performed by the subjects. The labels to the activities can be found in the _UCI_HAR_Dataset/activity_labels.txt_ file.
This data is combined into a new dataset, while the feature names found in the _UCI_HAR_Dataset/features.txt_ file are used as the column names.

From this new dataset, the columns containing the measurements on the mean and standard deviation for each measurement are extracted and a new independent tidy dataset with the average of each variable for each activity and each subject is created and written into the _tidy_UCI_HAR_data.txt_ file.
