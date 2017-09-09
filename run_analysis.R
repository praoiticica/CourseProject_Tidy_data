#####  Course Project Tidy Data  ##############
# Getting and Cleaning Data ################
# Data Science Specialization ############
# Coursera - John Hopkins University####
# Pedro Ramon Almeida - 08/2017######

setwd("C:/Users/praoi/Documents/Coursera/Getting and Cleaning Data/CourseProject_Tidy_data/")

library(dplyr)
# Download the dataset. This process takes some minutes...

#source("Download2.0.R")

# Assign period under quotes "." to dir if you want to save the file in
# your current wirkdirectory.
dir<-"."
filedir1<-file.path(dir, "Dataset.zip")
fileUrl1<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(dir=="."){
  dir=getwd()
  print("file will br saved in the current directory")
}else if(!dir.exists(dir)){dir.create(dir,recursive = TRUE)
  print("Data directory created in the current workdir...")}else{
    print("The data folter already exists!")
  }

## Download and unzip the raw dataset.

#if(!file.exists(filedir) & !file.exists(file.path(dir, "household_power_consumption.txt"))) {
if(!file.exists(filedir1) ) {
  
  download.file(fileUrl1,filedir1 , mode = "wb")
  unzip(filedir1, exdir = dir)
}else{
  print("The file is already download and unziped!")
}

cat("The files \"xxxxxxxxxxxxxx\" was downloaded and unziped to the direcrory!")



# Step 1:  1. Merges the training and the test sets to create one data set.

## Load Features, ans activivy labels and names.
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activityID","activity_name"))
features_labels<-read.table("./UCI HAR Dataset/features.txt", col.names = c("featureID","feature"), stringsAsFactors = FALSE)

##Load train and colum bind
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = "subjectID")
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features_labels[,2])
# the headers won't be the same but...
#colnames(x_train)<-features_labels[,2] << this is not a good idea!
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activityID")
train_set<-cbind(subject_train,y_train,x_train)

# Load test and column bind all
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subjectID")
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features_labels[,2])
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activityID")
test_set<-cbind(subject_test,y_test,x_test)

## Merging process
merged_set<-arrange(merge(train_set,test_set, all=TRUE),subjectID)


# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

meancols<-grep("mean", colnames(merged_set))
stdcols<- grep("std", colnames(merged_set))
mean_std_set<-merged_set%>%select(1,2,meancols,stdcols)


# Step 3: Uses descriptive activity names to name the activities in the data set

merged_set<-merge(merged_set,activity_labels, by="activityID")
merged_set<-merged_set%>%select(activity_name,everything(),-activityID)


# Step 4: Appropriately labels the data set with descriptive variable names.

abbrav_names<-names(merged_set)
abbrav_names <- make.names(abbrav_names)

abbrav_names <- gsub('mad',"MedianAbsDeviation",abbrav_names)
abbrav_names <- gsub('arCoeff',"Autorregresion coefficients_Burg=4",abbrav_names)
abbrav_names <- gsub('iqr',"InterquartileRange",abbrav_names)
abbrav_names <- gsub('Acc',"Acceleration",abbrav_names)
abbrav_names <- gsub('GyroJerk',"AngularAcceleration",abbrav_names)
abbrav_names <- gsub('Gyro',"AngularSpeed",abbrav_names)
abbrav_names <- gsub('Mag',"Magnitude",abbrav_names)
abbrav_names <- gsub('^t',"TimeDomain.",abbrav_names)
abbrav_names <- gsub('^f',"FrequencyDomain.",abbrav_names)
abbrav_names <- gsub('\\.std',".StandardDeviation",abbrav_names)
abbrav_names <- gsub('Freq\\.',"Frequency.",abbrav_names)
abbrav_names <- gsub('Freq$',"Frequency",abbrav_names)
abbrav_names <- gsub('iqr',"InterquartileRange",abbrav_names)
abbrav_names<-gsub('\\.\\.\\.',".-",abbrav_names)
#abbrav_names
full_names<-abbrav_names

colnames(merged_set)<-full_names


# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.

tidy_avg_set<-merged_set%>%group_by(activity_name,subjectID)%>%summarise_all(mean)

tidyset<-as.data.frame(tidy_avg_set)
write.table(tidyset, "tidyset.txt", row.name=FALSE)

## Ok done!

