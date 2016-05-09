# README.md

---
title: 'README - GetCleanData: Samsung Galaxy S Human Activity Recognition'
author: "Maurice E. Beckles"
date: "May 8, 2016"
---

## run_analysis.R
This is an R script which reads data from the UCI HAR dataset available from [here!](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) with descriptive information located [here!](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### Required data files
Within the uncompressed data files the following are processed by this script:
        - train/X_train.txt
        - train/y_train.txt
        - train/subject_train.txt
        - test/X_test.txt
        - test/y_test.txt
        - test/subject_test.txt
        - features.txt
> Additional data files provide additiona meta information regarding the overall shape and features of the dataset.

### Processing
The script goes through five (5) main processing phases as indicated by comments in the script:
        1. Merging the training and tests datasets into a new dataset and assigning initial variable names
        2. Extracts the mean and standard deviation (sd) columns only for each measurement
        3. Applies descriptive activity names to the dataset and formats them as factor variables
        4. Refine variable names to make them more readable
        5. Create a second dataset incorporating subject data summarizing on activity means for each subject

### Post Processing
The script outputs a single datafile containing the information summary created in step 5 above called **iTidy.txt**.
        
        
