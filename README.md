## Getting and Cleaning Data - Course Project - Tidy data set.

This repository hosts the R code and documentation files of the Course Project - Tidy data developped in the course "Getting and Cleaning Data". This course is part of the "Data Science" Specialization of John Hopkins University on coursera.

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones or [click here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the Ram dataset for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
or [click here to download the Raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


##Files and codes

All files and folders of the data used for the project were already downloaded and unziped in the presente repo. CodeBook.md describes the variables, the data, and any transformations or work that was performed to make the date tidy and clean to any analysis. The code run_analysis.R contains all the script to perform the analyses described in the following 5 steps.


* Step 1. Merges the training and the test sets to create one data set.
* Step 2. Extracts only the measurements on the mean and standard deviation for      each measurement.
* Step 3. Uses descriptive activity names to name the activities in the data set.
* Step 4. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
* Step 4. Appropriately labels the data set with descriptive variable names.
* Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## What the code do for you?

The code run_analysis.R get the raw dataset clear it and transform it into a tidy dataset. as the result of the 5 step processes the run_analysis.R generates a .txt file called "tidy_data_set.txt".


date: 08-2017<br />
**author: Pedro Ramon Almeida Oiticica<br />**
e-mail: praoiticica@gmail.com<br />

All rights reserved.