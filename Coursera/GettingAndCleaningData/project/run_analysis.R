# script for fulfilling the project requirements of the
#  'Getting and Cleaning Data' course offered from the
#  Johns Hopkins University at coursera.org

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

# using correct indices and names function, rename
#  1st and 2nd column approriately, and change names
#  to lowercase
names(m)[1] <- "Subject";
names(m)[2] <- "Activity";
#names(m) <- tolower(names(m));

# read in activity labels for proper renaming of activities column
#  and do not use strings as factors, remove first column
activities <- read.table("./project/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = F);
activities <- activities[,2];

# use "mapvalues" from "plyr" package for renaming the activity column
m[,2] <- mapvalues(m[,2], from = c(1,2,3,4,5,6), to = c(activities));

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
