## R Course Project: Getting and Cleaning Data ##

## Set WD
setwd("~/Desktop/Shared/dev/R/R-assignments")

#1 Merge training & test into one dataset
library(plyr)

fitdata <- read.table("./UCI\ HAR\ Dataset/train/X_train.txt")
traindata <- read.table("./UCI\ HAR\ Dataset/test/X_test.txt")
fitdata <- rbind(fitdata, traindata)

#1.1 Cleanup metadata (columns)
# Collect supplied variable names
varNames <- read.table("./UCI\ HAR\ Dataset/features.txt")

# Fix duplicate / invalid variable names & rename df columns 
names(fitdata) <- make.names(varNames$V2, unique = TRUE)


#2 Extract only the measurements on the mean and sd for each measurement
library(dplyr)
fitmeanstdata <- select(fitdata, matches("[Mm]ean[.]{1,3}[A-Z\\.]{,1}|[Mm]ean[.]$|std[.]{1,3}")) #cols w/label mean or std
# regex tests: "[Mm]ean[.]{1,3}[A-Z\\.]{,1}|[Mm]ean[.]$|std[.]{1,3}"  "[Mm]ean[.]{1,3}|std[.]{1,3}"

#3 Use descriptive activity names for dataset
activities <- read.table("./UCI\ HAR\ Dataset/train/y_train.txt")
activitiesTest <- read.table("./UCI\ HAR\ Dataset/test/y_test.txt")
activities <- rbind(activities, activitiesTest) # add activities from (test set)
activities$V1 <- as.factor(activities$V1)
levels(activities$V1) <- c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")

fitmeanstdata$activity <- activities$V1

#4 Appropriately label the dataset with descriptive variable names
# ... Variable names already assigned and validated in 1.1
# ... Further cleanup to remove '.'s below
names(fitmeanstdata) <- gsub("[.]*", "", names(fitmeanstdata))


#5 Create second data set with averages for each activity and each subject
# Add subject data to df
subjects <- read.table("./UCI\ HAR\ Dataset/train/subject_train.txt")
subjectsTest <- read.table("./UCI\ HAR\ Dataset/test/subject_test.txt")
subjects <- rbind(subjects, subjectsTest) # add subjects from (test set)
subjects$V1 <- as.factor(subjects$V1)

fitmeanstdata$subjects <- subjects$V1

iTidy <- fitmeanstdata %>% group_by(subjects, activity) %>% summarise_each(funs(mean)) 
write.table(iTidy, "./iTidy.txt", row.names = FALSE)

