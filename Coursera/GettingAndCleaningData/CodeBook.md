---
output:
  html_document:
    keep_md: yes
---
"Getting and Cleaning Data" project codebook
===

This document describes the steps to fulfill the following tasks of the "Getting and Cleaning Data" project and explains the **run_analysis.R** script:

1. Merge the training and the test set to create one dataset
2. Extract only the measurements on the mean and standard deviation for each measurement
3. Use descriptive activity names to name the activities in the dataset
4. Appropriately label the dataset with descriptive variable names
5. Create a second, independent tidy dataset with the average of each variable for each activity and each subject

## Read in part

The first thing to do is to read in the trainings and test set into R and merge them with the **subjects** and **activities**. Hence all the trainings data, subjects and activities were merged with the test data, subjects and activities after a successful read in using the following code:


```r
# read in trainings set
xtrain <- read.table("./project/UCI HAR Dataset/train/X_train.txt");
# read in labels of trainings set
ytrain <- read.table("./project/UCI HAR Dataset/train/Y_train.txt");
# read in subjects of trainings set
subjecttrain <- read.table("./project/UCI HAR Dataset/train/subject_train.txt");

# read in testing set
xtest <- read.table("./project/UCI HAR Dataset/test/X_test.txt");
# read in labels of testing set
ytest <- read.table("./project/UCI HAR Dataset/test/Y_test.txt");
# read in subjects of testint set
subjecttest <- read.table("./project/UCI HAR Dataset/test/subject_test.txt");

# read in features
features <- read.table("./project/UCI HAR Dataset/features.txt", stringsAsFactors = F);

# read in activity labels for proper renaming of activities column
#  and do not use strings as factors, remove first column
activities <- read.table("./project/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = F);
activities <- activities[,2];
```

## Cleaning and merging

In the next step, the features are cleaned by removing parentheses. Additionally all trainings and test set data (this includes subjects and activities) are merged and the columns renamed according to the features, finally only the measurements on the mean and standard deviation for each measurement were extracted:


```r
# clean features by removing 1st column and remove 
#  dashes, and parentheses
features <- features[,2];
features <- gsub("-", "", features);
features <- gsub("[()]", "", features);

# rbind train and test set, use feature names as column names
m <- rbind(xtrain, xtest);
names(m) <- features;

# rbind subjects and labels of trainings and test set, and
#  merge them temporary, then use cbind for adding to dataset m
mergedsubjects <- rbind(subjecttrain, subjecttest);
mergedlabels <- rbind(ytrain, ytest);
m <- cbind(mergedsubjects, mergedlabels, m);

# get indices of mean and std variables and extract
#  them from the dataset m (use c(bind)) for preventing
#  the removal of 1st and 2nd column (subjects and labels))
msindices <- grep("([Mm]ean|[Ss]td)", names(m));
m <- m[, c(1, 2, msindices)];
```

## Giving appropriate names

In the following step, the names are modified for a better readability and the activities in column number 2 are substituted by the activitiy labels:

1. WALKING  
2. WALKING_UPSTAIRS  
3. WALKING_DOWNSTAIRS  
4. SITTING  
5. STANDING  
6. LAYING  


```r
# using correct indices and names function, rename
#  1st and 2nd column approriately, and change names
#  to lowercase
names(m)[1] <- "Subject";
names(m)[2] <- "Activity";
#names(m) <- tolower(names(m));

# use "mapvalues" from "plyr" package for renaming the activity column
m[,2] <- mapvalues(m[,2], from = c(1,2,3,4,5,6), to = c(activities));
```


## Creating new dataset and writing

In the final step, a new dataset was created using first the melt function and recasting the melted dataset in a new shape and writing it into **tidy_UCI_HAR_data.txt**


```r
# make tidy dataset by using "melt" function and reshape data using
#  "dcast" function, additionally apply mean with the help of "dcast",
#  then change names for better readability in written table using "gsub"
meltedm <- melt(m, id = c("Subject", "Activity"));
tidym <- dcast(meltedm, Subject + Activity ~ variable, mean);
names(tidym) <- gsub(",", "", names(tidym));
names(tidym) <- gsub("mean", "Mean", names(tidym));
names(tidym) <- gsub("std", "Std", names(tidym));
names(tidym) <- gsub("gravity", "Gravity", names(tidym));

#  finally write this new dataset into "tidy_UCI_HAR_data.txt" using "write.table"
write.table(tidym, file = "./project/tidy_UCI_HAR_data.txt", row.name = F);
```

## Result

The resulting dataset consists of the following columns:

* Subject: ID of subject (in total 30 volunteers)
* Activity: activity performed by subject wearing Samsung Galaxy S II 
    + WALKING  
    + WALKING_UPSTAIRS  
    + WALKING_DOWNSTAIRS  
    + SITTING  
    + STANDING  
    + LAYING  
* 86 variables on mean times/frequencies/angles and the standard deviations which belong to each time/frequency/angle, collected from the gyroscope and accelerometer

```r
activities
```

```
## [1] "WALKING"            "WALKING_UPSTAIRS"   "WALKING_DOWNSTAIRS"
## [4] "SITTING"            "STANDING"           "LAYING"
```
asdfasdfasdfasdfasdf
