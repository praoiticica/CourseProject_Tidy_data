#####  Course Project Tidy Data  ##############
# Getting and Cleaning Data ################
# Data Science Specialization ############
# Coursera - John Hopkins University####
# Pedro Ramon Almeida - 08/2017######

setwd("C:/Users/praoi/Documents/Coursera/Getting and Cleaning Data/CourseProject_Tidy_data/")

library(dplyr)
# Download the dataset. This process takes some minutes...

source("Download2.0.R")

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


  mean_std<-function(){
      # Step 1:  1. Merges the training and the test sets to create one data set.
      
      ##Load train and colum bind
      subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
      x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
      y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
      train_set<-cbind(subject_train,y_train,x_train)
      
      # Load test and column bind.
      subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
      x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
      y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
      test_set<-cbind(subject_test,y_test,x_test)
      
      ## Merging test and train
      merged_set<-rbind(train_set,test_set)
      
      ## Load Features, ans activivy labels and names.
      activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activityid","activity_name"))
      features_labels<-read.table("./UCI HAR Dataset/features.txt", col.names = c("featureid","feature vectors"), stringsAsFactors = FALSE)
      
      # name the columns of the merged set with the feature vector abbreviations.
      colnames(merged_set)<-c("subject","activityid", make.unique(features_labels[,2]))
      
      
      # Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
      
      meancols<-grep("[Mm]ean", colnames(merged_set))
      stdcols<- grep("std", colnames(merged_set))
      mean_std_set<-merged_set%>%select(subject,activityid,meancols,stdcols)
      
      # Step 3: Uses descriptive activity names to name the activities in the data set
      
      tidy_mean_std<-merge(mean_std_set,activity_labels, by="activityid")
      tidy_mean_std<-tidy_mean_std%>%select(activity_name,everything(),-activityid)

      tidy_mean_std
      }
      
  
tidy_mean_std<-mean_std()


# Step 4: Appropriately labels the data set with descriptive variable names.

abbrav_names<-names(tidy_mean_std)
abbrav_names <- make.names(abbrav_names)

abbrav_names<-gsub('\\.\\.\\.',"-",abbrav_names)
abbrav_names<-gsub('\\.\\.',"",abbrav_names)
abbrav_names <- gsub('Freq\\.',"Frequency_1",abbrav_names)
abbrav_names<-gsub('\\.',"_",abbrav_names)
abbrav_names <- gsub('^t',"Time.Domain_",abbrav_names)
abbrav_names <- gsub('^f',"Frequency.Domain_",abbrav_names)
abbrav_names <- gsub('_t',"_Time.Domain_",abbrav_names)
abbrav_names <- gsub('_f',"_Frequency.Domain_",abbrav_names)
abbrav_names <- gsub('Acc',".Acceleration",abbrav_names)
abbrav_names <- gsub('Gyro',".Angular.Speed",abbrav_names)
abbrav_names <- gsub('GyroJerk',".Angular.Acceleration",abbrav_names)
abbrav_names <- gsub('[Mm]ag',"_Median.Absolute.Deviation",abbrav_names)
abbrav_names <- gsub("_$","",abbrav_names)
abbrav_names <- gsub('Freq$',".Frequency",abbrav_names)
abbrav_names <- gsub('\\.std',".Standard.Deviation",abbrav_names)

#abbrav_names
full_names<-abbrav_names
colnames(tidy_mean_std)<-full_names


# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.

tidy_set<-tidy_mean_std%>%group_by(activity_name,subject)%>%summarise_all(mean)%>%mutate(point=row_number())

write.table(tidy_set, "tidy_set.txt", row.name=FALSE)

## Ok done!

