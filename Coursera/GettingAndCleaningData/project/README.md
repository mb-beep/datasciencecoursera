# "Getting and Cleaning Data" project repo

This readme file contains information on how to use the following repo.

## Intro
This repo basically consists of the data used, and the **run_analysis.R** script for combining, cleaning and writing the data into a tidy data set **tidy_UCI_HAR_data.txt**. Further, the **CodeBook.md** file explains which steps were taken to get to the final tidy data set **tidy_UCI_HAR_data.txt**.

## Credits
All the data found in either the .zip file (**prj.zip**) or the *UCI_HAR_Dataset* folder has been collected by *Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio* and *Luca Oneto* at the **Smartlab - Non Linear Complex Systems Laboratory** in **Genoa, Italy**, and is not for commercial use.

## Information on the data and script
The data comes from experiments that have been carried out with a group of 30 volunteers within an age bracket of 19 - 48 years. Each person performed six activities (**WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING**) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, *Jorge L. Reyes-Ortiz et al.* captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50 Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The **run_analysis.R** script uses basically the data from the *UCI_HAR_Dataset* folder and merges the training data (70%) and test data (30%) (found in *UCI_HAR_Dataset/train/X_train.txt* and *UCI_HAR_Dataset/test/X_test.txt*, respectively) as well as the subjects (found in *UCI_HAR_Dataset/train/subject_train.txt* and *UCI_HAR_Dataset/test/subject_test.txt*) of the different sets and the activities (found in *UCI_HAR_Dataset/train/y_train.txt* and *UCI_HAR_Dataset/test/y_test.txt*), which were performed by the subjects. The labels to the activities can be found in the **UCI_HAR_Dataset/activity_labels.txt** file.
This data is combined into a new dataset, while the feature names found in the **UCI_HAR_Dataset/features.txt** file are used as the column names.

From this new dataset, the columns containing the measurements on the mean and standard deviation for each measurement are extracted and a new independent tidy dataset with the average of each variable for each activity and each subject is created and written into the **tidy_UCI_HAR_data.txt** file.

For more information on the data check the **README.txt** in the *UCI_HAR_Dataset* folder or the **CodeBook.md** file.
